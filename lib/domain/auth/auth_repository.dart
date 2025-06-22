abstract class AuthRepository {
  Future<void> login({required String email, required String password});
  Future<void> logout();
  Future<void> signUp({
    required String email,
    required String password,
    required String name, // Added
  });
}
