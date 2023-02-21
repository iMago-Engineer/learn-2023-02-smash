import 'package:flutter/material.dart';
import './pages/create.dart';
import './pages/ranking.dart';

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

  static List<Widget> _pageList = [Create(), Ranking()];

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
