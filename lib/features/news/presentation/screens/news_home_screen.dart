import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'news_screen.dart';
import 'wishlist_screen.dart';

class NewsHomeScreen extends ConsumerStatefulWidget {
  const NewsHomeScreen({super.key});

  @override
  ConsumerState<NewsHomeScreen> createState() => _NewsHomeScreenState();
}

class _NewsHomeScreenState extends ConsumerState<NewsHomeScreen> {
  int _selectedIndex = 0;

  final _pages = [
    NewsScreen(), // already implemented
    WishlistScreen(), // already implemented
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        onTap: (index) => setState(() => _selectedIndex = index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.article_outlined),
            label: 'News',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Wishlist',
          ),
        ],
      ),
    );
  }
}
