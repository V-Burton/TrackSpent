import 'package:flutter/material.dart';
import 'package:front/src/rust/api/simple.dart';
import 'package:front/src/rust/frb_generated.dart';
import 'package:intl/intl.dart';




class SortPage extends StatefulWidget {
  const SortPage({super.key});

  @override
  State<SortPage> createState() => _SortPageState();
}



class _SortPageState extends State<SortPage> {
  late Future<Spent?> _futureSpent;


  @override
  void initState() {
    super.initState();
    _futureSpent = _loadSpent();
  }


  Future<Spent?> _loadSpent() async {
    try {
      return await getSpent(); // Appelle la fonction Rust
    } catch (e) {
      return null; // Retourne null en cas d'erreur
    }
  }
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FutureBuilder<Spent?>(
                future: _futureSpent,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (!snapshot.hasData || snapshot.data == null) {
                    return const Text('No more Spent to categorize');
                  } else {
                    final spent = snapshot.data!;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(spent.reason, style: const TextStyle(fontSize: 16)),
                        const SizedBox(height: 8),
                        Text('${spent.amount}€',
                            style: const TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8),
                        FutureBuilder<String?>(
                          future: getFormattedDate(date: spent.date),
                          builder: (context, dateSnapshot) {
                            if (dateSnapshot.connectionState == ConnectionState.waiting) {
                              return const CircularProgressIndicator();
                            } else if (dateSnapshot.hasError) {
                              return Text('Error: ${dateSnapshot.error}');
                            } else if (dateSnapshot.hasData) {
                              return Text(
                                DateFormat('dd/MM/yyyy').format(DateTime.parse(dateSnapshot.data!)),
                                style: const TextStyle(fontSize: 16)
                              );
                            } else {
                              return const Text('Date not available');
                            }
                          },
                        ),
                      ],
                    );
                  }
                },
              ),
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

          ElevatedButton(
            onPressed: () {
              setState(() {
                _futureSpent = _loadSpent(); // Recharge un autre Spent
              });
            },
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