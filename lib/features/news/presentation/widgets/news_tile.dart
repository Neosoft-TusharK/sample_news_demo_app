// import 'package:flutter/material.dart';
// import 'package:news_demo_app/features/news/presentation/screens/news_detail_screen.dart';
// import '../../data/models/news_model.dart';

// class NewsTile extends StatelessWidget {
//   final NewsModel news;

//   const NewsTile({super.key, required this.news});

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//       child: ListTile(
//         contentPadding: const EdgeInsets.all(12),
//         leading: Image.network(news.imageUrl, width: 70, fit: BoxFit.cover),
//         title: Text(news.title),
//         subtitle: Text(
//           news.description,
//           maxLines: 2,
//           overflow: TextOverflow.ellipsis,
//         ),
//         onTap: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(builder: (_) => NewsDetailScreen(news: news)),
//           );
//         },
//       ),
//     );
//   }
// }
