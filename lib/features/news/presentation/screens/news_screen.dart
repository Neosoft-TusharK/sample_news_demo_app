import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_demo_app/core/network/connectivity_provider.dart';
import 'package:news_demo_app/di/logout_usecase_provider.dart';
import 'package:news_demo_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:news_demo_app/features/auth/presentation/screens/login_screen.dart';
import 'package:news_demo_app/features/news/presentation/screens/news_detail_screen.dart';
import '../providers/news_provider.dart';

class NewsScreen extends ConsumerStatefulWidget {
  const NewsScreen({super.key});

  @override
  ConsumerState<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends ConsumerState<NewsScreen> {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController(); // ✅

  String? _searchQuery;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(newsNotifierProvider.notifier).fetchNews();
    });

    _scrollController.addListener(_onScroll); // ✅
  }

  void _onScroll() {
    final notifier = ref.read(newsNotifierProvider.notifier);
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 300) {
      if (notifier.canLoadMore && !notifier.isFetchingMore) {
        notifier.fetchNews(loadMore: true, query: _searchQuery);
      }
    }
  }

  void _onSearch(String query) {
    setState(() => _searchQuery = query.isEmpty ? null : query);
    ref.read(newsNotifierProvider.notifier).fetchNews(query: _searchQuery);
  }

  @override
  void dispose() {
    _scrollController.dispose(); // ✅
    super.dispose();
  }

  void _confirmLogout() async {
    final shouldLogout = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to log out?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Logout'),
          ),
        ],
      ),
    );

    if (shouldLogout ?? false) {
      await _handleLogout();
    }
  }

  Future<void> _handleLogout() async {
    try {
      await ref.read(logoutUseCaseProvider).call();
      ref.read(authUserProvider.notifier).state = null;
      if (mounted) {
        Navigator.of(
          context,
        ).pushReplacement(MaterialPageRoute(builder: (_) => LoginScreen()));
      }
    } catch (e) {
      if (context.mounted) {
        // Show error message
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Logout failed: $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(newsNotifierProvider);
    final notifier = ref.read(newsNotifierProvider.notifier);
    // 👇 Listen for connectivity changes and show snackbar
    ref.listen(connectivityStatusProvider, (previous, next) {
      final result = next.asData?.value;
      final isConnected = result?[0] != ConnectivityResult.none;

      if (!isConnected) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("No Internet Connection"),
            duration: Duration(days: 1), // persistent
            behavior: SnackBarBehavior.floating,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
      }
    });
    return Scaffold(
      appBar: AppBar(
        title: Text('News'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
            onPressed: _confirmLogout,
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: TextField(
              controller: _searchController,
              onSubmitted: _onSearch,
              decoration: InputDecoration(
                hintText: 'Search news...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          Expanded(
            child: state.when(
              loading: () => Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text('Error: $e')),
              data: (newsList) => RefreshIndicator(
                onRefresh: () async {
                  await ref
                      .read(newsNotifierProvider.notifier)
                      .fetchNews(query: _searchQuery); // Refresh latest
                },
                child: ListView.builder(
                  controller: _scrollController, // ✅
                  itemCount: newsList.length + 1,
                  itemBuilder: (context, index) {
                    if (index == newsList.length) {
                      return notifier.canLoadMore
                          ? Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(child: CircularProgressIndicator()),
                            )
                          : SizedBox();
                    }

                    final news = newsList[index];

                    return ListTile(
                      leading: news.imageUrl != null
                          ? Image.network(
                              news.imageUrl!,
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
                              loadingBuilder:
                                  (context, child, loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return SizedBox(
                                      width: 60,
                                      height: 60,
                                      child: Center(
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                        ),
                                      ),
                                    );
                                  },
                              errorBuilder: (context, error, stackTrace) {
                                return SizedBox(
                                  width: 60,
                                  height: 60,
                                  child: Icon(
                                    Icons.broken_image,
                                    size: 30,
                                    color: Colors.grey,
                                  ),
                                );
                              },
                            )
                          : SizedBox(
                              width: 60,
                              height: 60,
                              child: Icon(
                                Icons.image_not_supported,
                                size: 30,
                                color: Colors.grey,
                              ),
                            ),
                      title: Text(news.title),

                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => NewsDetailsScreen(news: news),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
