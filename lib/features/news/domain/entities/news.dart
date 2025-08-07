class News {
  final String articleId;
  final String title;
  final String? description;
  final String? imageUrl;
  final String pubDate;
  final String link;

  News({
    required this.articleId,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.pubDate,
    required this.link,
  });
}
