import 'package:attireit/domain/auth_repository.dart';

class SignUpUser {
  final AuthRepository repository;
  SignUpUser(this.repository);

  Future<void> call({
    required String email,
    required String password,
    required String name, // Added
  }) {
    return repository.signUp(
      email: email,
      password: password,
      name: name,
    );
  }
}
