import 'package:flutter/material.dart';
import 'package:full_flutter/pages/outcome_page.dart';
import 'package:full_flutter/pages/sort_page.dart';
import 'package:full_flutter/pages/database.dart';
import 'package:provider/provider.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_web_auth_2/flutter_web_auth_2.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:math';
import 'package:crypto/crypto.dart';



import 'pages/income_pages.dart';
import 'pages/spent.dart';

const FlutterAppAuth appAuth = FlutterAppAuth();
final FlutterSecureStorage secureStorage = const FlutterSecureStorage();


const String clientId = 'sandbox-trackspent-f42a7b';
const String redirectUri = 'trackspent://auth/callback';
const String issuer = 'https://auth.truelayer-sandbox.com/';
final List<String> scopes = [
  'info',
  'accounts',
  'balance',
  'cards',
  'transactions',
  'direct_debits',
  'standing_orders',
  'offline_access',
];
final String scope = scopes.join(' ');


void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    ChangeNotifierProvider(
      create: (_) => SpentModel(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
    const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _currentIndex = 0;
  bool _isAuthenticated = false;
  bool _isAuthenticatedWithTrueLayer = false;
  // StreamSubscription? _sub;

  @override
  void initState() {
    super.initState();
    _checkAuthentication();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<SpentModel>(context, listen: false).initializeDummyData();
    });
  }

  // @override
  // void dispose() {
  //   _sub?.cancel();
  //   super.dispose();
  // }

  // @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _checkAuthentication();
    }
  } 

  Future<void> _exchangeAuthorizationCode(String code) async {
    final codeVerifier = await secureStorage.read(key: 'pkce_code_verifier');
    print('Échange du code d\'autorisation : $codeVerifier');

    // Votre code pour échanger le code d'autorisation contre un jeton d'accès
    final response = await http.post(
      Uri.parse('https://auth.truelayer-sandbox.com/connect/token'),
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      body: {
        'grant_type': 'authorization_code',
        'client_id': clientId,
        'client_secret': '369a3b87-3268-46b4-ac15-dcc5092de1a4',
        'redirect_uri': redirectUri,
        'code': code,
        'code_verifier': codeVerifier,
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final accessToken = data['access_token'];
      final refreshToken = data['refresh_token'];

      await secureStorage.write(key: 'access_token', value: accessToken);
      await secureStorage.write(key: 'refresh_token', value: refreshToken);

      setState(() {
        _isAuthenticatedWithTrueLayer = true;
      });
    } else {
      print('Échec de l\'échange du code... : ${response.body}');
      // Gérer l'erreur (afficher un message, etc.)
    }
  }

  Future<void> _checkAuthentication() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');

    setState(() {
      _isAuthenticated = token != null;
    });

    if (_isAuthenticated) {
      // Vérifiez si l'utilisateur est authentifié avec TrueLayer
      final accessToken = await secureStorage.read(key: 'access_token');
      if (accessToken == null) {
        setState(() {
          _isAuthenticatedWithTrueLayer = false;
        });
      } else {
        setState(() {
          _isAuthenticatedWithTrueLayer = true;
        });
      }
    }
  }

  setCurrentIndex(int index) async {
    setState(() {
      _currentIndex = index;
    });
  }


  Future<void> _authenticateWithTrueLayer() async {
    final String codeVerifier = _createCodeVerifier();
    final String codeChallenge = _createCodeChallenge(codeVerifier);
    print('Code verifier : $codeVerifier');
    await secureStorage.write(key: 'pkce_code_verifier', value: codeVerifier);
    final storedCodeVerifier = await secureStorage.read(key: 'pkce_code_verifier');
    print("Code verifier lu depuis secure storage : $storedCodeVerifier");


    final authorizationUrl = Uri.https(
      'auth.truelayer-sandbox.com',
      '/',
      {
        'response_type': 'code',
        'client_id': clientId,
        'redirect_uri': redirectUri,
        'scope': scope,
        'providers': 'uk-cs-mock uk-ob-all uk-oauth-all',
        'state': 'random_state_string',
        'code_challenge': codeChallenge,
        'code_challenge_method': 'S256',
      },
    );

    final urlString = authorizationUrl.toString();

    try {
      print('URL de redirection : $urlString');
      print('Schéma de callback : trackspent');
      // final result = await FlutterWebAuth2.authenticate(
      //   url: urlString,
      //   callbackUrlScheme: 'trackspent',
      // );
      final AuthorizationTokenResponse? result = await appAuth.authorizeAndExchangeCode(
      AuthorizationTokenRequest(
        clientId,
        redirectUri,
        issuer: 'https://auth.truelayer-sandbox.com/',
        scopes: scopes,
        serviceConfiguration: AuthorizationServiceConfiguration(
          authorizationEndpoint: 'https://auth.truelayer-sandbox.com/',
          tokenEndpoint: 'https://auth.truelayer-sandbox.com/connect/token',
        ),
        additionalParameters: {
          'providers': 'uk-cs-mock uk-ob-all uk-oauth-all',
        },
      ),
      );
      print('Résultat de l\'authentification : $result');

      final code = result;
      if (code != null) {
        await _exchangeAuthorizationCode(code.toString());
      }
    } catch (e) {
      print('Erreur lors de l\'authentification : $e');
    }
  }

  String _createCodeVerifier() {
    final random = Random.secure();
    return List.generate(128, (index) => random.nextInt(256)).map((e) => e.toRadixString(16)).join();
  }

  String _createCodeChallenge(String codeVerifier) {
    final bytes = utf8.encode(codeVerifier);
    final digest = sha256.convert(bytes);
    return base64UrlEncode(digest.bytes).replaceAll('=', '');
  }



  Future<void> _logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');

    // Supprimez les tokens TrueLayer
    await secureStorage.delete(key: 'access_token');
    await secureStorage.delete(key: 'refresh_token');

    setState(() {
      _isAuthenticated = false;
      _isAuthenticatedWithTrueLayer = false;
    });
  }


  @override
  Widget build(BuildContext context) {
    if (!_isAuthenticated) {
      return MaterialApp(
        home: AuthPage(), // Redirige vers la page d'authentification
      );
    }

    if (!_isAuthenticatedWithTrueLayer) {
      return MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: const Text('Connexion TrueLayer'),
          ),
          body: Center(
            child: ElevatedButton(
              onPressed: _authenticateWithTrueLayer,
              child: const Text('Connecter mon compte bancaire'),
            ),
          ),
        ),
      );
    }

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: [
            const Text("Sort"),
            const Text("Outcome"),
            const Text("Income"),
            ][_currentIndex],
            actions: [
              IconButton(
                icon: Icon(Icons.logout),
                onPressed: _logout,
                ),
            ],
        ),
        body: [
          const SortPage(),
          const OutcomePage(),
          const IncomePage(),
        ][_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) => setCurrentIndex(index),
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.green,
          items: const [
            BottomNavigationBarItem(
              icon: SizedBox.shrink(),
              label: "Sort"
            ),
            BottomNavigationBarItem(
              icon: SizedBox.shrink(),
              label: "Outcome"
            ),
            BottomNavigationBarItem(
              icon: SizedBox.shrink(),
              label: "Income"
            ),
          ]
        ),
      ),


    );
  }
}

//////////////////////////////////
/// Authentication ///////////////
//////////////////////////////////

class AuthPage extends StatefulWidget {
    const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoginMode = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isLoginMode ? 'Login' : 'Register'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isLoginMode ? _login : _register,
              child: Text(_isLoginMode ? 'Login' : 'Register'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _isLoginMode = !_isLoginMode;
                });
              },
              child: Text(_isLoginMode
                  ? 'Create an account'
                  : 'Already have an account? Login'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _register() async {
    final username = _usernameController.text;
    final password = _passwordController.text;
    final db_helper = DatabaseHelper();
    final result = await db_helper.registerUser(username, password);

    if (result > 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("User registered successfully")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to register user")),
      );
    }
  }

  Future<void> _login() async {
    final username = _usernameController.text;
    final password = _passwordController.text;

    final dbHelper = DatabaseHelper();
    final user = await dbHelper.authenticateUser(username, password);

    if (user != null) {
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('auth_token', 'dummy_token');  // Sauvegarde d'un jeton simulé
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Login successful")));

      // Rediriger l'utilisateur vers la page principale
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => MyApp()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Invalid credentials")),
      );
    }
  }
}
