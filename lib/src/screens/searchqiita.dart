import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart'; // httpという変数を通して、httpパッケージにアクセス
import 'models/Article.dart';
import 'article_container.dart';

 class SearchScreen extends StatefulWidget {
   const SearchScreen({super.key});

   @override
   State<SearchScreen> createState() => _SearchScreenState();
 }

 class _SearchScreenState extends State<SearchScreen> {
   List<Article> articles = []; // 検索結果を格納する変数

   @override
   Widget build(BuildContext context) {
     return Scaffold(
       appBar: AppBar(
         title: const Text('Qiita Search'),
       ),
        body: Column(
          children: [
          // 検索ボックス
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: 12,
                horizontal: 36,
              ),
              child: TextField(
                style: TextStyle( // ← TextStyleを渡す
                  fontSize: 18,
                  color: Colors.black,
                ),
                decoration: InputDecoration( // ← InputDecorationを渡す
                  hintText: '検索ワードを入力してください',
                ),
                onSubmitted: (String value) async {
                 final List<Article> results = []; // 検索処理を実行する
                 setState(() => articles = results); // 検索結果を代入
               },
               
              ), // ← TextFieldをchildren内に追加
          // 検索結果一覧
        ),
        Expanded(
            child: ListView(
              children: articles.map((article) => ArticleContainer(article: article)).toList(),
            ),
          ),],
        ),
     );
   }
 


 }