import 'dart:io';

import 'package:buget_calculator/features/dashboard/providers/dashboard_provider.dart';
import 'package:buget_calculator/models/income_model.dart';
import 'package:buget_calculator/services/income/income_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Income flow', () {
    test('add adds an income entry and updates dashboard totals', () {
      final provider = DashboardProvider();
      final repository = IncomeRepository();
      final income = _sampleIncome(amount: 75000);

      repository.add(income);
      provider.addIncome(income.amount);

      expect(repository.items, hasLength(1));
      expect(repository.items.single.amount, 75000);
      expect(provider.income, 150000);
      expect(provider.savings, 108000);
    });

    test('edit updates the stored amount', () {
      final repository = IncomeRepository();
      final income = _sampleIncome(amount: 5000);
      repository.add(income);

      repository.update(
        income.id,
        income.copyWith(amount: 9000),
      );

      expect(repository.items.single.amount, 9000);
    });

    test('delete removes the income entry', () {
      final repository = IncomeRepository();
      final income = _sampleIncome(amount: 3200);
      repository.add(income);

      repository.delete(income.id);

      expect(repository.items, isEmpty);
    });

    test('hive persistence keeps income after restart', () async {
      final tempDir = await Directory.systemTemp.createTemp('income_hive_test');
      Hive.init(tempDir.path);

      final repository = IncomeRepository();
      repository.add(_sampleIncome(amount: 12000));
      await repository.saveToHive('income_box');

      final reloadedRepository = IncomeRepository();
      await reloadedRepository.loadFromHive('income_box');

      expect(reloadedRepository.items, hasLength(1));
      expect(reloadedRepository.items.single.amount, 12000);

      await Hive.deleteBoxFromDisk('income_box', path: tempDir.path);
      await Hive.close();
      await tempDir.delete(recursive: true);
    });

    test('firestore mapping preserves income values', () {
      final income = _sampleIncome(amount: 82000);
      final firestoreData = income.toFirestore();

      expect(firestoreData['id'], income.id);
      expect(firestoreData['amount'], 82000.0);
      expect(firestoreData['category'], 'Salary');
      expect(firestoreData['description'], 'Monthly salary');
      expect(firestoreData['userId'], 'user-1');
    });
  });
}

IncomeModel _sampleIncome({required double amount}) {
  final now = DateTime(2026, 6, 28);

  return IncomeModel(
    id: 'income-1',
    amount: amount,
    category: 'Salary',
    description: 'Monthly salary',
    date: now,
    createdAt: now,
    updatedAt: now,
    userId: 'user-1',
  );
}
