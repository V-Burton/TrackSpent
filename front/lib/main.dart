import 'package:flutter/material.dart';
import 'package:front/pages/outcome_page.dart';
import 'package:front/pages/sort_page.dart';

import 'pages/income_pages.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
    const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  
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
            const Text("Income"),
            const Text("Outcome"),
            ][_currentIndex],
        ),
        body: [
          SortPage(),
          OutcomePage(),
          IncomePage(),
          const Text("Ajouter un événement")
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
