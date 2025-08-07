import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_demo_app/di/auth_provider.dart';
import 'package:news_demo_app/features/auth/domain/usecases/login_usecase.dart';

final loginUsecaseProvider = Provider<LoginUsecase>(
  (ref) => LoginUsecase(ref.read(authRepositoryProvider)),
);
