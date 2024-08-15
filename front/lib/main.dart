// The original content is temporarily commented out to allow generating a self-contained demo - feel free to uncomment later.

import 'package:flutter/material.dart';
import 'package:front/pages/outcome_page.dart';
import 'package:front/pages/sort_page.dart';

import 'pages/income_pages.dart';

import 'package:front/src/rust/api/simple.dart';
import 'package:front/src/rust/frb_generated.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await RustLib.init();
  initApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
    const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  int _currentIndex = 0;
  final api = RustLib.instance.api;

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
            const Text("Income"),
            const Text("Outcome"),
            ][_currentIndex],
        ),
        body: [
          const SortPage(),
          OutcomePage(),
          IncomePage(),
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


