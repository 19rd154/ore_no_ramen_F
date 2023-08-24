import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:world/src/screens/review_view.dart';

import 'models/Reviews.dart';

class ArticleContainer_review extends StatelessWidget {
  final ReviewData reviewData;

  const ArticleContainer_review({super.key, required this.reviewData});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 11,
      ),
      child: 
          
          Container(
        padding: const EdgeInsets.symmetric(
          // 内側の余白を指定
          horizontal: 2,
          vertical: 1,
        ),
        decoration: const BoxDecoration(
          color: Colors.black, // 背景色を指定
          borderRadius: BorderRadius.all(
            Radius.circular(12), // 角丸を設定
          ),
        ),
        child: Row(
          children: [Container(
        child: _myImg(reviewData.image),
        width: 120,
        height: 120,
      ),SizedBox(height: 50,
  width: 50,
  ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 店舗名
                Text(
                  '店名:${reviewData.shopname}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
                // ryourimei
                Text(
                  '料理名:${reviewData.dishname}',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                // 日付
                Text(
                    DateFormat('yyyy/MM/dd').format(DateTime.parse('${reviewData.created_at}')),
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                    ),
                ),
                  TextButton( // ここから
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Reviewsshow(reviewData: reviewData),
                    fullscreenDialog: true,
                  ),
                );
              },
              child :Text('表示',style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,))),
              ]     
            ),
        
          ],
        ),
      ),
    );
  }
}

Widget _myImg(String url){
  print(url);
  return FittedBox(
    fit: BoxFit.contain,
    child:
    url=='img/'?Image.network('https://www.shoshinsha-design.com/wp-content/uploads/2020/05/noimage-760x460.png',):Image.network('http://44.218.199.137:8080/$url',),
  );
}