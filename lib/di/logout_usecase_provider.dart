import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_demo_app/di/auth_provider.dart';
import 'package:news_demo_app/features/auth/domain/usecases/logout_usecase.dart';

final logoutUseCaseProvider = Provider<LogoutUseCase>(
  (ref) => LogoutUseCase(ref.read(authRepositoryProvider)),
);
