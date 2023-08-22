import 'package:flutter/material.dart';

import 'models/Reviews.dart';

class Reviewsshow extends StatelessWidget {
  final ReviewData reviewdata;
  const Reviewsshow({super.key, required this.reviewdata,
 });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('レビュー'),

      ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // children プロパティに Text のリストを与えます。
          Row(
            children: [
              const Column(
                children: [
                  Text('店舗名',style: TextStyle(fontSize: 28),),
                  Text('YYYY/MM/DD',style: TextStyle(fontSize:28),),
                  Text('料理名',style: TextStyle(fontSize:28),),
                  ],
              ),
             const Expanded(child: SizedBox()),
             Image.network('https://yakiimosan.com/wp-content/uploads/2022/07/yakiimo_pc-150x150.png'),
             ],
          ),






          const SingleChildScrollView(//スクロールを可能に！
            child:Expanded(child:Center(child: Text('context',style: TextStyle(fontSize: 25),),),),
          ),
          IconButton(
            onPressed: () {}, // ボタンを押したときに実行する内容を書けます。今回は何も実行しません。
            icon: const Icon(Icons.favorite_border), // Icon も Widget のひとつ。Icons. と打つと候補がたくさんでるので好きなアイコンに変更してみよう。
              ),
        ],
      ),
              
    );
  }
}