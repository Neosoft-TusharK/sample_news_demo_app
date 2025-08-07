// 📁 presentation/screens/wishlist_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_demo_app/di/wishlist_item_provider.dart';
import 'package:news_demo_app/di/wishlist_provider.dart';
import 'package:news_demo_app/features/news/presentation/screens/news_detail_screen.dart';

class WishlistScreen extends ConsumerWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wishlist = ref.watch(wishlistItemsProvider);

    return Scaffold(
      appBar: AppBar(title: Text('Wishlist')),
      body: wishlist.when(
        loading: () => Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error loading wishlist')),
        data: (items) {
          if (items.isEmpty) {
            return Center(child: Text('No wishlisted news yet.'));
          }

          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              final news = items[index];

              return ListTile(
                leading: news.imageUrl != null
                    ? Image.network(
                        news.imageUrl!,
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                        errorBuilder: (context, _, __) =>
                            Icon(Icons.broken_image),
                      )
                    : Icon(Icons.image),
                title: Text(news.title ?? 'No Title'),
                trailing: IconButton(
                  icon: Icon(Icons.delete_outline),
                  onPressed: () async {
                    final notifier = ref.read(wishlistProvider.notifier);
                    await notifier.toggleWishlist(news);
                    ref.invalidate(wishlistItemsProvider); // refresh
                  },
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => NewsDetailsScreen(news: news.toEntity()),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
