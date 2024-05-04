import 'dart:convert';

class TransactionModel {
  final String id;
  final int amount;
  final String title;

  TransactionModel({
    required this.id,
    required this.amount,
    required this.title,
  });

  factory TransactionModel.fromMap(Map<String, dynamic> map) =>
      TransactionModel(
        id: map['id'],
        title: map['title'],
        amount: map['amount'],
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'amount': amount,
      };

  String toJson() => json.encode(toMap());

  factory TransactionModel.fromJson(String source) =>
      TransactionModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
