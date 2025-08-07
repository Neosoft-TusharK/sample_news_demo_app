import 'package:news_demo_app/features/auth/domain/repositories/auth_repository.dart';
import '../entities/user_entity.dart';

class LoginUsecase {
  final AuthRepository repository;

  LoginUsecase(this.repository);

  Future<UserEntity> call(String email, String password) {
    return repository.login(email, password);
  }
}
