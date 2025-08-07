// 📁 lib/di/news_local_data_source_provider.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_demo_app/features/news/data/datasources/news_local_data_source.dart';

final newsLocalDataSourceProvider = Provider<NewsLocalDataSource>(
  (ref) => NewsLocalDataSourceImpl(),
);
