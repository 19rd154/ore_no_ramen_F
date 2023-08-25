import 'package:flutter/material.dart';
import 'package:world/src/screens/review_post.dart';

import 'models/SearchData.dart';

class ArticleContainer extends StatelessWidget {
  const ArticleContainer({
    super.key,
    required this.article,
    required this.Username,
    required this.Password,
  });

  final UnvisitedData article;
  final String? Username;
  final String? Password;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 12,
        horizontal: 16,
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(
          // 内側の余白を指定
          horizontal: 20,
          vertical: 16,
        ),
        decoration: const BoxDecoration(
          color: Colors.black, // 背景色を指定
          borderRadius: BorderRadius.all(
            Radius.circular(32), // 角丸を設定
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 店舗名
            Text(
              '【${article.name}】',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold
              ),
            ),
            // 住所
            Text(
              '住所:${article.address}',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            // アクセス
            Text(
              'アクセス:${article.access}',
              style: const TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton.icon( // ここから
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ReviewSend(shop_id: article.id,shop_name: article.name, password: Password, username: Username,),
                    fullscreenDialog: true,
                  ),
                );
              },
              style: TextButton.styleFrom(
            backgroundColor: Color(0xFFC51162 ),
            
          ),
              label: Text('追加',style: TextStyle(
    fontSize: 20,
    color: Colors.white,
  ),),
              icon: const Icon(Icons.post_add,color: Colors.white,
              size: 30,),
            ),
          ]     
        ),
      ),
    );
  }
}