import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:world/src/screens/review_view.dart';

import 'models/Reviews.dart';

class ArticleContainer_review extends StatelessWidget {
  final ReviewData reviewData;

  const ArticleContainer_review({Key? key, required this.reviewData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 11,
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 2,
          vertical: 1,
        ),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.all(
            Radius.circular(12),
          ),
        ),
        child: Row(
          children: [
            Container(
              child: _myImg(reviewData.image),
              width: 120,
              height: 120,
            ),
            SizedBox(
              width: 50,
            ),
            Expanded( // Expand this column to take the remaining space
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '店名:${reviewData.shopname}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    '料理名:${reviewData.dishname}',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    maxLines: 2,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    DateFormat('yyyy/MM/dd').format(
                      DateTime.parse('${reviewData.created_at}'),
                    ),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              Reviewsshow(reviewData: reviewData),
                          fullscreenDialog: true,
                        ),
                      );
                    },
                    child: Text(
                      '表示',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _myImg(String url) {
  print(url);
  return FittedBox(
    fit: BoxFit.contain,
    child: url == 'img/' // Use a placeholder image URL if 'url' is 'img/'
        ? Image.network(
            'https://www.shoshinsha-design.com/wp-content/uploads/2020/05/noimage-760x460.png',
          )
        : Image.network('http://44.218.199.137:8080/$url'),
  );
}