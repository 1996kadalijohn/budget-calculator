import 'package:buget_calculator/features/income/models/income_model.dart';
import 'package:buget_calculator/features/income/repositories/income_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('IncomeRepository', () {
    test('accepts future local and remote service dependencies', () {
      final localService = Object();
      final firestoreService = Object();

      final repository = IncomeRepository(
        localService: localService,
        firestoreService: firestoreService,
      );

      expect(repository.localService, same(localService));
      expect(repository.firestoreService, same(firestoreService));
    });

    test('defines income method contracts without implementations', () {
      final repository = IncomeRepository();
      final income = _sampleIncome(amount: 75000);

      expect(repository.getAllIncome('user-1'), throwsUnimplementedError);
      expect(repository.getIncomeById('income-1'), throwsUnimplementedError);
      expect(repository.addIncome(income), throwsUnimplementedError);
      expect(repository.updateIncome(income), throwsUnimplementedError);
      expect(repository.deleteIncome('income-1'), throwsUnimplementedError);
      expect(
        () => repository.watchIncome('user-1'),
        throwsUnimplementedError,
      );
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
