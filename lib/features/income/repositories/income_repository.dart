import '../models/income_model.dart';

/// Coordinates income persistence between local storage and remote services.
///
/// This repository intentionally contains no UI code and no direct Hive or
/// Firestore implementation details. Concrete local and remote services will be
/// connected here when those layers are implemented.
class IncomeRepository {
  /// Creates an [IncomeRepository].
  ///
  /// [localService] and [firestoreService] are reserved for future
  /// [IncomeLocalService] and [IncomeFirestoreService] dependencies.
  const IncomeRepository({
    this.localService,
    this.firestoreService,
  });

  /// Future local persistence dependency.
  ///
  /// TODO: Replace [Object] with IncomeLocalService when it is implemented.
  final Object? localService;

  /// Future remote persistence dependency.
  ///
  /// TODO: Replace [Object] with IncomeFirestoreService when it is implemented.
  final Object? firestoreService;

  /// Returns all income records for [userId].
  Future<List<IncomeModel>> getAllIncome(String userId) async {
    // TODO: Load income from local storage and/or Firestore for this user.
    throw UnimplementedError('getAllIncome is not implemented yet.');
  }

  /// Returns a single income record by [id], or null when it does not exist.
  Future<IncomeModel?> getIncomeById(String id) async {
    // TODO: Resolve income by id from local storage and/or Firestore.
    throw UnimplementedError('getIncomeById is not implemented yet.');
  }

  /// Adds [income] to the configured income data stores.
  Future<void> addIncome(IncomeModel income) async {
    // TODO: Persist income locally and remotely.
    throw UnimplementedError('addIncome is not implemented yet.');
  }

  /// Updates an existing [income] record in the configured data stores.
  Future<void> updateIncome(IncomeModel income) async {
    // TODO: Update income locally and remotely.
    throw UnimplementedError('updateIncome is not implemented yet.');
  }

  /// Deletes an income record by [id] from the configured data stores.
  Future<void> deleteIncome(String id) async {
    // TODO: Delete income locally and remotely.
    throw UnimplementedError('deleteIncome is not implemented yet.');
  }

  /// Watches income records for [userId].
  Stream<List<IncomeModel>> watchIncome(String userId) {
    // TODO: Expose a stream that coordinates local cache and Firestore updates.
    throw UnimplementedError('watchIncome is not implemented yet.');
  }
}
