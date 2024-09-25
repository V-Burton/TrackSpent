// The original content is temporarily commented out to allow generating a self-contained demo - feel free to uncomment later.

import 'package:flutter/material.dart';
import 'package:full_flutter/pages/outcome_page.dart';
import 'package:full_flutter/pages/sort_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:full_flutter/pages/database.dart';
import 'package:provider/provider.dart'; 

import 'pages/income_pages.dart';
import 'pages/spent.dart';

// import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SpentModel()),
      ],
      child: const MyApp(),
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


  @override
  void initState() {
    super.initState();
    _checkAuthentication();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<SpentModel>(context, listen: false).initializeDummyData();
    });
  }

  Future<void> _checkAuthentication() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');

    setState(() {
      _isAuthenticated = token != null;
    });
  }

  setCurrentIndex(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_isAuthenticated) {
      return MaterialApp(
        home: AuthPage(), // Redirige vers la page d'authentification
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
