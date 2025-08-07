import '../../domain/entities/news.dart';
import '../../domain/repositories/news_repository.dart';
import '../datasources/news_remote_data_source.dart';
import '../datasources/news_local_data_source.dart';
import '../models/news_model.dart';

class NewsRepositoryImpl implements NewsRepository {
  final NewsRemoteDataSource remote;
  final NewsLocalDataSource local;

  NewsRepositoryImpl(this.remote, this.local);

  @override
  Future<(List<News>, String?)> getNews({String? page, String? query}) async {
    try {
      final (remoteNews, nextPage) = await remote.getNews(
        page: page,
        query: query,
      );
      final newsEntities = remoteNews.map((e) => e.toEntity()).toList();
      if (page == null) {
        await local.cacheNews(newsEntities);
      }
      return (newsEntities, nextPage);
    } catch (e) {
      if (page == null) {
        return (await local.getCachedNews(), null);
      }
      rethrow;
    }
  }
}
