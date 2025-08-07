// 📁 presentation/screens/news_details_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_demo_app/di/wishlist_item_provider.dart';
import 'package:news_demo_app/di/wishlist_provider.dart';
import '../../domain/entities/news.dart';
import '../../data/models/news_hive_model.dart';

class NewsDetailsScreen extends ConsumerWidget {
  final News news;
  const NewsDetailsScreen({super.key, required this.news});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isSaved = ref.watch(wishlistProvider).contains(news.articleId);
    final notifier = ref.read(wishlistProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: Text(news.title),
        actions: [
          IconButton(
            icon: Icon(isSaved ? Icons.favorite : Icons.favorite_border),
            onPressed: () {
              final hiveModel = NewsHiveModel.fromEntity(news);
              notifier.toggleWishlist(hiveModel);
              ref.invalidate(wishlistItemsProvider); // Ensures screen updates
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (news.imageUrl != null)
              Image.network(
                news.imageUrl!,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return SizedBox(
                    height: 200,
                    child: Center(child: CircularProgressIndicator()),
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  return SizedBox(
                    height: 200,
                    child: Center(
                      child: Icon(
                        Icons.broken_image,
                        size: 60,
                        color: Colors.grey,
                      ),
                    ),
                  );
                },
              )
            else
              SizedBox(
                height: 200,
                child: Center(
                  child: Icon(
                    Icons.image_not_supported,
                    size: 60,
                    color: Colors.grey,
                  ),
                ),
              ),

            const SizedBox(height: 16),
            Text(news.title),
            const SizedBox(height: 10),
            Text(news.description ?? ''),
            const SizedBox(height: 10),
            Text('Published: ${news.pubDate}'),
          ],
        ),
      ),
    );
  }
}
