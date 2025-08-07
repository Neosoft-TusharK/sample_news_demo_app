import 'package:news_demo_app/features/news/domain/entities/news.dart';

class NewsModel {
  final String articleId;
  final String title;
  final String? description;
  final String? imageUrl;
  final String pubDate;
  final String link;

  NewsModel({
    required this.articleId,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.pubDate,
    required this.link,
  });

  factory NewsModel.fromJson(Map<String, dynamic> json) => NewsModel(
    articleId: json['article_id'] ?? '',
    title: json['title'] ?? '',
    description: json['description'],
    imageUrl: json['image_url'],
    pubDate: json['pubDate'] ?? '',
    link: json['link'] ?? '',
  );

  Map<String, dynamic> toJson() => {
    'article_id': articleId,
    'title': title,
    'description': description,
    'image_url': imageUrl,
    'pubDate': pubDate,
    'link': link,
  };
}

extension NewsMapper on NewsModel {
  News toEntity() => News(
    articleId: articleId,
    title: title,
    description: description,
    imageUrl: imageUrl,
    pubDate: pubDate,
    link: link,
  );
}
