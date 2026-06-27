class IncomeModel {
  final String id;
  final double amount;
  final String category;
  final String description;
  final DateTime date;
  final String userId;

  IncomeModel({
    required this.id,
    required this.amount,
    required this.category,
    required this.description,
    required this.date,
    required this.userId,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'amount': amount,
      'category': category,
      'description': description,
      'date': date.toIso8601String(),
      'userId': userId,
    };
  }

  factory IncomeModel.fromMap(Map<String, dynamic> map) {
    return IncomeModel(
      id: map['id'],
      amount: (map['amount'] as num).toDouble(),
      category: map['category'],
      description: map['description'],
      date: DateTime.parse(map['date']),
      userId: map['userId'],
    );
  }
}