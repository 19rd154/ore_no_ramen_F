import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'models/Reviews.dart';

class ArticleContainer_review extends StatelessWidget {
  final ReviewData reviewData;

  const ArticleContainer_review({super.key, required this.reviewData});

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
          color: Color(0xFF55C500), // 背景色を指定
          borderRadius: BorderRadius.all(
            Radius.circular(32), // 角丸を設定
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 店舗名
            Text(
              '店名:${reviewData.shopname}',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
              ),
            ),
            // ryourimei
            Text(
              '料理名:${reviewData.dishname}',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            // 日付
            Text(
                DateFormat('yyyy/MM/dd').format(reviewData.created_at),
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                ),
            ),
          ]     
        ),
      ),
    );
  }
}