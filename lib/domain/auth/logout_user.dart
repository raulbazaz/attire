import 'package:attireit/domain/auth_repository.dart';

class LogoutUser {
  final AuthRepository repository;
  LogoutUser(this.repository);

  Future<void> call() {
    return repository.logout();
  }
}
