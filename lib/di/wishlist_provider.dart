// 📁 presentation/providers/wishlist_provider.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_demo_app/features/news/presentation/notifiers/wishlist_notifier.dart';
import '../../di/wishlist_local_data_source_provider.dart';

final wishlistProvider = StateNotifierProvider<WishlistNotifier, Set<String>>(
  (ref) => WishlistNotifier(ref.read(wishlistLocalDataSourceProvider)),
);
