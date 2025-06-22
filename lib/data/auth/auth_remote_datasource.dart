import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AuthRemoteDatasource {
  Future<void> login(String email, String password);
  Future<void> logout();
  Future<void> signUp(String email, String password, String name);
}

class AuthRemoteDatasourceImpl implements AuthRemoteDatasource {
  final SupabaseClient client;
  AuthRemoteDatasourceImpl(this.client);

  @override
  Future<void> login(String email, String password) async {
    final response = await client.auth.signInWithPassword(
      email: email,
      password: password,
    );
    if (response.session == null) {
      throw Exception('Invalid email or password');
    }
  }

  @override
  Future<void> logout() async {
    await client.auth.signOut();
  }

  @override
  Future<void> signUp(String email, String password, String name) async {
    try {
      final response = await client.auth.signUp(
        email: email,
        password: password,
        data: {
          'full_name': name,
        },
      );

      // Check for either session or user (works with email confirmation on/off)
      if (response.session == null && response.user == null) {
        throw Exception('Sign up failed - no user created');
      }
    } catch (e) {
      throw Exception('Sign up error: ${e.toString()}');
    }
  }
}
