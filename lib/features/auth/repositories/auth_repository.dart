import 'package:firebase_auth/firebase_auth.dart';

import '../services/auth_service.dart';

abstract class AuthRepository {
  User? get currentUser;
  Stream<User?> authStateChanges();
  Future<User?> signInWithEmailAndPassword(String email, String password);
  Future<User?> registerWithEmailAndPassword(
    String name,
    String email,
    String password,
  );
  Future<void> signOut();
}

class FirebaseAuthRepository implements AuthRepository {
  FirebaseAuthRepository({required this.authService});

  final AuthService authService;

  @override
  User? get currentUser => authService.currentUser;

  @override
  Stream<User?> authStateChanges() => authService.authStateChanges();

  @override
  Future<User?> signInWithEmailAndPassword(String email, String password) {
    return authService.signInWithEmailAndPassword(email, password);
  }

  @override
  Future<User?> registerWithEmailAndPassword(
    String name,
    String email,
    String password,
  ) {
    return authService.registerWithEmailAndPassword(name, email, password);
  }

  @override
  Future<void> signOut() => authService.signOut();
}
