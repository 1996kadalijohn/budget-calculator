import 'package:buget_calculator/features/auth/repositories/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FakeAuthRepository implements AuthRepository {
  @override
  User? get currentUser => null;

  @override
  Stream<User?> authStateChanges() => const Stream.empty();

  @override
  Future<User?> signInWithEmailAndPassword(String email, String password) async => null;

  @override
  Future<User?> registerWithEmailAndPassword(String name, String email, String password) async => null;

  @override
  Future<void> signOut() async {}
}
