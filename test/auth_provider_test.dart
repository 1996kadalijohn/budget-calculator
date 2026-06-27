import 'package:buget_calculator/features/auth/providers/auth_provider.dart';
import 'package:buget_calculator/features/auth/repositories/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';

class FakeAuthRepository implements AuthRepository {
  @override
  Future<User?> signInWithEmailAndPassword(String email, String password) async => null;

  @override
  Future<User?> registerWithEmailAndPassword(String name, String email, String password) async => null;

  @override
  Future<void> signOut() async {}

  @override
  User? get currentUser => null;

  @override
  Stream<User?> authStateChanges() => const Stream.empty();
}

void main() {
  test('provider starts unauthenticated when no user exists', () async {
    final provider = AppAuthProvider(repository: FakeAuthRepository());

    await provider.checkAuthStatus();

    expect(provider.status, AuthStatus.unauthenticated);
  });
}
