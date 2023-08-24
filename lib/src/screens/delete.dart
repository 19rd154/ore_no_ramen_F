import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;


import '../app.dart';
import 'models/Post.dart';
import 'models/Urlbase.dart';
Future<void> delete_Http(String id) async {
    HttpURL search = HttpURL();
    await search.loadCredentials();
    var url = Uri.http(search.hostname, '/review/$id',);
    var response = await http.delete(url, headers: {'Authorization': 'Basic ${search.Authcode}'},);
    if (response.statusCode == 200) {
      
      print('Number of books about http: ${response.statusCode}.');
     // JSONデータをパースしてList<Map<String, dynamic>>に変換
      
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
    }
  