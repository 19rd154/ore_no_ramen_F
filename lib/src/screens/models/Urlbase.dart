
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class HttpURL {
  final storage = FlutterSecureStorage();
  late String username;
  late String password;

  Future<void> loadCredentials() async {
    username = await storage.read(key: "username") ?? '';
    password = await storage.read(key: "password") ?? '';
  }

  String needEncode() {
    return '$username:$password';
  }

  String get Authcode {
    print(needEncode());
    return base64.encode(utf8.encode(needEncode()));
  }

  String hostname = '44.218.199.137:8080';
}

