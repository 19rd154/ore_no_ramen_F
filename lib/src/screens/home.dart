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

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('俺のらぁめん'),
      ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //検索ボックスの上下左右の空白の幅
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 20,
                ),
                //検索ボックス
                child: TextField(
                  style: const TextStyle( // ← TextStyleを渡す.textのフォントや大きさの設定
                          fontSize: 18,
                          color: Colors.black,
                         ),
                  decoration: InputDecoration(//デコレーション
                    hintText: '店舗名',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(),
                    /*suffixIcon: ElevatedButton(
                      onPressed: () {},
                      child: Text('現在地を取得'),
                    ),*/
                    suffix:TextButton(
                    onPressed: () async{final result = await _Home_get_Http();
                    setState(() => _reviewDataList = result);},
                    child: Text('検索'),
                  ),
              
            
            ),
        ),
        ),
        Expanded(
            child: ListView(
  children: _reviewDataList
      .map((review) => 
          ArticleContainer_review(reviewData: review),
      ).toList(),
)
                  
            )
            ]),
        );
      
  }

  /*Future<void> _loadReviewData() async {
    final result = await _Home_get_Http();
    setState(() => _reviewDataList = result);
  }*/

  Future<List<ReviewData>> _Home_get_Http() async {
    HttpURL _search =
        HttpURL();
    var url = Uri.http('${_search.hostname}', 'home',);

    var response = await http.get(
      url,
      headers: {'Authorization': 'Basic c3l1bnN1a2U6aG9nZQ=='},
    );
    if (response.statusCode == 200) {
      String responseBody = utf8.decode(response.bodyBytes);
      print('Number of books about http: $responseBody.');
      List<dynamic> responseData = jsonDecode(responseBody);
      List<ReviewData> reviewdDataList = [];
      for (var itemData in responseData) {
        ReviewData reviewData = ReviewData(
          shopname: itemData['shopname'],
          dishname: itemData['dishname'],
          evaluate: itemData['evaluate'],
          content: itemData['content'],
          created_at: itemData['created_at'],
        );
        reviewdDataList.add(reviewData);
      }
      return reviewdDataList;
    } else {
      print('Request failed with status: ${response.statusCode}.');
      return [];
    }
  }
}



