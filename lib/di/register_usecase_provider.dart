import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_demo_app/di/auth_provider.dart';
import 'package:news_demo_app/features/auth/domain/usecases/register_user_usecase.dart';

final registerUseCaseProvider = Provider<RegisterUserUsecase>(
  (ref) => RegisterUserUsecase(ref.read(authRepositoryProvider)),
);
