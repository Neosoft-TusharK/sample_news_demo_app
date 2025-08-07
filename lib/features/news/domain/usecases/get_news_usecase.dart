import '../entities/news.dart';
import '../repositories/news_repository.dart';

class GetNewsUseCase {
  final NewsRepository repo;

  GetNewsUseCase(this.repo);

  Future<(List<News>, String?)> call({String? page, String? query}) {
    return repo.getNews(page: page, query: query);
  }
}
