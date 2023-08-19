import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;


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
  String escape = ''; 
  final picker = ImagePicker();

    late double _rating;
  double _initialRating = 2.0;

  IconData? _selectedIcon;

  @override
  void initState() {
    super.initState();
    _rating = _initialRating;
  }


  Future<void> _getImage() async {
  try {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    } else {
      // 画像が選択されなかった場合の処理
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
  }
  void _dishnameText(String dishname) {
    setState(() {
      _dishname = dishname;
    });
  }
 void _shopnameText(String shopname) {
    setState(() {
      _shopname = shopname;
    });
  }
 void _saveText() {
    // テキストを変数に保存する処理
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('投稿'),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8.0),
            child: Column(
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
                    child: Text('画像を選択する'),
                  ),
                )
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 10,

                  ),
                  child: Text('${widget.shop_name}',style:TextStyle(
                      fontSize: 28,
                    ),
                  ),
                ),
                 Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 10,

                  ),
                  child: TextFormField(
                    enabled: true,
                    onChanged: _dishnameText,
                    minLines: 1,
                    maxLines: 10,
                    decoration: InputDecoration(
                        hintText: '料理名',
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black, width: 2))),
                    keyboardType: TextInputType.multiline,
                    style: TextStyle(
                      fontSize: 28,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 20,

                  ),
                  child: TextFormField(
                    enabled: true,
                    onChanged: _ReviewText,
                    minLines: 1,
                    maxLines: 10,
                    decoration: InputDecoration(
                        hintText: 'Review',
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black, width: 2))),
                    keyboardType: TextInputType.multiline,
                    style: TextStyle(
                      fontSize: 28,
                    ),
                  ),
                ),
                
                ElevatedButton(
                  onPressed: () {_Post_review_Http(widget.shop_id,
                  _dishname,
                  _text,
                  _rating.toInt(),
                  escape);
                  print("requested");},// 新しく追加したボタンのコールバック
                  child: Text('reviewを保存'),
                  

                ),
                Center(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 40.0,
                ),
                _ratingBar(),
                Text(
                  'Rating: $_rating',
                  style: TextStyle(fontWeight: FontWeight.bold),
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
      itemPadding: EdgeInsets.symmetric(horizontal: 4.0), //アイテム同士の間隔
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
  Future<void> _Post_review_Http(String _shop_id, String _dishname, String _content, int _evaluate, String _image) async {
  try {
    HttpURL _reviews = HttpURL(username: widget.username, password: widget.password);
    var url = Uri.http('${_reviews.hostname}', '${_shop_id}/review');

    var request = Post_review(
      dishname: _dishname, 
      content: _content,
      evaluate: _evaluate, 
      image: _image
      );

    final response = await http.post(
      url,
      body: json.encode(request.toJson()),
      headers: {'Authorization': 'Bearer ${_reviews.Authcode}',"Content-Type": "application/json"},
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
}
}

