import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'src/app.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
Future<void> main() async {
  runApp(const MyApp());
  useEffect(
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
  );
 // ...

 
}

