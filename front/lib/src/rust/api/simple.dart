// This file is automatically generated, so please do not edit it.
// Generated by `flutter_rust_bridge`@ 2.2.0.

// ignore_for_file: invalid_use_of_internal_member, unused_import, unnecessary_import

import '../frb_generated.dart';
import '../lib.dart';
import 'package:flutter_rust_bridge/flutter_rust_bridge_for_generated.dart';

// These functions are ignored because they are not marked as `pub`: `remove_spent`
// These types are ignored because they are not used by any `pub` functions: `Amount`, `Dates`, `Descriptions`, `INCOME`, `KEY_INCOME`, `KEY_OUTCOME`, `OUTCOME`, `RESULT`, `Transaction`, `Types`, `ValueDetail`
// These function are ignored because they are on traits that is not defined in current crate (put an empty `#[frb]` on it to unignore): `clone`, `deref`, `deref`, `deref`, `deref`, `deref`, `fmt`, `fmt`, `fmt`, `fmt`, `fmt`, `fmt`, `fmt`, `fmt`, `initialize`, `initialize`, `initialize`, `initialize`, `initialize`

Future<String> getFormattedDate({required NaiveDate date}) =>
    RustLib.instance.api.crateApiSimpleGetFormattedDate(date: date);

Future<void> parseAndUseDate({required String dateStr}) =>
    RustLib.instance.api.crateApiSimpleParseAndUseDate(dateStr: dateStr);

List<String> getKeyIncome() =>
    RustLib.instance.api.crateApiSimpleGetKeyIncome();

List<String> getKeyOutcome() =>
    RustLib.instance.api.crateApiSimpleGetKeyOutcome();

void initApp() => RustLib.instance.api.crateApiSimpleInitApp();

Future<void> intialize() => RustLib.instance.api.crateApiSimpleIntialize();

void loadTransactionsFromFile() =>
    RustLib.instance.api.crateApiSimpleLoadTransactionsFromFile();

Future<void> pushTransactionToResult({required TransactionsData data}) =>
    RustLib.instance.api.crateApiSimplePushTransactionToResult(data: data);

Future<Spent?> getSpent() => RustLib.instance.api.crateApiSimpleGetSpent();

String getValue({required BigInt indice}) =>
    RustLib.instance.api.crateApiSimpleGetValue(indice: indice);

void addToIncome({required String category, required Spent spent}) =>
    RustLib.instance.api
        .crateApiSimpleAddToIncome(category: category, spent: spent);

void addToOutcome({required String category, required Spent spent}) =>
    RustLib.instance.api
        .crateApiSimpleAddToOutcome(category: category, spent: spent);

void addNewCategory({required String category, required bool income}) =>
    RustLib.instance.api
        .crateApiSimpleAddNewCategory(category: category, income: income);

Future<Map<String, double>> getOutcomeDataByDate(
        {required int month, required int year}) async {
          return await RustLib.instance.api
        .crateApiSimpleGetOutcomeDataByDate(month: month, year: year);
        }

Future<Map<String, double>> getIncomeDataByDate(
        {required int month, required int year}) async {
    return await RustLib.instance.api
        .crateApiSimpleGetIncomeDataByDate(month: month, year: year);
        }

///
///
/// ///
Future<void> initializeResultWithDummyData() =>
    RustLib.instance.api.crateApiSimpleInitializeResultWithDummyData();

// Rust type: RustOpaqueMoi<flutter_rust_bridge::for_generated::RustAutoOpaqueInner<Spent>>
abstract class Spent implements RustOpaqueInterface {
  double get amount;

  NaiveDate get date;

  String get reason;

  set amount(double amount);

  set date(NaiveDate date);

  set reason(String reason);
}

// Rust type: RustOpaqueMoi<flutter_rust_bridge::for_generated::RustAutoOpaqueInner<TransactionsData>>
abstract class TransactionsData implements RustOpaqueInterface {}
