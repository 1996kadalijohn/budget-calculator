import 'package:flutter_test/flutter_test.dart';
import 'package:buget_calculator/models/income_model.dart';

void main() {
  group('IncomeModel', () {
    test('serializes and restores values for Firestore-friendly use', () {
      final createdAt = DateTime(2026, 6, 28, 10, 0);
      final updatedAt = DateTime(2026, 6, 28, 11, 30);
      final income = IncomeModel(
        id: 'income-1',
        amount: 75000,
        category: 'Salary',
        description: 'Monthly salary',
        date: DateTime(2026, 6, 28),
        createdAt: createdAt,
        updatedAt: updatedAt,
        userId: 'user-1',
      );

      final json = income.toJson();

      expect(json['id'], 'income-1');
      expect(json['amount'], 75000.0);
      expect(json['category'], 'Salary');
      expect(json['description'], 'Monthly salary');
      expect(json['date'], isA<String>());
      expect(json['createdAt'], isA<String>());
      expect(json['updatedAt'], isA<String>());

      final restored = IncomeModel.fromJson(json);
      expect(restored.id, income.id);
      expect(restored.amount, income.amount);
      expect(restored.category, income.category);
      expect(restored.description, income.description);
      expect(restored.date, income.date);
      expect(restored.createdAt, income.createdAt);
      expect(restored.updatedAt, income.updatedAt);
      expect(restored.userId, income.userId);
    });
  });
}
