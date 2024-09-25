import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'spent.g.dart'; // Fichier généré automatiquement

@JsonSerializable()
class Spent {
  String reason;
  DateTime date;
  double amount;

  Spent({
    required this.reason,
    required this.date,
    required this.amount,
  });

  factory Spent.fromJson(Map<String, dynamic> json) => _$SpentFromJson(json);
  Map<String, dynamic> toJson() => _$SpentToJson(this);
}



class SpentModel with ChangeNotifier {
  final Map<String, List<Spent>> _outcome = {
    'Charges': [],
    'Food': [],
    'Save': [],
    'Other': [],
  };
  
  final Map<String, List<Spent>> _income = {
    'Revenu': [],
    'Refund': [],
    'Gift': [],
    'Other': [],
  };

  final List<String> _keyIncome = ["Revenu", "Refund", "Gift", "Other"];
  final List<String> _keyOutcome = ["Charges", "Food", "Save", "Other"];
  
  final List<Spent> _result = [];

  List<String> get keyIncome => _keyIncome;
  List<String> get keyOutcome => _keyOutcome;
  List<Spent> get result => _result;

  Map<String, List<Spent>> get outcome => _outcome;
  Map<String, List<Spent>> get income => _income;

  // Ajouter une transaction à une catégorie d'income
  void addToIncome(String category, Spent spent) {
    // Si la catégorie n'existe pas, on la crée
    _income.putIfAbsent(category, () => []);
    _income[category]?.add(spent);
    _result.remove(spent);
    notifyListeners();
  }

  // Ajouter une transaction à une catégorie d'outcome
  void addToOutcome(String category, Spent spent) {
    // Si la catégorie n'existe pas, on la crée
    _outcome.putIfAbsent(category, () => []);
    _outcome[category]?.add(spent);
    _result.remove(spent);
    notifyListeners();
  }

  // Ajouter une nouvelle catégorie d'income ou d'outcome
  void addNewCategory(String category, bool isIncome) {
    if (isIncome) {
      if (!_income.containsKey(category)) {
        _income[category] = [];
        _keyIncome.add(category);
      }
    } else {
      if (!_outcome.containsKey(category)) {
        _outcome[category] = [];
        _keyOutcome.add(category);
      }
    }
    notifyListeners();
  }

  // Ajouter une nouvelle transaction à result
  void addSpentToResult(Spent spent) {
    _result.add(spent);
    notifyListeners();
  }

  // Récupérer une transaction depuis result
  Spent? getSpent() {
    if (_result.isNotEmpty) {
      return _result.first;
    }
    return null;
  }

  // Supprimer la première transaction de result
  void removeSpent() {
    if (_result.isNotEmpty) {
      _result.removeAt(0);
      notifyListeners();
    }
  }

  Map<String, double> getIncomeDataByDate(int month, int year) {
    return _income.map((category, spentList) {
      final total = spentList
            .where((spent) => spent.date.month == month && spent.date.year == year)
            .toList()
            .fold(0.0, (sum, spent) => sum + spent.amount);
      return MapEntry(category, total);
    });
  }

  Map<String, double> getOutcomeDataByDate(int month, int year) {
    return _outcome.map((category, spentList) {
      final total = spentList
            .where((spent) => spent.date.month == month && spent.date.year == year)
            .toList()
            .fold(0.0, (sum, spent) => sum + spent.amount);
      return MapEntry(category, total);
    });
  }

  

  void initializeDummyData() {
    // Simule les transactions fictives
    final List<Spent> dummyData = [
      Spent(reason: 'Groceries', date: DateTime(2024, 8, 1), amount: -50.25),
    Spent(reason: 'Rent', date: DateTime(2024, 8, 3), amount: -800.00),
    Spent(reason: 'Tax Refund', date: DateTime(2024, 8, 25), amount: 200.00),
    Spent(reason: 'Bonus', date: DateTime(2024, 9, 5), amount: 1000.00),
    Spent(reason: 'Dining Out', date: DateTime(2024, 8, 12), amount: -45.50),
    Spent(reason: 'Clothes', date: DateTime(2024, 9, 1), amount: -120.75),
    Spent(reason: 'Freelance Work', date: DateTime(2024, 8, 15), amount: 500.00),
    Spent(reason: 'Dividends', date: DateTime(2024, 9, 18), amount: 150.00),
    Spent(reason: 'Gym Membership', date: DateTime(2024, 9, 5), amount: -40.00),
    Spent(reason: 'Groceries', date: DateTime(2024, 9, 10), amount: -75.30),
    Spent(reason: 'Movies', date: DateTime(2024, 9, 15), amount: -20.00),
    Spent(reason: 'Coffee', date: DateTime(2024, 9, 20), amount: -15.00),
    Spent(reason: 'Salary', date: DateTime(2024, 8, 10), amount: 3000.00),
    Spent(reason: 'Internet', date: DateTime(2024, 8, 7), amount: -30.00),
    Spent(reason: 'Gift', date: DateTime(2024, 8, 20), amount: 100.00),
    Spent(reason: 'Investment Return', date: DateTime(2024, 9, 8), amount: 350.00),
    Spent(reason: 'Side Hustle', date: DateTime(2024, 9, 12), amount: 400.00),
    Spent(reason: 'Electricity Bill', date: DateTime(2024, 8, 5), amount: -60.00),
    Spent(reason: 'Rental Income', date: DateTime(2024, 9, 15), amount: 600.00),
    Spent(reason: 'Reimbursement', date: DateTime(2024, 9, 22), amount: 75.00),
    ];

    // Ajouter ces transactions au result
    _result.addAll(dummyData);

    // Notifier les widgets qu'il y a des données nouvelles
    notifyListeners();
  }

}
