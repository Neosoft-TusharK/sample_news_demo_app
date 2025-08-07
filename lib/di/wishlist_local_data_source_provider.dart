// 📁 di/wishlist_local_data_source_provider.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_demo_app/features/news/data/datasources/wishlist_local_data_source.dart';

final wishlistLocalDataSourceProvider = Provider<WishlistLocalDataSource>(
  (ref) => WishlistLocalDataSourceImpl(),
);
