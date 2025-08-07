import 'package:dio/dio.dart';
import '../models/news_model.dart';

abstract class NewsRemoteDataSource {
  Future<(List<NewsModel>, String?)> getNews({String? page, String? query});
}

class NewsRemoteDataSourceImpl implements NewsRemoteDataSource {
  final Dio dio;

  NewsRemoteDataSourceImpl(this.dio);

  @override
  Future<(List<NewsModel>, String?)> getNews({
    String? page,
    String? query = "Bank",
  }) async {
    print("Api request: page=$page, query=$query");
    final response = await dio.get(
      'https://newsdata.io/api/1/latest?apikey=pub_1a6250e0999f4cd58b9eeaeb0940ad85',
      queryParameters: {
        if (page != null) 'page': page,
        if (query != null && query.isNotEmpty) 'q': query,
        'language': 'en',
      },
    );

    final results = List<Map<String, dynamic>>.from(response.data['results']);
    final news = results.map((json) => NewsModel.fromJson(json)).toList();
    final nextPage = response.data['nextPage'] as String?;
    return (news, nextPage);
  }
}
