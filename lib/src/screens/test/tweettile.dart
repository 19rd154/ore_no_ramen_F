import 'package:flutter/material.dart';
void main() {
 runApp(
   // const Center(
   //   child: Text(
   //     'Hello, world!',
   //     textDirection: TextDirection.ltr,
   //   ),
   // ),
   MyApp(), // 先ほど作った MyApp() を表示したいので runApp() の中に書きます。
 );
}

class MyApp extends StatelessWidget {
 const MyApp({Key? key}) : super(key: key);

 @override
 Widget build(BuildContext context) {
   return MaterialApp(
     home: Scaffold(
       appBar: AppBar(
         title: const Text(
           'こんぶ @ Flutter大学',
           style: TextStyle(
             fontWeight: FontWeight.bold,
             fontSize: 16,
           ),
         ),
       ),
       body: Column(
         children: [
           TweetState(),
           TweetState(),
         ],
       ),
     ),
   );
 }
}
//new class TweetTile!
class TweetState extends StatelessWidget {
  const TweetState({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(//columをpaddingでラップ
      padding: const EdgeInsets.all(8),
      child: Row(//columをRowでラップ
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ここにユーザーアイコンを追加する.
          CircleAvatar(backgroundImage : NetworkImage(''),),
          SizedBox(width: 8), // 少し隙間を開ける
          Column(
            // start: 左
            // center: 中央
            // end: 右
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(//Rowをcollumでラップ。
                // children プロパティに Text のリストを与えます。
                children: [
                  Text('こんぶ @ Flutter大学'),
                  SizedBox(width: 8),//隙間挿入
                  Text('2022/05/05'),
                ],
              ),
              SizedBox(height: 4),//隙間挿入
              Text('あぁもう最高や！'),
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