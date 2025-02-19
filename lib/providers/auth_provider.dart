import 'package:flutter/foundation.dart';

class AuthProvider with ChangeNotifier {
  bool _isAuthenticated = false;

  bool get isAuthenticated => _isAuthenticated;

  Future<void> login(String mobile, String password) async {
    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));
    _isAuthenticated = true;
    notifyListeners();
  }

  Future<void> logout() async {
    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));
    _isAuthenticated = false;
    notifyListeners();
  }

  Future<void> signup(String name, String mobile, String aadhar, String gender, String password) async {
    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));
    _isAuthenticated = true;
    notifyListeners();
  }

  Future<void> forgotPassword(String mobile) async {
    // Simulate API call for password reset
    await Future.delayed(const Duration(seconds: 2));
    notifyListeners();
  }

  Future<void> signInWithGoogle() async {
    // Simulate Google sign-in
    await Future.delayed(const Duration(seconds: 2));
    _isAuthenticated = true;
    notifyListeners();
  }

  Future<void> signInWithFacebook() async {
    // Simulate Facebook sign-in
    await Future.delayed(const Duration(seconds: 2));
    _isAuthenticated = true;
    notifyListeners();
  }
} 