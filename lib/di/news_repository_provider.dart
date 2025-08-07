// 📁 lib/di/news_repository_provider.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_demo_app/features/news/data/repositories/news_repository_impl.dart';
import 'package:news_demo_app/features/news/domain/repositories/news_repository.dart';
import 'package:news_demo_app/di/news_local_data_source_provider.dart';
import 'package:news_demo_app/di/news_remote_data_source_provider.dart';

final newsRepositoryProvider = Provider<NewsRepository>(
  (ref) => NewsRepositoryImpl(
    ref.read(newsRemoteDataSourceProvider),
    ref.read(newsLocalDataSourceProvider),
  ),
);
