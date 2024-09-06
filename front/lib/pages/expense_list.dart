import 'package:flutter/material.dart';

class ExpenseListWidget extends StatelessWidget {
  final Map<String, double> expenses;

  const ExpenseListWidget({super.key, required this.expenses});

  @override
  Widget build(BuildContext context) {
    List<MapEntry<String, double>> sortedExpenses = _sortExpenses(expenses);
    return Expanded(
      child: ListView.builder(
        itemCount: sortedExpenses.length,
        itemBuilder: (context, index) {
          String category = sortedExpenses[index].key;
          double amount = sortedExpenses[index].value;
          return _buildBreakDownItem(category, amount);
        },
      ),
    );
  }

  List<MapEntry<String, double>> _sortExpenses(Map<String, double> expenses) {
    return expenses.entries.toList()
      ..sort((a, b) => a.value.compareTo(b.value));  // Tri par montant décroissant
  }

  Widget _buildBreakDownItem(String category, double amount) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '$category :',
            style: const TextStyle(fontSize: 18),
          ),
          Text(
            '${amount.toStringAsFixed(2)}€',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
