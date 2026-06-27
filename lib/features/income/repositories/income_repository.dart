import 'package:hive_flutter/hive_flutter.dart';

import '../models/income_model.dart';

class IncomeRepository {
  IncomeRepository();

  final List<IncomeModel> _items = <IncomeModel>[];

  List<IncomeModel> get items => List.unmodifiable(_items);

  void add(IncomeModel income) {
    _items.add(income);
  }

  void update(String id, IncomeModel updatedIncome) {
    final index = _items.indexWhere((item) => item.id == id);
    if (index >= 0) {
      _items[index] = updatedIncome;
    }
  }

  void delete(String id) {
    _items.removeWhere((item) => item.id == id);
  }

  Future<void> saveToHive(String boxName) async {
    final box = await Hive.openBox<Map>('income_$boxName');
    for (final item in _items) {
      await box.put(item.id, item.toJson());
    }
    await box.close();
  }

  Future<void> loadFromHive(String boxName) async {
    final box = await Hive.openBox<Map>('income_$boxName');
    _items.clear();
    for (final entry in box.values) {
      _items.add(IncomeModel.fromJson(Map<String, dynamic>.from(entry)));
    }
    await box.close();
  }
}
