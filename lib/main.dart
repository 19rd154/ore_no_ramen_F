import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'src/app.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

// インスタンス
const storage = FlutterSecureStorage();

Future<void> main() async {
  final Object Username= storage.read(key: "username") ?? "";
  final Object Password = storage.read(key: "password") ?? "";
  runApp(MyApp(username: Username, password: Password));
  /*useEffect(
  () {
      Future(() async {
         // 初回起動かどうかの確認
         final isFirst = await (await SharedPreferences.getInstance()).getBool('is_first');
         if (isFirst == null || isFirst) {
           // flutter_secure_storageのデータを破棄
           final storage = FlutterSecureStorage();
           await storage.deleteAll();
           await (await SharedPreferences.getInstance()).setBool('is_first', false);
         }
       });
     },
     const [],
  );*/
 // ...

 
}

