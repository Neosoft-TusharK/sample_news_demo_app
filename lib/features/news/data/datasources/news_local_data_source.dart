import '../../domain/entities/news.dart';
import '../models/news_hive_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

abstract class NewsLocalDataSource {
  Future<void> cacheNews(List<News> articles);
  Future<List<News>> getCachedNews();
}

class NewsLocalDataSourceImpl implements NewsLocalDataSource {
  static const String _boxName = 'newsBox';

  @override
  Future<void> cacheNews(List<News> articles) async {
    final box = await Hive.openBox<NewsHiveModel>(_boxName);
    final hiveModels = articles.map(NewsHiveModel.fromEntity).toList();
    await box.clear();
    await box.addAll(hiveModels);
  }

  @override
  Future<List<News>> getCachedNews() async {
    final box = await Hive.openBox<NewsHiveModel>(_boxName);
    return box.values.map((e) => e.toEntity()).toList();
  }
}
