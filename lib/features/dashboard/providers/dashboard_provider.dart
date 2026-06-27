import 'package:flutter/foundation.dart';

class DashboardProvider extends ChangeNotifier {
  DashboardProvider() {
    _income = 75000;
    _expense = 42000;
    _budget = 80000;
    _savings = 33000;
  }

  late double _income;
  late double _expense;
  late double _budget;
  late double _savings;

  double get income => _income;
  double get expense => _expense;
  double get budget => _budget;
  double get savings => _savings;

  double get spentPercentage => budget == 0 ? 0 : (expense / budget) * 100;

  void addIncome(double amount) {
    _income += amount;
    _savings = _income - _expense;
    notifyListeners();
  }

  void refreshFakeData() {
    _income = 75000;
    _expense = 42000;
    _budget = 80000;
    _savings = 33000;
    notifyListeners();
  }
}
