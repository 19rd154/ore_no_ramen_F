import 'package:flutter/material.dart';
//import 'package:world/src/screens/models/reviews.dart';

import 'review_view.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false,
        title: const Text('俺のらぁめん'),
         
        ),
      body:SingleChildScrollView(//スクロールを可能に！
        child:
              Column(crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                    vertical: 20,
                    horizontal: 100,
                    ),
                    child: TextField(
                      style: TextStyle( // ← TextStyleを渡す.textのフォントや大きさの設定
                        fontSize: 18,
                        color: Colors.black,
                        ),
                    onSubmitted: (String value) {
                    print(value); // enterで実行する処理
                  },),
                  
                  ),
                  
                  SizedBox(width: 500,height:100),
                  for(int i = 0; i<90; i++)...{SizedBox(width: 10),
                  Row(
                    children: [
                      for(int j = 0; j<3; j++)...{
                        GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) =>Reviews(),)//ontapの確認用
                          );
                        },
                        child:TweetState(value: i.toString())
                        ),
                      SizedBox(width: 12),
                      }
                        //実際に呼び出す場合は繰り返し処理を挟む。
                    ],
                  ),
                  } ,
                  
                    
                  
                ],),
          ),
    
                  );// ここまでを追加);
  }
  
}

class TweetState extends StatelessWidget {
  final String value;
  const TweetState({Key? key, required this.value}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Padding(//columをpaddingでラップ
      padding: const EdgeInsets.all(8),
      child: Row(//columをRowでラップ
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ここにユーザーアイコンを追加する.backgroundImageで背景画像を決定.
          // https://flutter.takuchalle.dev/docs/widget/circleavatar/
          // AssetsImageでフォルダから画像の呼び出しを試したが動作不良.とりあえずNetworkImageから取ってくる方が良さげ
          SizedBox(width: 8), // 少し隙間を開ける
          Column(
            // start: 左
            // center: 中央
            // end: 右
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

                  Text('店名'),
                  SizedBox(width: 8),//隙間挿入
                  Text('YYYY/MM/DD'),


              SizedBox(height: 4),//隙間挿入
              Text('$value'),

                // ボタンを押したときに実行する内容を書けます。今回は何も実行しません。
              Icon(Icons.favorite), // Icon も Widget のひとつ。Icons. と打つと候補がたくさんでるので好きなアイコンに変更してみよう。

             ], 
          ),
        ],
      ),
    );
   
            
  }

  //getリクエストの記述部分
  /*Future<List<ReviewData>> _review_get_Http(String Visitflag,double lat,double lng) async {
    var url = Uri.http('127.0.0.1:8080', 'syunsuke//$Visitflag', {'lat': '$lat','lng': '$lng','rng':'4'});

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
    return _unvisitedDataList;}*/
}
