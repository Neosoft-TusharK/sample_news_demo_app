// 📁 lib/di/news_remote_data_source_provider.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_demo_app/di/network_provider.dart';
import 'package:news_demo_app/features/news/data/datasources/news_remote_data_source.dart';

final newsRemoteDataSourceProvider = Provider<NewsRemoteDataSource>(
  (ref) => NewsRemoteDataSourceImpl(ref.watch(dioProvider)),
);
