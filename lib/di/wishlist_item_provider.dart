// 📁 presentation/providers/wishlist_items_provider.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_demo_app/features/news/data/models/news_hive_model.dart';
import '../../di/wishlist_local_data_source_provider.dart';

final wishlistItemsProvider = FutureProvider<List<NewsHiveModel>>((ref) async {
  final ds = ref.read(wishlistLocalDataSourceProvider);
  return await ds.getWishlist();
});
