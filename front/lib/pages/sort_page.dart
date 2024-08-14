import 'package:flutter/material.dart';

class SortPage extends StatefulWidget {
  const SortPage({super.key});

  @override
  State<SortPage> createState() => _SortPageState();
}

class _SortPageState extends State<SortPage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Information Box
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('SNCF - Internet', style: TextStyle(fontSize: 18)),
                SizedBox(height: 8),
                Text('28.00€',
                    style:
                        TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Text('08/08/2024', style: TextStyle(fontSize: 16)),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Category Buttons
          Wrap(
            spacing: 20,
            runSpacing: 20,
            children: [
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(100, 100),
                ),
                child: const Text('SAVE'),
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(100, 100),
                ),
                child: const Text('Food'),
              ),
              ElevatedButton(
                onPressed: () {},
                child: const Text('Other'),
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(100, 100),
                ),
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(100, 100),
                ),
                child: const Text('Things'),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Add Category Button
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(16.0),
            ),
            child: const Text('Add a Category'),
          ),
        ],
      ),
    );
  }
}
