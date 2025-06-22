import 'package:attireit/data/auth_remote_datasource.dart';
import 'package:attireit/domain/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDatasource remoteDatasource;
  AuthRepositoryImpl(this.remoteDatasource);

  @override
  Future<void> login({required String email, required String password}) {
    return remoteDatasource.login(email, password);
  }

  @override
  Future<void> logout() {
    return remoteDatasource.logout();
  }

  @override
  Future<void> signUp({
    required String email,
    required String password,
    required String name,
  }) {
    return remoteDatasource.signUp(email, password, name);
  }
}
