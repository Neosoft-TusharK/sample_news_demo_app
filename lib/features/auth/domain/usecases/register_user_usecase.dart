import 'package:news_demo_app/features/auth/domain/entities/user_entity.dart';
import 'package:news_demo_app/features/auth/domain/repositories/auth_repository.dart';

class RegisterUserUsecase {
  final AuthRepository repository;

  RegisterUserUsecase(this.repository);

  Future<UserEntity> call(String email, String password, String name) {
    return repository.register(email, password, name);
  }
}
