import 'dart:async';
import 'package:flutter/material.dart';
import 'package:front/src/rust/api/simple.dart';

class SortPage extends StatefulWidget {
  const SortPage({super.key});

  @override
  State<SortPage> createState() => _SortPageState();
}

class _SortPageState extends State<SortPage> {
  Future<Spent?>? _futureSpent;
  bool positive = true;

  void initState() {
    super.initState();
    _loadNewSpent();
  }

  void _loadNewSpent() async {
    setState(() {
      _futureSpent = getSpent(); // Charge un nouveau Spent
    });
  }

  void _onCategoryAdded() {
    _loadNewSpent();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          FutureBuilder<Spent?>(
            future: _futureSpent,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator(); // Affichage d'un loader pendant le chargement
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (!snapshot.hasData || snapshot.data == null) {
                return const Text('No more Spent to categorize');
              } else {
                final spent = snapshot.data!;
                positive = spent.amount > 0;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SortInfoBox(
                      spent: spent,
                      onSpentLoaded: _onCategoryAdded,
                    ), // Affichage des informations
                    const SizedBox(height: 20),
                    SortCategoryButtons(
                      positive: positive,
                      spent: spent,
                      onCategoryAdded: _onCategoryAdded, // Recharge après interaction
                    ),
                    const SizedBox(height: 20),
                    AddNewCategoryButton(
                      positive: positive,
                      spent: spent,
                      onCategoryAdded: _onCategoryAdded,
                    )
                  ],
                );
              }
            },
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}


/////////////////////////////////////////////////////
/// InfoBox /////////////////////////////////////////
/////////////////////////////////////////////////////
class SortInfoBox extends StatelessWidget {
  final Spent spent;
  final Function() onSpentLoaded;

  const SortInfoBox({
    super.key,
    required this.spent,
    required this.onSpentLoaded,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
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
                  dateSnapshot.data!,
                  style: const TextStyle(fontSize: 16),
                );
              } else {
                return const Text('Date not available');
              }
            },
          ),
        ],
      ),
    );
  }
}

/////////////////////////////////////////////////////
/// SortCategoryButtons /////////////////////////////
/////////////////////////////////////////////////////

class SortCategoryButtons extends StatelessWidget {
  final bool positive;
  final Spent? spent; // Ajout de Spent
  final Function onCategoryAdded;

  const SortCategoryButtons({
    super.key,
    required this.positive,
    required this.spent, // Reçoit le Spent
    required this.onCategoryAdded,
  });

  Future<void> _addToIncome(String category) async {
    if (spent != null) {
      try {
        addToIncome(category: category, spent: spent!);
        onCategoryAdded();
      } catch (e) {
        print('Failed to add to income category: $e');
      }
    }
  }

  Future<void> _addToOutcome(String category) async {
    if (spent != null) {
      try {
        addToOutcome(category: category, spent: spent!);
        onCategoryAdded();
      } catch (e) {
        print('Failed to add to outcome category: $e');
      }
    }
  }

  Future<List<String>> getKeysIncome() async {
    return getKeyIncome();
  }

  Future<List<String>> getKeysOutcome() async {
    return getKeyOutcome();
  }

  @override
  Widget build(BuildContext context) {
    final futureKeys = positive ? getKeysIncome() : getKeysOutcome();

    return FutureBuilder<List<String>>(
      future: futureKeys,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData) {
          final keys = snapshot.data!;
          return Wrap(
            spacing: 20,
            runSpacing: 20,
            children: keys.map((key) {
              return ElevatedButton(
                onPressed: () {
                  if (positive) {
                    _addToIncome(key);
                  } else {
                    _addToOutcome(key);
                  }
                },
                style: ElevatedButton.styleFrom(fixedSize: const Size(100, 100)),
                child: Text(key),
              );
            }).toList(),
          );
        } else {
          return const Text('No data');
        }
      },
    );
  }
}

/////////////////////////////////////////////////////
/// AddNewCategoryButton ////////////////////////////
/////////////////////////////////////////////////////

class AddNewCategoryButton extends StatelessWidget {
  final bool positive;
  final Spent? spent;
  final Function onCategoryAdded;

  const AddNewCategoryButton({
    super.key,
    required this.positive,
    required this.spent,
    required this.onCategoryAdded,
  });

  Future<void> showAddCategoryDialog(
      BuildContext context, bool positive, Spent spent) {
    final TextEditingController _categoryController =
        TextEditingController();

    return showDialog<void>(
      context: context,
      barrierDismissible:
          false, // L'utilisateur doit utiliser les boutons pour fermer le pop-up
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add a new category'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                const Text('Enter the name of the new category:'),
                TextField(
                  controller: _categoryController,
                  decoration: const InputDecoration(hintText: "Category name"),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Return'),
              onPressed: () {
                Navigator.of(context).pop(); // Ferme le pop-up sans rien faire
              },
            ),
            ElevatedButton(
              child: const Text('Validate'),
              onPressed: () {
                final newCategory =
                    _formatCategory(_categoryController.text);
                if (newCategory.isNotEmpty) {
                  List<String> list =
                      positive ? getKeyIncome() : getKeyOutcome();
                  if (list.contains(newCategory)) {
                    if (positive) {
                      addToIncome(category: newCategory, spent: spent);
                    } else {
                      addToOutcome(category: newCategory, spent: spent);
                    }
                  } else {
                    addNewCategory(category: newCategory, income: positive);
                    if (positive) {
                      addToIncome(category: newCategory, spent: spent);
                    } else {
                      addToOutcome(category: newCategory, spent: spent);
                    }
                  }
                  Navigator.of(context).pop(); // Ferme le pop-up après validation
                } else {
                  print('Category name is empty');
                }
              },
            ),
          ],
        );
      },
    );
  }

  String _formatCategory(String category) {
    return category.isNotEmpty
        ? category[0].toUpperCase() + category.substring(1).toLowerCase()
        : '';
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: spent != null
          ? () async {
              await showAddCategoryDialog(context, positive, spent!);
            }
          : null,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(16.0),
      ),
      child: const Text('Add a Category'),
    );
  }
}
