import 'package:flutter/material.dart';

class ExpenseListWidget extends StatelessWidget {
  final Map<String, double> expenses;

  const ExpenseListWidget({super.key, required this.expenses});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: expenses.length,
        itemBuilder: (context, index) {
          String category = expenses.keys.elementAt(index);
          double amount = expenses[category]!;
          return _buildBreakDownItem(category, amount);
        },
      ),
    );
  }

  Widget _buildBreakDownItem(String category, double amount) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '$category :',
            style: TextStyle(fontSize: 18),
          ),
          Text(
            '${amount.toStringAsFixed(2)}€',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
