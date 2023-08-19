import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:world/src/screens/signup.dart';

import 'screens/account.dart';
import 'screens/shopsearch.dart';
import 'screens/home.dart';
import 'screens/notification.dart';


const storage = FlutterSecureStorage();

class MyApp extends StatefulWidget {
  const MyApp({Key? key,required this.username,required this.password})
   : super(key: key);
  final String? username;
  final String? password;

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp>{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: widget.username==""? signupPage():MyStatefulWidget()
    );
  }
  
  
}

class MyStatefulWidget extends StatefulWidget {
    const MyStatefulWidget({Key? key,});


  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  String? username;
  String? password;
  final List<Widget> _screens = [];

  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _loadCredentials();
    _screens.addAll([
      HomeScreen(username: username, password: password),
      SearchScreen(username: username, password: password),
      NotificationScreen(),
      NotificationScreen(),
      AccountScreen(),
    ]);
  }
    Future<void> _loadCredentials() async {
    username = await storage.read(key: "username") ?? "";
    password = await storage.read(key: "password") ?? "";
    setState(() {});
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _screens[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'ホーム'),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: '検索'),
            BottomNavigationBarItem(
                icon: Icon(Icons.notifications), label: 'お知らせ'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'アカウント'),
          ],
          type: BottomNavigationBarType.fixed,
        ));
  }
}


