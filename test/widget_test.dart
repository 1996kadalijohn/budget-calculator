import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:buget_calculator/main.dart';

import 'helpers/fake_auth_repository.dart';

void main() {
  setUp(() {
    setTestAuthRepository(FakeAuthRepository());
  });

  testWidgets('app renders smoke test', (tester) async {
    await tester.pumpWidget(const BudgetCalculatorApp());

    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
