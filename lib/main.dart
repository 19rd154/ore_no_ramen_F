import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'src/app.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// インスタンス
const storage = FlutterSecureStorage();


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  /*final keysToEliminate = [
  "username","password"
];
final prefs = await SharedPreferences.getInstance();

if (prefs.getBool('first_run') ?? true) {
   FlutterSecureStorage storage = FlutterSecureStorage();
   await Future.wait(keysToEliminate.map((key) => storage.delete(key: key)));

  prefs.setBool('first_run', false);
}*/
  final String Username= await storage.read(key: "username") ?? "";
  final String Password = await storage.read(key: "password") ?? "";
  print('ここだよ$Username');
  runApp(MyApp(username: Username, password: Password));
  
 
}

