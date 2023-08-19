import 'dart:convert';

class HttpURL {
  String? username;
  String? password;

  HttpURL({required this.username, required this.password});

  String needEncode() {
    return '$username:$password';
  }

  String get Authcode {
    return base64.encode(utf8.encode(needEncode()));
  }

  String hostname = '44.218.199.137:8080';
}

