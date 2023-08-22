import 'package:flutter/material.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('アカウント'),
        automaticallyImplyLeading: false,
      ),
      body: SizedBox(
        height: double.infinity,
        child: Center(
          child: ElevatedButton(
            child: const Text('ログアウト'),
            onPressed: (){
              // ログイン画面に戻る。
              Navigator.pop(context);
            },
          ),
        ),
      )
    );
  }
}