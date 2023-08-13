import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:world/src/screens/map_view.dart';


class SearchScreen extends StatefulWidget {

  const SearchScreen({super.key});
  
   // createState()　で"State"（Stateを継承したクラス）を返す
  @override
  _Searchscreenstate createState() => _Searchscreenstate();
}

class _Searchscreenstate extends State<SearchScreen> {



  @override
  void initState() {
    super.initState();
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
                  style: TextStyle( // ← TextStyleを渡す.textのフォントや大きさの設定
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
      );
    }
}