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
  late Future<List<String>> _futureKeysIncome;
  late Future<List<String>> _futureKeysOutcome;
  Spent? spent;
  bool positive = true;



  @override
  void initState() {
    super.initState();
    _futureSpent = _loadSpent();
    _futureKeysIncome = getKeysIncome();
    _futureKeysOutcome = getKeysOutcome();

  }


  Future<Spent?> _loadSpent() async {
    try {
      final spent = await getSpent(); // Appelle la fonction Rust
      if (spent != null) {
        setState(() {
          positive = spent.amount > 0;
          if (positive) {
            _futureKeysIncome = getKeysIncome();
          } else {
            _futureKeysOutcome = getKeysOutcome();
          }
        });
      }
      return spent;
    } catch (e) {
      return null; // Retourne null en cas d'erreur
    }
  }

  Future<List<String>> getKeysIncome() async {
    return await getKeyIncome();
  }

  Future<List<String>> getKeysOutcome() async {
    return await getKeyOutcome();
  }

  Future<void> _addToIncome(String category, Spent spent) async {
    try {
      addToIncome(category: category, spent: spent); 
      print('Spent added to income category: $category');
    } catch (e) {
      print('Failed to add spent to income category: $e');
    }
  }

  Future<void> _addToOutcome(String category, Spent spent) async {
    try {
      addToOutcome(category: category, spent: spent); 
      print('Spent added to income category: $category');
    } catch (e) {
      print('Failed to add spent to income category: $e');
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
                    spent = snapshot.data!;
                    if (spent!.amount > 0) {
                      positive = true;
                    } else {
                      positive = false;
                    }
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(spent!.reason, style: const TextStyle(fontSize: 16)),
                        const SizedBox(height: 8),
                        Text('${spent!.amount}€',
                            style: const TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8),
                        FutureBuilder<String?>(
                          future: getFormattedDate(date: spent!.date),
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

          // FutureBuilder for dynamic buttons
          FutureBuilder<List<String>>(
            future: positive ? _futureKeysIncome : _futureKeysOutcome,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator(); // Display a loading indicator while waiting
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (snapshot.hasData) {
                // Create buttons dynamically based on the keys
                return Wrap(
                  spacing: 20,
                  runSpacing: 20,
                  children: snapshot.data!.map((key) {
                    return ElevatedButton(
                      onPressed: () {
                        if (positive) {
                          _addToIncome(key, spent!);
                        } else {
                          _addToOutcome(key, spent!);
                        }
                        setState(() {
                          _futureSpent = _loadSpent();
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        fixedSize: const Size(100, 100),
                      ),
                      child: Text(key),
                    );
                  }).toList(),
                );
              } else {
                return const Text('No data');
              }
            },
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