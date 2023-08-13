

import 'package:flutter/material.dart';
import 'package:world/src/screens/map_view.dart';


class SearchScreen extends StatefulWidget {
  final double latitude;
  final double longitude;
  //　変数定義すると、UIのところから"widget.変数名" で呼ぶことができる。
  const SearchScreen({required this.latitude, required this.longitude});

  //const SearchScreen({super.key});
  
   // createState()　で"State"（Stateを継承したクラス）を返す
  @override
  _Searchscreenstate createState() => _Searchscreenstate();
}

class _Searchscreenstate extends State<SearchScreen> {
  double Latitude = 0.0;
  double Longitude = 0.0;


  @override
  void initState() {
    super.initState();
    // ページ遷移時に受け取った値を変数に設定
    Latitude = widget.latitude;
    Longitude = widget.longitude;
  }

  @override
  Widget build(BuildContext context) {
    String nowplace = '検索したい';
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
                  ),
                  onSubmitted: (String value) {
                    
                    print(searching.replaceAll(searching, value));
                    // enterで実行する処理
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
              ),Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Latitude: $Latitude'),
                    Text('Longitude: $Longitude'),
                  ],
                ),
              ),
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
          ),
    );
  }
}