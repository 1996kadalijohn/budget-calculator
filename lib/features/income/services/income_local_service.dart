import 'package:hive_flutter/hive_flutter.dart';

import '../models/income_model.dart';

/// Provides local persistence for income records using Hive.
///
/// This service owns only the local income cache. It does not contain UI,
/// Provider, repository orchestration, authentication, or Firestore logic.
/// Records are stored as serialized [IncomeModel] maps in a dedicated Hive box
/// and are filtered by [IncomeModel.userId] when queried.
class IncomeLocalService {
  /// Creates an [IncomeLocalService].
  const IncomeLocalService();

  static const String _boxName = 'income';

  /// Opens the dedicated Hive box used for income persistence.
  ///
  /// Call this once during application startup before reading or writing income
  /// records. Calling it more than once is safe because an already-open box is
  /// reused.
  Future<void> init() async {
    await Hive.initFlutter();

    if (!Hive.isBoxOpen(_boxName)) {
      await Hive.openBox<Map<dynamic, dynamic>>(_boxName);
    }
  }

  /// Returns all locally stored income records that belong to [userId].
  ///
  /// The records are deserialized from Hive maps into [IncomeModel] instances.
  /// TODO: Add a per-user secondary index when income collections become large.
  Future<List<IncomeModel>> getAllIncome(String userId) async {
    final box = await _incomeBox;

    return box.values
        .map(_incomeFromStoredMap)
        .where((income) => income.userId == userId)
        .toList(growable: false);
  }

  /// Saves [income] to local storage.
  ///
  /// The record is keyed by [IncomeModel.id], so saving another record with the
  /// same id replaces the existing local value.
  Future<void> saveIncome(IncomeModel income) async {
    final box = await _incomeBox;
    await box.put(income.id, income.toMap());
  }

  /// Updates an existing local [income] record.
  ///
  /// Hive's [Box.put] operation is used so the method remains idempotent for
  /// offline sync flows where the local record may not exist yet.
  /// TODO: Track dirty sync metadata beside income records for conflict checks.
  Future<void> updateIncome(IncomeModel income) async {
    final box = await _incomeBox;
    await box.put(income.id, income.toMap());
  }

  /// Deletes the locally stored income record with [id].
  ///
  /// If the record does not exist, Hive treats the operation as a no-op.
  Future<void> deleteIncome(String id) async {
    final box = await _incomeBox;
    await box.delete(id);
  }

  /// Returns the locally stored income record with [id], if present.
  Future<IncomeModel?> getIncomeById(String id) async {
    final box = await _incomeBox;
    final storedIncome = box.get(id);

    if (storedIncome == null) {
      return null;
    }

    return _incomeFromStoredMap(storedIncome);
  }

  /// Watches local income records for [userId].
  ///
  /// The stream emits the current local snapshot first, then emits a fresh
  /// filtered list whenever the income Hive box changes.
  Stream<List<IncomeModel>> watchIncome(String userId) async* {
    final box = await _incomeBox;

    yield await getAllIncome(userId);

    yield* box.watch().asyncMap((_) => getAllIncome(userId));
  }

  Future<Box<Map<dynamic, dynamic>>> get _incomeBox async {
    if (!Hive.isBoxOpen(_boxName)) {
      await init();
    }

    return Hive.box<Map<dynamic, dynamic>>(_boxName);
  }

  IncomeModel _incomeFromStoredMap(Map<dynamic, dynamic> storedIncome) {
    return IncomeModel.fromMap(
      storedIncome.map((key, value) => MapEntry(key.toString(), value)),
    );
  }
}
