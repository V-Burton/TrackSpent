import 'package:flutter/material.dart';
import 'package:full_flutter/pages/spent.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';


class SortPage extends StatefulWidget {
    const SortPage({super.key});

  @override
  State<SortPage> createState() => _SortPageState();
}

class _SortPageState extends State<SortPage> {
  bool positive = false;


  @override
  Widget build(BuildContext context) {
    final spent = Provider.of<SpentModel>(context).getSpent();
    
    if (spent == null) {
      return const Center(child: Text('No more data'));
    
    }
    positive = spent.amount > 0;
    
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _buildPageContent(spent),
        )
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
    final formattedDate = DateFormat('yyyy-MM-dd').format(spent.date);
    final formattedAmount = spent.amount.toStringAsFixed(2);

    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('${spent.reason}', style: const TextStyle(fontSize: 18)),
          const SizedBox(height: 8),
          Text('$formattedAmount€', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text(
            formattedDate,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }


  Widget _buildDynamicButtons(Spent spent) {
      final categories = positive
          ? Provider.of<SpentModel>(context).keyIncome
          : Provider.of<SpentModel>(context).keyOutcome;

      if (categories.isEmpty) {
        return const Center(child: Text('No category available'));
      }

      return SingleChildScrollView(
        child: Column(
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
            ],
          ),
        );
  }

  void _handleButtonPress(String category, Spent spent) {
    if (positive) {
      Provider.of<SpentModel>(context, listen: false).addToIncome(category, spent);
    } else {
      Provider.of<SpentModel>(context, listen: false).addToOutcome(category, spent);
    }
  }


  Widget _buildFixedButtons(Spent spent) {
    return AddNewCategoryButton(
      positive: positive,
      spent: spent,
    );
  }

}

class AddNewCategoryButton extends StatelessWidget {
  final bool positive;
  final Spent? spent;

  const AddNewCategoryButton({
    super.key,
    required this.positive,
    required this.spent,
  });

  Future<void> showAddCategoryDialog(
      BuildContext context, bool positive, Spent spent) {
    final TextEditingController _categoryController =
        TextEditingController();

    return showDialog<void>(
      context: context,
      barrierDismissible:
          false,
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
                  if (positive) {
                    Provider.of<SpentModel>(context, listen: false)
                      .addNewCategory(newCategory, true);
                    Provider.of<SpentModel>(context, listen: false)
                      .addToIncome(newCategory, spent);
                  } else {
                    Provider.of<SpentModel>(context, listen: false)
                      .addNewCategory(newCategory, false);
                    Provider.of<SpentModel>(context, listen: false)
                      .addToOutcome(newCategory, spent);
                  }
                  Navigator.of(context).pop();
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