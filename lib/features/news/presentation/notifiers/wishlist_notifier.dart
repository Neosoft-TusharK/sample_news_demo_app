// 📁 presentation/notifiers/wishlist_notifier.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/datasources/wishlist_local_data_source.dart';
import '../../data/models/news_hive_model.dart';

class WishlistNotifier extends StateNotifier<Set<String>> {
  final WishlistLocalDataSource dataSource;
  bool isFetchingMore = false;
  WishlistNotifier(this.dataSource) : super({}) {
    _loadWishlist();
  }

  Future<void> _loadWishlist() async {
    final items = await dataSource.getWishlist();
    state = items.map((e) => e.articleId).toSet();
  }

  Future<void> toggleWishlist(NewsHiveModel news) async {
    final isSaved = state.contains(news.articleId);
    if (isSaved) {
      await dataSource.removeFromWishlist(news.articleId);
      state = {...state}..remove(news.articleId);
    } else {
      await dataSource.addToWishlist(news);
      state = {...state}..add(news.articleId);
    }
  }

  bool isWishlisted(String id) => state.contains(id);
}
