import 'package:flutter/material.dart';
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
                  }],
              ),
          ),
    );
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
              IconButton(
                onPressed: () {}, // ボタンを押したときに実行する内容を書けます。今回は何も実行しません。
                icon: Icon(Icons.favorite_border), // Icon も Widget のひとつ。Icons. と打つと候補がたくさんでるので好きなアイコンに変更してみよう。
              ),
            ],
          ),
        ],
      ),
    );
  }
}
