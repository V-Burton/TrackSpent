import 'package:flutter/material.dart';
import 'package:front/pages/sort_page.dart';
import 'package:front/src/rust/api/simple.dart';

class SortPage extends StatefulWidget {
    const SortPage({super.key});

  @override
  State<SortPage> createState() => _SortPageState();
}

class _SortPageState extends State<SortPage> {
  Future<Spent?>? _futureSpent;
  bool positive = false;

  @override
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
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<Spent?>(
          future: _futureSpent,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return const Text('Error loading data');
            } else if (snapshot.hasData) {
              final spent = snapshot.data!;
              positive = spent.amount > 0;
              return _buildPageContent(spent); // Passe le Spent aux widgets
            } else {
              return const Text('No more data');
            }
          },
        ),
      ),
    );
  }

  Widget _buildPageContent(Spent spent) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Info box (fixe, seul le contenu change)
        _buildSpentInfo(spent),
        const SizedBox(height: 20),
        
        // Dynamic buttons
        Expanded(
          child: _buildDynamicButtons(spent),
        ),
        const SizedBox(height: 20),
        
        // Fixed button (toujours présent)
        _buildFixedButtons(spent),
      ],
    );
  }
    
  Widget _buildSpentInfo(Spent spent) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('${spent.reason}', style: const TextStyle(fontSize: 18)),
          const SizedBox(height: 8),
          Text('${spent.amount}€', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
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


  Widget _buildDynamicButtons(Spent spent) {
      return FutureBuilder<List<String>>(
        future: _getCategoriesFromBackend(positive), // Récupère les catégories
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (snapshot.hasData) {
            final categories = snapshot.data!;
            return SingleChildScrollView(
              child: Column (
                children: [
                  Wrap(
                    spacing: 20,
                    runSpacing: 20,
                    children: categories.map((category) {
                      return ElevatedButton(
                        onPressed: () => _handleButtonPress(category, spent),
                        child: Text(category),
                      );
                    }).toList(),
                  ),
                ]
              ),
            );
          } else {
            return const Text('No data available');
          }
        },
      );
  }

  void _handleButtonPress(String category, Spent spent) {
    if (positive) {
      addToIncome(category: category, spent: spent); // Ajoute au revenu
    } else {
      addToOutcome(category: category, spent: spent); // Ajoute à la dépense
    }
    _onCategoryAdded(); // Recharge la page
  }

  Future<List<String>> _getCategoriesFromBackend(bool positive) async {
    if (positive){
      return getKeyIncome();
    } else {
      return getKeyOutcome();
    }
  }


  Widget _buildFixedButtons(Spent spent) {
    return AddNewCategoryButton(
      positive: positive,
      spent: spent,
      onCategoryAdded: _onCategoryAdded,
    );
  }

}

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
                  onCategoryAdded();
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