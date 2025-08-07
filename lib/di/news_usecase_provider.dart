import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_demo_app/features/news/domain/usecases/get_news_usecase.dart';
import 'package:news_demo_app/di/news_repository_provider.dart';

final getNewsUseCaseProvider = Provider<GetNewsUseCase>(
  (ref) => GetNewsUseCase(ref.read(newsRepositoryProvider)),
);
