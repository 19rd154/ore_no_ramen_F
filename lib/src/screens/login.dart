import 'package:flutter/material.dart';
import 'package:world/src/app.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:world/src/screens/signup.dart';
// インスタンス
const storage = FlutterSecureStorage();
class LoginPage extends StatefulWidget {
  const LoginPage({Key? key,}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isObscure = true;
  String _username = '';
  String _password='';

  final Object username= storage.read(key: "email") ?? "";
  final Object password = storage.read(key: "password") ?? "";
  
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
        title: Text('俺のらぁめん'),
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
                  decoration: InputDecoration(
                      hintText: 'パスワードを入力',),
                ),
              ),
              Center(
                child: ElevatedButton(
                    onPressed: () async {
                    await storage.write(key: "username", value: _username);
                    await storage.write(key: "password", value: _password);
                    Navigator.push( 
                      context,
                      MaterialPageRoute(builder: (context) => MyStatefulWidget(),)
                    );
                  },
                    child: Text('ログイン')
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}