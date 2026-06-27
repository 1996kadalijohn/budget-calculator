import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class IncomeModel {
  IncomeModel({
    required this.id,
    required this.amount,
    required this.category,
    required this.description,
    required this.date,
    required this.createdAt,
    required this.updatedAt,
    required this.userId,
  });

  final String id;
  final double amount;
  final String category;
  final String description;
  final DateTime date;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String userId;

  factory IncomeModel.fromJson(Map<String, dynamic> json) {
    return IncomeModel(
      id: json['id'] as String? ?? '',
      amount: (json['amount'] as num?)?.toDouble() ?? 0.0,
      category: json['category'] as String? ?? 'Uncategorized',
      description: json['description'] as String? ?? '',
      date: _parseDate(json['date']),
      createdAt: _parseDate(json['createdAt']),
      updatedAt: _parseDate(json['updatedAt']),
      userId: json['userId'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'amount': amount,
      'category': category,
      'description': description,
      'date': _formatDate(date),
      'createdAt': _formatDate(createdAt),
      'updatedAt': _formatDate(updatedAt),
      'userId': userId,
    };
  }

  factory IncomeModel.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data();
    if (data == null) {
      throw StateError('Income document is missing');
    }

    return IncomeModel.fromJson({
      ...data,
      'id': snapshot.id,
    });
  }

  Map<String, dynamic> toFirestore() {
    return toJson();
  }

  IncomeModel copyWith({
    String? id,
    double? amount,
    String? category,
    String? description,
    DateTime? date,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? userId,
  }) {
    return IncomeModel(
      id: id ?? this.id,
      amount: amount ?? this.amount,
      category: category ?? this.category,
      description: description ?? this.description,
      date: date ?? this.date,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      userId: userId ?? this.userId,
    );
  }

  static DateTime _parseDate(dynamic value) {
    if (value is Timestamp) {
      return value.toDate();
    }

    if (value is DateTime) {
      return value;
    }

    if (value is String) {
      return DateTime.parse(value);
    }

    return DateTime.now();
  }

  static String _formatDate(DateTime value) {
    return DateFormat('yyyy-MM-ddTHH:mm:ss').format(value.toUtc());
  }
}
