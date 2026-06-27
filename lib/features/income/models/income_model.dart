import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

/// Immutable model that represents an income record for a user.
@immutable
class IncomeModel {
  /// Creates an [IncomeModel].
  const IncomeModel({
    required this.id,
    required this.amount,
    required this.category,
    required this.description,
    required this.date,
    required this.createdAt,
    required this.updatedAt,
    required this.userId,
  });

  /// Unique identifier for the income record.
  final String id;

  /// Monetary value of the income record.
  final double amount;

  /// Category assigned to the income record.
  final String category;

  /// Optional notes or details about the income record.
  final String description;

  /// Date the income was received or recorded for.
  final DateTime date;

  /// Date and time the income record was created.
  final DateTime createdAt;

  /// Date and time the income record was last updated.
  final DateTime updatedAt;

  /// Identifier of the user who owns the income record.
  final String userId;

  /// Creates a copy of this income record with selected fields replaced.
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

  /// Converts this income record to a serializable map.
  Map<String, dynamic> toMap() {
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

  /// Creates an [IncomeModel] from a map.
  factory IncomeModel.fromMap(Map<String, dynamic> map) {
    return IncomeModel(
      id: map['id'] as String? ?? '',
      amount: (map['amount'] as num?)?.toDouble() ?? 0.0,
      category: map['category'] as String? ?? 'Uncategorized',
      description: map['description'] as String? ?? '',
      date: _parseDate(map['date']),
      createdAt: _parseDate(map['createdAt']),
      updatedAt: _parseDate(map['updatedAt']),
      userId: map['userId'] as String? ?? '',
    );
  }

  /// Creates an [IncomeModel] from a JSON-compatible map.
  factory IncomeModel.fromJson(Map<String, dynamic> json) {
    return IncomeModel.fromMap(json);
  }

  /// Converts this income record to a JSON-compatible map.
  Map<String, dynamic> toJson() {
    return toMap();
  }

  /// Creates an [IncomeModel] from a Firestore document snapshot.
  factory IncomeModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    final data = snapshot.data();
    if (data == null) {
      throw StateError('Income document is missing');
    }

    return IncomeModel.fromJson({...data, 'id': snapshot.id});
  }

  /// Converts this income record to a Firestore-friendly map.
  Map<String, dynamic> toFirestore() {
    return toMap();
  }

  static DateTime _parseDate(dynamic value) {
    if (value is Timestamp) {
      return value.toDate();
    }

    if (value is DateTime) {
      return value;
    }

    if (value is String) {
      final parsed = DateTime.parse(value);
      final hasTimeZone = RegExp(
        r'(z|[+-]\d{2}:?\d{2})$',
        caseSensitive: false,
      ).hasMatch(value);
      return hasTimeZone
          ? parsed
          : DateTime.utc(
              parsed.year,
              parsed.month,
              parsed.day,
              parsed.hour,
              parsed.minute,
              parsed.second,
              parsed.millisecond,
              parsed.microsecond,
            ).toLocal();
    }

    return DateTime.now();
  }

  static String _formatDate(DateTime value) {
    return value.toUtc().toIso8601String().replaceFirst('Z', '');
  }
}
