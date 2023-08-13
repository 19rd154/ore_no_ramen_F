
import 'apisample.dart';
import 'package:flutter/material.dart';
import 'package:world/src/screens/map_view.dart';
<<<<<<< HEAD
=======
import 'apisample.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'article_container.dart';
>>>>>>> efe55270c31ffa509706eda924b465c34167f427


class SearchScreen extends StatefulWidget {

  const SearchScreen({super.key});
  
   // createState()　で"State"（Stateを継承したクラス）を返す
  @override
  _Searchscreenstate createState() => _Searchscreenstate();
}

class _Searchscreenstate extends State<SearchScreen> {
<<<<<<< HEAD

=======
  double Latitude = 0.0;
  double Longitude = 0.0;
  List<UnvisitedData> _unvisitedDataList = [];
>>>>>>> efe55270c31ffa509706eda924b465c34167f427


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String nowplace = 'username';
    String searching='unnti';
    return Scaffold(
      
      appBar: AppBar(
        title: const Text('投稿検索'),
        automaticallyImplyLeading: false,
      ),
      body: 
      
          Column(crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //検索ボックスの上下左右の空白の幅
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 20,
                  horizontal: 100,
                ),
                //検索ボックス
                child: TextField(
                  style: const TextStyle( // ← TextStyleを渡す.textのフォントや大きさの設定
                          fontSize: 18,
                          color: Colors.black,
                         ),
                  decoration: InputDecoration(//デコレーション
                    hintText: '$nowplace',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(),
                    /*suffixIcon: ElevatedButton(
                      onPressed: () {},
                      child: Text('現在地を取得'),
                    ),*/
                    suffix:TextButton(
                    onPressed: () async{final result = await _handleHttp(Latitude,Longitude);
                    setState(() => _unvisitedDataList = result);},
                    child: Text('検索'),
                  ),
                  ),
                  onSubmitted: (String value)async{
                  },
                
                ),
              ),
              OutlinedButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.white,
                ),
                onPressed: () {
                  Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  MapViewScreen())
                  );
                  /* ボタンがタップされた時の処理 */ },
                child: Text('click here'),
<<<<<<< HEAD
              ),
=======
              ),Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Latitude: $Latitude'),
                    Text('Longitude: $Longitude'),
                  ],
                ),
              ),Expanded(
            child: ListView(
              children: _unvisitedDataList
                  .map((UnvisitedData) => ArticleContainer(article: UnvisitedData))
                  .toList(),
            )
            ),
>>>>>>> efe55270c31ffa509706eda924b465c34167f427
              /*Padding(
                 padding: const EdgeInsets.symmetric(
                  vertical: 0,
                  horizontal: 100,
                ),
                child: ElevatedButton.icon(
                  icon:Icon(Icons.favorite_border),
                  label: Text('ブックマークの表示'),
                  onPressed: (){},
                  ),
              ),*/
              //ArticleContainer(article: searching,)
            ],
          ),floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
            floatingActionButton: FloatingActionButton( // ここから
              onPressed: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MapViewScreen(),
                    fullscreenDialog: true,
                  ),
                );
                // 戻ってきた際の処理
                if (result != null) {
                  // result を使って何か処理を行う
                  print("戻ってきた値: $result");
                }
              },
            child: const Icon(Icons.add),
          ),
<<<<<<< HEAD
      );
    }
}
=======
    );
  }
  
  Future<List<UnvisitedData>> _handleHttp(double lat,double lng) async {
    var url = Uri.http('127.0.0.1:8080', 'syunsuke/search/unvisited', {'lat': '$lat','lng': '$lng','rng':'4'});

    var response = await http.get(url);
    if (response.statusCode == 200) {
      String responseBody = utf8.decode(response.bodyBytes);
      print('Number of books about http: $responseBody.');
     // JSONデータをパースしてList<Map<String, dynamic>>に変換
      List<dynamic> responseData = jsonDecode(responseBody);
      List<UnvisitedData> unvisitedDataList = [];
      for (var itemData in responseData) {
        // JSONデータから必要な要素を選んでオブジェクトに加工
        UnvisitedData unvisitedData = UnvisitedData(
          reviews: itemData['reviews'] ?? '',
          access: itemData['access'],
          address: itemData['address'],
          id: itemData['id'],
          name: itemData['name'],
        );
        unvisitedDataList.add(unvisitedData);
      }
      setState(() {
        _unvisitedDataList = unvisitedDataList;
      });
      
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
    return _unvisitedDataList;}
  }
>>>>>>> efe55270c31ffa509706eda924b465c34167f427
