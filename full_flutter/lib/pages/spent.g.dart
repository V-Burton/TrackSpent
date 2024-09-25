// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spent.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Spent _$SpentFromJson(Map<String, dynamic> json) => Spent(
      reason: json['reason'] as String,
      date: DateTime.parse(json['date'] as String),
      amount: (json['amount'] as num).toDouble(),
    );

Map<String, dynamic> _$SpentToJson(Spent instance) => <String, dynamic>{
      'reason': instance.reason,
      'date': instance.date.toIso8601String(),
      'amount': instance.amount,
    };
