import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:dio/dio.dart';

import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:world/src/screens/models/Reviews.dart';


import '../app.dart';
import 'models/Post.dart';
import 'models/Urlbase.dart';
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


class ReviewUpdate extends StatefulWidget {
  const ReviewUpdate({Key? key,
  required this.shop_id, required this.review_id,}) ;
  final String shop_id;
  final String review_id;
  @override
  _ReviewUpdateState createState() => _ReviewUpdateState();
}

class _ReviewUpdateState extends State<ReviewUpdate> {
  String _text = '';
  String _dishname='';
  String _shopname = '';
  File? _image;
  String escape = '0'; 
 final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _rating = _initialRating;
  }

    late double _rating;
  final double _initialRating = 2.0;

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
      ),
      body: Column(
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
                      ? const Text('画像が選択されていません')
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
                  child: Text(widget.shop_id,style:const TextStyle(
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
                    'Rating: $_rating',
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
                        hintText: 'Review',
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black, width: 2))),
                    keyboardType: TextInputType.multiline,
                    style: const TextStyle(
                      fontSize: 28,
                    ),
                  ),
                ),
                
                ElevatedButton(//送信ボタン
                  onPressed: () {_update_request(widget.review_id,
                  widget.shop_id,
                  _image,_dishname,_text,_rating.toInt());//postリクエストの呼び出し
                    Navigator.push( 
                      context,
                      MaterialPageRoute(builder: (context) => const MyStatefulWidget(),)//リクエスト後にホームに戻る
                    );
                  },

                  child: const Text('reviewを保存'),//ボタンの表示テキスト
                ),
                
              ],
            ),
          ),
        ],
      ),
    ),
    ]),
    );
  }

  Widget _ratingBar() {
    return RatingBar.builder(
      initialRating: _initialRating, //初期値
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
Future<void> _update_request(String reviewid,String shop_id, File? image, String dishname, String content, int evaluate) async {
  try {
    HttpURL httpURL = HttpURL();
    await httpURL.loadCredentials();

    FormData formData = FormData.fromMap({
      'shop_id': shop_id,
      'dishname': dishname,
      'content': content,
      'evaluate': evaluate,
      'bookmark': 1,
    });

    if (image != null && image.existsSync()) {
      formData.files.add(MapEntry('review_img', await MultipartFile.fromFile(
        image.path,
        filename: 'review_image.jpg',
      )));
    }

    var url = Uri.http(httpURL.hostname, 'review/$reviewid');
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