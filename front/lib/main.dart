// The original content is temporarily commented out to allow generating a self-contained demo - feel free to uncomment later.

import 'package:flutter/material.dart';
import 'package:front/pages/outcome_page.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:front/pages/new_sort_page.dart';

import 'pages/income_pages.dart';
import 'pages/authentification.dart';

import 'package:front/src/rust/api/simple.dart';
import 'package:front/src/rust/frb_generated.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDir = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(appDocumentDir.path);
  await RustLib.init();
  initApp();

  var box = await Hive.openBox('user_tokens');

  bool isLoggedIn = box.containsKey('current_user');


  runApp(MyApp(isLoggedIn: isLoggedIn));
}

class MyApp extends StatefulWidget {
  final bool isLoggedIn;
  
  const MyApp({super.key, required this.isLoggedIn});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  final api = RustLib.instance.api;

  @override
    Widget build(BuildContext context) {
      return MaterialApp(
        home: widget.isLoggedIn ? MainAppScreen() : LoginPage(),
      );
    }
}

class MainAppScreen extends StatefulWidget {
  const MainAppScreen({Key? key}) : super(key: key);

  @override
  State<MainAppScreen> createState() => _MainAppScreenState();
}

class _MainAppScreenState extends State<MainAppScreen> {
  int _currentIndex = 0;

  setCurrentIndex(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
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
              icon: const Icon(Icons.logout),
              onPressed: () async {
                // Supprimer l'utilisateur connecté
                var box = Hive.box('user_tokens');
                await box.delete('current_user');

                // Rediriger vers l'écran de connexion
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => LoginPage()),
                );
              },
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



/// Gestion Access_token TrueLayer

Future<void> saveAccessToken(String userId, String accessToken) async {
  var box = Hive.box('user_tokens');
  await box.put(userId, accessToken);
}

Future<String?> getAccessToken(String userId) async {
  var box = Hive.box('user_tokens');
  return box.get(userId);
}

void onLoginSuccess(String userId, String accessToken) async {
  await saveAccessToken(userId, accessToken);
}

void onAccessTokenNeeded(String userId) async {
  String? accessToken = await getAccessToken(userId);
  if (accessToken != null) {
    print('Le jeton d\'accès pour $userId est : $accessToken');
  } else {
    print('Pas de jeton trouvé pour $userId');
  }
}

Future<void> saveUserToken(String userId, String accessToken, String refreshToken, DateTime expiresAt) async {
  var box = Hive.box('user_tokens');
  await box.put(userId, {
    'accessToken': accessToken,
    'refreshToken': refreshToken,
    'expiresAt': expiresAt.toIso8601String(),
  });
}

Future<Map<String, dynamic>?> getUserToken(String userId) async {
  var box = Hive.box('user_tokens');
  return box.get(userId);
}

bool isTokenExpired(DateTime expiresAt) {
  return DateTime.now().isAfter(expiresAt);
}


/// User interfac



// import 'package:flutter/material.dart';
// import 'package:front/src/rust/api/simple.dart';
// import 'package:front/src/rust/frb_generated.dart';

// Future<void> main() async {
//   await RustLib.init();
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(title: const Text('flutter_rust_bridge quickstart')),
//         body: Center(
//           child: Text(
//               'Action: Call Rust `greet("Tom")`\nResult: '),
//         ),
//       ),
//     );
//   }
// }


