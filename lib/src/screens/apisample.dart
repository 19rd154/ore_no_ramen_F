import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UnvisitedData {
  final String reviews;
  final String access;
  final String address;
  final String id;
  final String name;

  UnvisitedData({
    required this.reviews,
    required this.access,
    required this.address,
    required this.id,
    required this.name,
  });
}

/*void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Apitest(title: 'Flutter Demo Home Page'),
    );
  }
}*/

class Apitest extends StatefulWidget {
  const Apitest({super.key, required this.username});


  final String username;

  @override
  State<Apitest> createState() => _ApiState();
}

class _ApiState extends State<Apitest> {
  List<UnvisitedData> _unvisitedDataList = [];



  Future<void> _handleHttp() async {
    String username = 'syunsuke';
    var url = Uri.http('127.0.0.1:8080', '$username/search/unvisited', {'lat': '35.6408','lng': '139.7499','rng':'4'});

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
  }
  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }

  /*@override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '中身',
            ),
            Column(
              children: _unvisitedDataList.map((data) {
                return Column(
                  children: [
                    Text('Reviews: ${data.reviews}'),
                    Text('ID: ${data.id}'),
                    Text('Name: ${data.name}'),
                    Text('Access: ${data.access}'),
                    Text('Address: ${data.address}'),
                    Divider(),
                  ],
                );
              }).toList(),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _handleHttp,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }*/
}