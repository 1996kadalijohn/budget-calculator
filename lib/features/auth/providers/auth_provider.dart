import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../repositories/auth_repository.dart';

enum AuthStatus { initial, loading, authenticated, unauthenticated }

class AppAuthProvider extends ChangeNotifier {
  AppAuthProvider({required this._repository}) {
    _listenToAuthState();
  }

  final AuthRepository _repository;
  AuthStatus _status = AuthStatus.initial;
  User? _user;
  String? _errorMessage;

  AuthStatus get status => _status;
  User? get user => _user;
  String? get errorMessage => _errorMessage;
  bool get isAuthenticated =>
      _status == AuthStatus.authenticated && _user != null;

  void _listenToAuthState() {
    _repository.authStateChanges().listen((user) {
      _user = user;
      _status = user == null
          ? AuthStatus.unauthenticated
          : AuthStatus.authenticated;
      _errorMessage = null;
      notifyListeners();
    });
  }

  Future<void> checkAuthStatus() async {
    _status = AuthStatus.loading;
    notifyListeners();

    try {
      _user = _repository.currentUser;
      _status = _user == null
          ? AuthStatus.unauthenticated
          : AuthStatus.authenticated;
    } catch (e) {
      _status = AuthStatus.unauthenticated;
      _errorMessage = e.toString();
    } finally {
      notifyListeners();
    }
  }

  Future<void> signIn(String email, String password) async {
    _status = AuthStatus.loading;
    _errorMessage = null;
    notifyListeners();

    try {
      final user = await _repository.signInWithEmailAndPassword(
        email,
        password,
      );
      _user = user;
      _status = user == null
          ? AuthStatus.unauthenticated
          : AuthStatus.authenticated;
    } catch (e) {
      _status = AuthStatus.unauthenticated;
      _errorMessage = e.toString();
    } finally {
      notifyListeners();
    }
  }

  Future<void> register(String name, String email, String password) async {
    _status = AuthStatus.loading;
    _errorMessage = null;
    notifyListeners();

    try {
      final user = await _repository.registerWithEmailAndPassword(
        name,
        email,
        password,
      );
      _user = user;
      _status = user == null
          ? AuthStatus.unauthenticated
          : AuthStatus.authenticated;
    } catch (e) {
      _status = AuthStatus.unauthenticated;
      _errorMessage = e.toString();
    } finally {
      notifyListeners();
    }
  }

  Future<void> signOut() async {
    _status = AuthStatus.loading;
    _errorMessage = null;
    notifyListeners();

    try {
      await _repository.signOut();
      _user = null;
      _status = AuthStatus.unauthenticated;
    } catch (e) {
      _status = AuthStatus.unauthenticated;
      _errorMessage = e.toString();
    } finally {
      notifyListeners();
    }
  }
}
