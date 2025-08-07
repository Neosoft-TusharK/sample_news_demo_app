import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_demo_app/features/news/domain/usecases/get_news_usecase.dart';
import 'package:news_demo_app/di/news_usecase_provider.dart';
import '../../domain/entities/news.dart';

final newsNotifierProvider =
    StateNotifierProvider<NewsNotifier, AsyncValue<List<News>>>(
      (ref) => NewsNotifier(ref.read(getNewsUseCaseProvider)),
    );

class NewsNotifier extends StateNotifier<AsyncValue<List<News>>> {
  final GetNewsUseCase _getNewsUseCase;

  List<News> _newsList = [];
  String? _nextPage;
  bool isFetchingMore = false;

  NewsNotifier(this._getNewsUseCase) : super(const AsyncLoading());

  bool get canLoadMore => _nextPage != null && !isFetchingMore;

  /// Called initially and during pagination/search
  Future<void> fetchNews({
    bool loadMore = false,
    String? query = "Bank",
  }) async {
    if (loadMore && !canLoadMore) return;

    if (!loadMore) {
      state = const AsyncLoading();
      _newsList = []; // clear previous results
      _nextPage = null;
    }

    isFetchingMore = loadMore;

    try {
      final (news, nextPage) = await _getNewsUseCase(
        page: loadMore ? _nextPage : null,
        query: query,
      );

      _nextPage = nextPage;
      _newsList = loadMore ? [..._newsList, ...news] : news;

      state = AsyncData(_newsList);
    } catch (e, st) {
      state = AsyncError(e, st);
    } finally {
      isFetchingMore = false;
    }
  }
}
