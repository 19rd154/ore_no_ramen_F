import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:world/src/screens/models/reviews.dart';

class TweetState extends StatelessWidget {
  final ReviewData reviewData;

  const TweetState({Key? key, required this.reviewData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateFormat format = DateFormat('yyyy-MM-dd');

    return Container(
      padding: const EdgeInsets.all(8), // 全体のパディングを追加
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ユーザーアイコンや背景画像のコードをここに追加
          const SizedBox(
            width: 8, // 左側に隙間を開ける
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(reviewData.shopname),
              
              const Text(''), // この行の意図が不明なため、必要な内容に修正する
              const Row(
                children: [
                  Icon(Icons.favorite),
                  // 他のアイコンやウィジェットを追加する場合はここに追加
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}






