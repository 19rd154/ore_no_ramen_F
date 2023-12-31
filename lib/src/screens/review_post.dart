import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:dio/dio.dart';

import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;


import '../app.dart';
import 'models/Post.dart';
import 'models/Urlbase.dart';


class ReviewSend extends StatefulWidget {
  const ReviewSend({Key? key,
  required this.shop_id,
  required this.shop_name,
  required this.username,
  required this.password,}) : super(key: key);
  final String shop_id;
  final String shop_name;
    final String? username;
  final String? password;
  @override
  _ReviewSendState createState() => _ReviewSendState();
}

class _ReviewSendState extends State<ReviewSend> {
  String _text = '';
  String _dishname='';
  String _shopname = '';
  File? _image;
  String escape = '0'; 
  int bookmark=0;
 final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _rating = _initialRating;
  }

    late double _rating=0.0;
  final double _initialRating = 0.0;

  IconData? _selectedIcon;


    Future<void> _getImage() async {
    try {
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          _image = File(pickedFile.path);
        });
      } else {
        print('No image selected.');
      }
    } catch (e) {
      print('Error selecting image: $e');
    }
  }


 void _ReviewText(String ReviewText) {
    setState(() {
      _text = ReviewText;
    });
    print(_text);
  }
  void _dishnameText(String dishname) {
    setState(() {
      _dishname = dishname;
    });print(_dishname);
  }
 void _shopnameText(String shopname) {
    setState(() {
      _shopname = shopname;
    });print(_shopname);
  }
 void _saveText() {
    // テキストを変数に保存する処理
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('投稿'),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
  child:Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8.0),
            child: Column(//画像選択
              children: [
                const Text(
                  '画像を選択',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Center(
                  child: _image == null
                      ? Image.network('https://www.shoshinsha-design.com/wp-content/uploads/2020/05/noimage-760x460.png')
                      : Image.file(_image!),
                ),
                Center(
                  child: TextButton(
                    onPressed: _getImage,
                    child: const Text('画像を選択する'),
                  ),
                )
              ],
            ),
          ),
          Container(//店名の表示
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,

                  ),
                  child: Text(widget.shop_name,style:const TextStyle(
                      fontSize: 28,
                    ),
                  ),
                ),
                 Padding(//料理名の入力
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,

                  ),
                  child: TextFormField(
                    enabled: true,
                    onChanged: _dishnameText,
                    minLines: 1,
                    maxLines: 10,
                    decoration: const InputDecoration(
                        hintText: '料理名',
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black, width: 2))),
                    keyboardType: TextInputType.multiline,
                    style: const TextStyle(
                      fontSize: 28,
                    ),
                  ),
                ),Center(//評価バーの表示
                  child: Column(
                  children: <Widget>[
                  const SizedBox(
                    height: 40.0,
                  ),
                  _ratingBar(),
                  Text(
                    'Rating: ${_rating.toInt()}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Padding(//レビューの入力
                  padding: const EdgeInsets.symmetric(
                    vertical: 20,

                  ),
                  child: TextFormField(
                    enabled: true,
                    onChanged: _ReviewText,
                    minLines: 1,
                    maxLines: 10,
                    decoration: const InputDecoration(
                        hintText: '感想を記入しよう！',
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black, width: 2))),
                    keyboardType: TextInputType.multiline,
                    style: const TextStyle(
                      fontSize: 28,
                    ),
                  ),
                ),
                IconButton(onPressed: (){
                  setState(() {
                    bookmark==0?bookmark=1:bookmark=0;
                  });
                }, icon: bookmark==0?Icon(Icons.favorite_border):Icon(Icons.favorite)),
                ElevatedButton(//送信ボタン
                style: ElevatedButton.styleFrom(primary: Color(0xFFC51162 )),
                  onPressed: () {_post_request(widget.shop_id,_image,_dishname,_text,_rating.toInt(),bookmark);//postリクエストの呼び出し
                    Navigator.push( 
                      context,
                      MaterialPageRoute(builder: (context) => const MyStatefulWidget(),)//リクエスト後にホームに戻る
                    );
                  },
                  
                  child: const Text('reviewを投稿'),//ボタンの表示テキスト
                ),
                
              ],
            ),
          ),
        ],
      ),
    ),
    ]),
    ));
  }

  Widget _ratingBar() {
    return RatingBar.builder(
      initialRating: 0, //初期値
      minRating: 1,
      direction: Axis.horizontal, //縦か横か
      unratedColor: Colors.amber.withAlpha(50), //アイコンの色
      itemCount: 5, //段階数
      itemSize: 50.0, //アイコンの大きさ
      itemPadding: const EdgeInsets.symmetric(horizontal: 4.0), //アイテム同士の間隔
      itemBuilder: (context, _) => Icon(
        _selectedIcon ?? Icons.star,
        color: Colors.amber,
      ),
      onRatingUpdate: (rating) {
        setState(() {
          _rating = rating;
        });
      },
      updateOnDrag: true, //ドラッグによる操作可能か
    );
    }
  /*Future<void> _Post_review_Http(String shopId, String dishname, String content, int evaluate, String image) async {
  try {
    HttpURL reviews = HttpURL();
    await reviews.loadCredentials();
    var url = Uri.http(reviews.hostname, 'review');

    var request = Post_review(
      shop_id: shopId,
      dishname: dishname, 
      content: content,
      evaluate: evaluate, 
      image: image
      );
      print(request);

    final response = await http.post(
      url,
      body: json.encode(request.toJson()),
      headers: {'Authorization': 'Basic ${reviews.Authcode}',"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      final apiResults = ApiResults.fromJson(json.decode(response.body));
      // リクエスト成功時の処理
    } else {
      throw Exception('Failed to post review');
    }
  } catch (e) {
    print('Error posting review: $e');
    // エラーハンドリングの追加
  }
}*/
Future<void> _post_request(String shop_id, File? image, String dishname, String content, int evaluate,int bookmark) async {
  try {
    HttpURL httpURL = HttpURL();
    await httpURL.loadCredentials();

    FormData formData = FormData.fromMap({
      'shop_id': shop_id,
      'dishname': dishname,
      'content': content,
      'evaluate': evaluate,
      'bookmark': bookmark,
    });

    if (image != null && image.existsSync()) {
      formData.files.add(MapEntry('review_img', await MultipartFile.fromFile(
        image.path,
        filename: 'review_image.jpg',
      )));
    }

    var url = Uri.http(httpURL.hostname, 'review');
    print(url);

    final response = await Dio().post(
      url.toString(),
      data: formData,
      options: Options(
        headers: {'Authorization': 'Basic ${httpURL.Authcode}'},
      ),
    );

    print(response.statusCode);
    print(response.data);
  } catch (e) {
    print('Error posting review: $e');
  }
}







}