import 'package:hive/hive.dart';
import '../../domain/entities/news.dart';

part 'news_hive_model.g.dart';

@HiveType(typeId: 0)
class NewsHiveModel extends HiveObject {
  @HiveField(0)
  final String articleId;

  @HiveField(1)
  final String? title;

  @HiveField(2)
  final String? description;

  @HiveField(3)
  final String? imageUrl;

  @HiveField(4)
  final String? pubDate;

  @HiveField(5)
  final String? link;

  NewsHiveModel({
    required this.articleId,
    required this.title,
    this.description,
    this.imageUrl,
    required this.pubDate,
    required this.link,
  });

  factory NewsHiveModel.fromEntity(News entity) {
    return NewsHiveModel(
      articleId: entity.articleId,
      title: entity.title,
      description: entity.description,
      imageUrl: entity.imageUrl,
      pubDate: entity.pubDate,
      link: entity.link,
    );
  }

  News toEntity() => News(
    articleId: articleId,
    title: title ?? '',
    description: description,
    imageUrl: imageUrl,
    pubDate: pubDate ?? '',
    link: link ?? '',
  );
}
