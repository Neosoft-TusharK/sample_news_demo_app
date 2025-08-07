import '../entities/news.dart';

abstract class NewsRepository {
  Future<(List<News>, String?)> getNews({String? page, String? query});
}
