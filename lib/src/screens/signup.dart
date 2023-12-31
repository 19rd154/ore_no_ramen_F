import 'package:flutter/material.dart';
import 'package:world/src/app.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// インスタンス
const storage = FlutterSecureStorage();
class signupPage extends StatefulWidget {
  const signupPage({Key? key,}) : super(key: key);
  @override
  State<signupPage> createState() => _signupPageState();
}

class _signupPageState extends State<signupPage> {
  final bool _isObscure = true;
  String _username = '';
  String _password = '';
  String _errorText = ''; // Add this line

  
  
void _nameget(String Username) {
    setState(() {
      _username = Username;
    });
  }
  void _passget(String Password) {
    setState(() {
      _password = Password;
      print(_password);
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('俺のらぁめん'),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: TextFormField(
                  enabled: true,
                  onFieldSubmitted: _nameget,
                  maxLines: 1,
                  decoration: const InputDecoration(
                    hintText: 'ユーザ名を入力してください',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: TextFormField(
                  obscureText: _isObscure,
                  enabled: true,
                  onFieldSubmitted: _passget,
                  maxLines: 1,
                  decoration: const InputDecoration(
                      hintText: 'パスワードを入力',),
                ),
              ),
              Center(
        child: ElevatedButton(
          onPressed: () async {
            if (_username.isNotEmpty && _password.isNotEmpty) {
              _errorText = ''; // Clear any previous error
              await storage.write(key: "username", value: _username);
              await storage.write(key: "password", value: _password);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MyStatefulWidget()),
              );
            } else {
              setState(() {
                _errorText = 'ユーザ名とパスワードを入力してください';
              });
            }
          },
          child: const Text('サインアップ'),
        ),
      ),
            ],
          ),
        ),
      ),
    );
  }
}