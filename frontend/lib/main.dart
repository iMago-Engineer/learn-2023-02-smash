import 'package:flutter/material.dart';
import './pages/create.dart';
import './pages/ranking.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'スマブラ戦績アプリ',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _screen = 0;

  @override
  void initState() {
    print("MyHomePage画面が表示されました。");

    super.initState();
  }

  static List<Widget> _pageList = [
    Create(),
  ];
  void _callAPI() async {
    final url = Uri.parse('http://127.0.0.1:3000/battles/all');
    var response = await http.get(url);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
  }

  // ページ下部に並べるナビゲーションメニューの一覧
  List<BottomNavigationBarItem> myBottomNavBarItems() {
    return [
      BottomNavigationBarItem(
        icon: Icon(Icons.edit_note),
        label: '記録する',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.leaderboard),
        label: 'ランキング',
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'スマブラ戦績アプリ',
          style: TextStyle(fontSize: 16),
        ),
      ),
      body: _pageList[_screen],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _screen,
        onTap: (index) {
          setState(() {
            _screen = index;
          });
        },
        items: myBottomNavBarItems(),
      ),
    );
  }
}
