



import 'package:flutter/material.dart';

import 'models/Reviews.dart';


import 'models/Urlbase.dart';
import 'package:world/src/screens/review_allview.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, required this.username, required this.password})
      : super(key: key);
  final String? username;
  final String? password;

  @override
  _Homescreenstate createState() => _Homescreenstate();
}

class _Homescreenstate extends State<HomeScreen> {
  List<ReviewData> _reviewDataList = [];
  int status=200;
  int flag=1;
  String _text1='';
  String _text2='';
 void _searchText1(String ReviewText) {
    setState(() {
      _text1 = ReviewText;
    });
    print(_text1);
  }
  void _searchText2(String ReviewText) {
    setState(() {
      _text2 = ReviewText;
    });
    print(_text2);
  }
  @override
  void initState() {
    super.initState();
  }
  String hint1='検索ボタンをタッチ';
  String hint2='検索ボタンをタッチ';
  String? isSelectedValue = '/review';
  @override
  Widget build(BuildContext context) {
    
    
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('俺のらぁめん'),
        backgroundColor: Colors.black,
      ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //検索ボックスの上下左右の空白の幅
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 20,
                    ),
                    //検索ボックス
                    child: flag%2==0? TextField(
                      style: const TextStyle( // ← TextStyleを渡す.textのフォントや大きさの設定
                              fontSize: 18,
                              color: Colors.black,
                             ),
                      onChanged: _searchText1,
                      decoration: InputDecoration(//デコレーション
                        hintText: '$hint1',
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(),
                      ),
                  
            
            ):SizedBox(height: 0,),
        ),
                ],
              ),Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 20,
                ),
                //検索ボックス
                child: flag%3==0? TextField(
                  style: const TextStyle( // ← TextStyleを渡す.textのフォントや大きさの設定
                          fontSize: 18,
                          color: Colors.black,
                         ),
                  onChanged: _searchText2,
                  decoration: InputDecoration(//デコレーション
                    hintText: '$hint2',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(),
                  ),
              
            
            ):SizedBox(height: 0),
        ),Container(
          width: 150,
          height: 40,
          child:TextButton(
                    onPressed: () async{final result = await _Home_get_Http(isSelectedValue!,_text1,_text2);
                    setState(() => _reviewDataList = result);},
                    style: TextButton.styleFrom(
              // 最小のサイズを設定
              backgroundColor: Color(0xFFC51162 ), // 背景色を設定
              primary: Colors.white, // テキストの色を設定
            ),
                    child: Text('一覧の表示',style: const TextStyle( // ← TextStyleを渡す.textのフォントや大きさの設定
                              fontSize: 18,
                              
                             ),),
        )),
        Center(
          child:DropdownButton(
      items: const[
        DropdownMenuItem(
            value: '/review',
            child: Text('更新順から検索'),
          ),
          DropdownMenuItem(
              value: '/review/bookmark',
              child: Text('お気に入りから検索'),
          ),
          DropdownMenuItem(
              value: '/review/evaluate',
              child: Text('評価順から検索'),
          ),
          DropdownMenuItem(
              value: '/review/period',
              child: Text('更新日から検索'),
          ),
          DropdownMenuItem(
              value: '/shop',
              child: Text('店舗から検索'),
          ),
      ],
      value: isSelectedValue,
      onChanged: (String? value) {
        setState(() {
          isSelectedValue = value!;
          if (isSelectedValue == '/review/evaluate') {
        hint1 = 'いくつ以上？';
        hint2 = 'いくつ以下？';
        flag=6;
      } else if (isSelectedValue == '/review/period') {
        hint1 = 'YYYY-MM-DDから';
        hint2 = 'YYYY-MM-DDまで';
        flag=6;
      
      } else {
        // 他の場合の処理
        hint1 = '検索ボタンをタッチ';
        flag=1;
      }
        });
      },
    ),
    
        ),
        Expanded(
            child: status != 200
      ? Center(
          child: Text('レビューを書きにいこう！',style: TextStyle(fontSize: 20),),
        )
      : ListView(
          children: _reviewDataList
              .map((review) => ArticleContainer_review(reviewData: review))
              .toList(),
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
        ),
                  
            )
            ]),
        );
      
  }

  /*Future<void> _loadReviewData() async {
    final result = await _Home_get_Http();
    setState(() => _reviewDataList = result);
  }*/

  Future<List<ReviewData>> _Home_get_Http(String value,String? _option1,String? _option2) async {
    HttpURL _search = HttpURL();
    await _search.loadCredentials();
    var url; 
    if (value == '/review/evaluate') {
        url = Uri.http('${_search.hostname}', 'home${value}',{'lower':'$_option1','upper':'$_option2'},);
      } else if (value == '/review/period') {
        url = Uri.http('${_search.hostname}', 'home${value}',{'lower':'$_option1','upper':'$_option2'},);
      } else if (value == '/shop') {
        url = Uri.http('${_search.hostname}', 'home${value}',{'offset':'3'},);
      } else if (value == '/review/bookmark') {
        url = Uri.http('${_search.hostname}', 'home${value}',{'offset':'3'},);
      }else {
        // 他の場合の処理
      url = Uri.http('${_search.hostname}', 'home${value}',{'offset':'3'},);
      }
    

    var response = await http.get(
      url,
      headers: {'Authorization': 'Basic ${_search.Authcode}'},
    );
    if (response.statusCode == 200) {
      String responseBody = utf8.decode(response.bodyBytes);
      print('Number of books about http: $responseBody.');
      List<dynamic> responseData = jsonDecode(responseBody);
      List<ReviewData> reviewdDataList = [];
      for (var itemData in responseData) {
        ReviewData reviewData = ReviewData(
          shopid: itemData['shop_id'],
          reviewid: itemData['review_id'].toString(),
          shopname: itemData['shopname'],
          dishname: itemData['dishname']?? '',
          evaluate: itemData['evaluate'],
          content: itemData['content'],
          created_at: itemData['created_at'],
          image: itemData['review_img'],
          bookmark: itemData['bookmark']
        );
        reviewdDataList.add(reviewData);
      }
      setState(() {
        status=response.statusCode;
        print(status);
      });
      
      
      return reviewdDataList;
    } else {
      print('Request failed with status: ${response.statusCode}.');status=response.statusCode;
      return [];
    }
  }
}



