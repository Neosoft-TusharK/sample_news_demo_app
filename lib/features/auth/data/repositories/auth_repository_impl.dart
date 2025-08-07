import 'package:firebase_auth/firebase_auth.dart';
import 'package:news_demo_app/features/auth/data/datasources/firebase_auth_datasource.dart';
import 'package:news_demo_app/features/auth/domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthDatasource datasource;
  final FirebaseAuth firebaseAuth;

  AuthRepositoryImpl(this.firebaseAuth, this.datasource);

  @override
  Future<void> logout() async {
    await firebaseAuth.signOut();
  }

  @override
  Future<UserEntity> login(String email, String password) async {
    return await datasource.login(email, password);
  }

  @override
  Future<UserEntity> register(
    String email,
    String password,
    String name,
  ) async {
    return await datasource.register(email, password, name);
  }
}
