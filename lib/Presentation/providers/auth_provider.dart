import 'package:attireit/domain/logout_user.dart';
import 'package:attireit/domain/signup_user.dart';
import 'package:flutter/foundation.dart';

class AuthProvider with ChangeNotifier {
  final LogoutUser logoutUser;
  final SignUpUser signUpUser;

  AuthProvider(this.logoutUser, this.signUpUser);

  Future<void> logout() async {
    try {
      await logoutUser();
      notifyListeners();
    } catch (e) {
      throw Exception('Logout failed: $e');
    }
  }

  Future<void> signUp(String email, String password, String name) async {
    try {
      await signUpUser(
        email: email,
        password: password,
        name: name, // Added
      );
      notifyListeners();
    } catch (e) {
      throw Exception('Sign up failed: $e');
    }
  }
}
