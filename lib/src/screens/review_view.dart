import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:world/src/screens/delete.dart';
import 'package:world/src/screens/review_post.dart';
import 'package:world/src/screens/update.dart';
import '../app.dart';
import 'models/Reviews.dart';
import 'models/update.dart';

class Reviewsshow extends StatelessWidget {
  final ReviewData reviewData;

  const Reviewsshow({super.key, required this.reviewData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('レビュー'),
        backgroundColor: Colors.black,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(
          // 内側の余白を指定
          horizontal: 2,
          vertical: 1,
        ),
        decoration: const BoxDecoration(
           // 背景色を指定
          borderRadius: BorderRadius.all(
            Radius.circular(12), // 角丸を設定
          ),
        ),
        child: 
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [SizedBox(height: 20,
  
  ),Row(
          children: [Container(
        child: _myImg(reviewData.image),
        width: 150,
        height: 150,
      ),SizedBox(height: 10,
  width: 10,
  ),
                // 店舗名
                Flexible(
                  child: Column(
                    children: [
                      Text(
                        '店名:${reviewData.shopname}',
                        overflow: TextOverflow.ellipsis,
                          maxLines: 4, 
                        style: const TextStyle(
                          
                          fontSize: 20,
                        ),
                      ),
                    Text(
                    '料理名:${reviewData.dishname}',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 20,
                      
                     
                    ),
                  ),
                  // 日付
                  Text(
                      DateFormat('yyyy/MM/dd').format(DateTime.parse('${reviewData.created_at}')),
                      style: const TextStyle(
                          
                          fontSize: 16,
                      ),
                  ),],
                  ),
                ),
                // ryourimei
                
                  
              ]     
            ),
        SizedBox(height: 10,width: 50,),
          Center(child: Text('${reviewData.content}',overflow: TextOverflow.ellipsis,
                        maxLines: 4, style: const TextStyle(
                        
                        fontSize: 24,),),),
          
          Center( child:_ratingBar(reviewData.evaluate.toDouble())),
                  Text(
                    'Rating: ${reviewData.evaluate}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                ),Center(
                child:reviewData.bookmark==1?Icon(Icons.favorite,size: 50,):Icon(Icons.favorite_border,size: 50,),
                ),ElevatedButton(//送信ボタン
                  onPressed: () {delete_Http(reviewData.reviewid);//postリクエストの呼び出し
                    Navigator.push( 
                      context,
                      MaterialPageRoute(builder: (context) => const MyStatefulWidget(),)//リクエスト後にホームに戻る
                    );
                  },

                  child: const Text('reviewを削除'),//ボタンの表示テキスト
                ),ElevatedButton(//送信ボタン
                  onPressed: () {//postリクエストの呼び出し
                    Navigator.push( 
                      context,
                      MaterialPageRoute(builder: (context) => ReviewUpdate(review_id: reviewData.reviewid, shop_id: reviewData.shopid,),)//リクエスト後にホームに戻る
                    );
                  },

                  child: const Text('reviewを更新'),//ボタンの表示テキスト
                ),],
        ),
      ),
              
    );
  }
  
}
Widget _ratingBar(double _rating) {
    return RatingBar.builder(
      initialRating: _rating, //初期値
      minRating: 1,
      direction: Axis.horizontal, //縦か横か
      unratedColor: Colors.amber.withAlpha(50), //アイコンの色
      itemCount: 5, //段階数
      itemSize: 50.0, //アイコンの大きさ
      itemPadding: const EdgeInsets.symmetric(horizontal: 4.0), //アイテム同士の間隔
      itemBuilder: (context, _) => Icon(
        Icons.star,
        color: Colors.amber,
      ), onRatingUpdate: (Null) {  },
      ignoreGestures: true,
    );
    }

Widget _myImg(String url){
  return FittedBox(
    fit: BoxFit.contain,
    child:
    url=='img/'?Image.network('https://www.shoshinsha-design.com/wp-content/uploads/2020/05/noimage-760x460.png',):Image.network('http://44.218.199.137:8080/$url',),
  );
}