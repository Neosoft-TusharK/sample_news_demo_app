// 📁 data/datasources/wishlist_local_data_source.dart

import 'package:hive/hive.dart';
import '../models/news_hive_model.dart';

abstract class WishlistLocalDataSource {
  Future<void> addToWishlist(NewsHiveModel news);
  Future<void> removeFromWishlist(String articleId);
  Future<List<NewsHiveModel>> getWishlist();
  Future<bool> isWishlisted(String articleId);
}

class WishlistLocalDataSourceImpl implements WishlistLocalDataSource {
  static const boxName = 'wishlist_news';

  Future<Box<NewsHiveModel>> _box() => Hive.openBox<NewsHiveModel>(boxName);

  @override
  Future<void> addToWishlist(NewsHiveModel news) async {
    final box = await _box();
    await box.put(news.articleId, news);
  }

  @override
  Future<void> removeFromWishlist(String articleId) async {
    final box = await _box();
    await box.delete(articleId);
  }

  @override
  Future<List<NewsHiveModel>> getWishlist() async {
    final box = await _box();
    return box.values.toList();
  }

  @override
  Future<bool> isWishlisted(String articleId) async {
    final box = await _box();
    return box.containsKey(articleId);
  }
}
