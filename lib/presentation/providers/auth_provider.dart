import 'package:flutter/foundation.dart';
import '../../domain/repositories/auth_repository.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  final AuthRepository _repo;
  String? uid;
  bool loading = false;
  String? error;

  AuthProvider(this._repo) {
    _repo.authStateChanges().listen((u) {
      uid = u;
      notifyListeners();
    });
  }

  Future<String?> signIn(String email, String password) async {
    loading = true;
    error = null;
    notifyListeners();
    try {
      final uid = await _repo.signIn(email, password);
      return uid;
    } catch (e) {
      error = e.toString();
      return null;
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  Future<String?> signUp(String email, String password) async {
    loading = true;
    error = null;
    notifyListeners();

    try {
      final uid = await _repo.signUp(email, password);
      return uid;
    } catch (e) {
      error = e.toString();
      return null;
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  Future<void> signOut() async {
    loading = true;
    error = null;
    notifyListeners();

    try {
      await _repo.signOut();
    } catch (e) {
      error = e.toString();
    } finally {
      loading = false;
      notifyListeners();
    }
  }
}
