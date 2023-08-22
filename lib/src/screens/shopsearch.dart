
import 'models/SearchData.dart';
import 'package:flutter/material.dart';
import 'package:world/src/screens/map_view.dart';

import 'models/Urlbase.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'article_container.dart';




class SearchScreen extends StatefulWidget {

  const SearchScreen({Key? key,required this.username,required this.password})
   : super(key: key);
  final String? username;
  final String? password;
  
   // createState()　で"State"（Stateを継承したクラス）を返す
  @override
  _Searchscreenstate createState() => _Searchscreenstate();
}

class _Searchscreenstate extends State<SearchScreen> {
  
  double Latitude = 35.6408;
  double Longitude = 139.7499;
  List<UnvisitedData> _unvisitedDataList = [];


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    HttpURL search = HttpURL();
    String nowplace = 'username';
    String Visitflag = 'unvisited';
    int flag=0;
    return Scaffold(
      
      appBar: AppBar(
        title: const Text('店舗検索'),
        automaticallyImplyLeading: false,
      ),
      body: 
      
          Column(crossAxisAlignment: CrossAxisAlignment.center,
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
                    hintText: nowplace,
                    prefixIcon: const Icon(Icons.search),
                    border: const OutlineInputBorder(),
                    /*suffixIcon: ElevatedButton(
                      onPressed: () {},
                      child: Text('現在地を取得'),
                    ),*/
                    suffix:TextButton(
                    onPressed: () async{final result = await _v_search_Http(Visitflag,Latitude,Longitude);
                    setState(() => _unvisitedDataList = result);print(Visitflag);},
                    child: const Text('検索'),
                  ),
                  ),
                  onSubmitted: (String value)async{
                  },
                
                ),
              ),
              Center(child: TextButton(
                onPressed: (){
                  flag==0? Visitflag = 'visited':Visitflag='unvisited'; 
                  print(Visitflag);
                  flag==0? flag=1:flag=0;
                },
                child: flag==0?const Text('訪れた店舗から検索する'):const Text('訪れていない店舗から検索する'),
               
              ),),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Latitude: $Latitude'),
                    Text('Longitude: $Longitude'),
                  ],
                ),
              ),
              Expanded(
            child: ListView(
              children: _unvisitedDataList
                  .map((UnvisitedData) => 
                  ArticleContainer(article: UnvisitedData,
                   Password:widget.password, 
                   Username: widget.username,
                  ))
                  .toList(),
            )
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
                    builder: (context) => const MapViewScreen(),
                    fullscreenDialog: true,
                  ),
                );
                // 戻ってきた際の処理
                if (result != null) {
                  setState(() {
                    Latitude = result.latitude;
                    Longitude = result.longitude;
                    print(Latitude);
                    print(Longitude);
                  });
                }
              },
            child: const Icon(Icons.add),
          ),
      );
    }
  
  Future<List<UnvisitedData>> _v_search_Http(String Visitflag,double lat,double lng) async {
    HttpURL search = HttpURL();
    await search.loadCredentials();
    var url = Uri.http(search.hostname, 'search/$Visitflag', {'lat': '$lat','lng': '$lng','rng':'4'},
    );
  print('${search.Authcode}');
    var response = await http.get(url, headers: {'Authorization': 'Basic ${search.Authcode}'},);
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

