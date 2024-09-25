// import 'package:json_annotation/json_annotation.dart';
// import 'package:full_flutter/material.dart';

// part 'models.g.dart'; // Ce fichier est généré automatiquement


// //Déclaration transactions
// @JsonSerializable()
// class Transaction {
//   String id;
//   @JsonKey(name: 'accountId')
//   String accountId;
//   Amount amount;
//   Descriptions descriptions;
//   Dates dates;
//   Types types;
//   String status;
//   String reference;
//   @JsonKey(name: 'providerMutability')
//   String providerMutability;

//   Transaction({
//     required this.id,
//     required this.accountId,
//     required this.amount,
//     required this.descriptions,
//     required this.dates,
//     required this.types,
//     required this.status,
//     required this.reference,
//     required this.providerMutability,
//   });

//   factory Transaction.fromJson(Map<String, dynamic> json) => _$TransactionFromJson(json);
//   Map<String, dynamic> toJson() => _$TransactionToJson(this);
// }

// @JsonSerializable()
// class Amount {
//   ValueDetail value;
//   @JsonKey(name: 'currencyCode')
//   String currencyCode;

//   Amount({
//     required this.value,
//     required this.currencyCode,
//   });

//   factory Amount.fromJson(Map<String, dynamic> json) => _$AmountFromJson(json);
//   Map<String, dynamic> toJson() => _$AmountToJson(this);
// }

// @JsonSerializable()
// class ValueDetail {
//   @JsonKey(name: 'unscaledValue')
//   String unscaledValue;
//   String scale;

//   ValueDetail({
//     required this.unscaledValue,
//     required this.scale,
//   });

//   factory ValueDetail.fromJson(Map<String, dynamic> json) => _$ValueDetailFromJson(json);
//   Map<String, dynamic> toJson() => _$ValueDetailToJson(this);
// }

// @JsonSerializable()
// class Descriptions {
//   String original;
//   String display;

//   Descriptions({
//     required this.original,
//     required this.display,
//   });

//   factory Descriptions.fromJson(Map<String, dynamic> json) => _$DescriptionsFromJson(json);
//   Map<String, dynamic> toJson() => _$DescriptionsToJson(this);
// }

// @JsonSerializable()
// class Dates {
//   String booked;
//   String value;

//   Dates({
//     required this.booked,
//     required this.value,
//   });

//   factory Dates.fromJson(Map<String, dynamic> json) => _$DatesFromJson(json);
//   Map<String, dynamic> toJson() => _$DatesToJson(this);
// }

// @JsonSerializable()
// class Types {
//   @JsonKey(name: 'type')
//   String kind;

//   Types({
//     required this.kind,
//   });

//   factory Types.fromJson(Map<String, dynamic> json) => _$TypesFromJson(json);
//   Map<String, dynamic> toJson() => _$TypesToJson(this);
// }

// @JsonSerializable()
// class TransactionsData {
//   List<Transaction> transactions;

//   TransactionsData({
//     required this.transactions,
//   });

//   factory TransactionsData.fromJson(Map<String, dynamic> json) => _$TransactionsDataFromJson(json);
//   Map<String, dynamic> toJson() => _$TransactionsDataToJson(this);
// }


// //Gestions des transactions

// class TransactionModel with ChangeNotifier {
//   final List<Transaction> _transactions = [];
//   final List<String> _keyIncome = ["Revenu", "Refund", "Gift", "Other"];
//   final List<String> _keyOutcome = ["Charges", "Food", "Save", "Other"];

//   List<Transaction> get transactions => _transactions;
//   List<String> get keyIncome => _keyIncome;
//   List<String> get keyOutcome => _keyOutcome;

//   void addTransaction(Transaction transaction) {
//     _transactions.add(transaction);
//     notifyListeners(); // Met à jour l'interface
//   }

//   void removeTransaction(int index) {
//     _transactions.removeAt(index);
//     notifyListeners();
//   }

//   void addCategory(String category, bool isIncome) {
//     if (isIncome) {
//       _keyIncome.add(category);
//     } else {
//       _keyOutcome.add(category);
//     }
//     notifyListeners();
//   }
// }
