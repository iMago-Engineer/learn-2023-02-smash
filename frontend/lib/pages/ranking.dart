import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// class Data {
//   final double rank;
//   final String name;
//   final double amount;

//   const Data({
//     required this.rank,
//     required this.name,
//     required this.amount,
//   });

//   factory Data.fromJson(Map<String, dynamic> json) {
//     return Data(
//       rank: json['rank'],
//       name: json['name'],
//       amount: json['amount'],
//     );
//   }
// }

class Ranking extends StatefulWidget {
  @override
  _RankingState createState() => _RankingState();
}

class _RankingState extends State<Ranking> {
  var test = [];
  void initState() {
    Future<List<Data>> listItems = getRanking();
    print('2$listItems');
    print('test: $test');
  }

  Future<List<Data>> getRanking() async {
    final response =
        await http.get(Uri.parse('http://127.0.0.1:3000/battles/all'));

    if (response.statusCode == 200) {
      print(jsonDecode(response.body));
      test = jsonDecode(response.body) as List;
      return (jsonDecode(response.body) as List)
          .map((i) => Data.fromJson(i))
          .toList();
      // List<dynamic> result =
      //     jsonDecode(response.body).map((i) => Data.fromJson(i)).toList();
      // return result;
    } else {
      throw Exception('Failed to load ranking');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(32),
        child: Card(
            child: Row(
          children: [
            Flexible(
                child: ListView.builder(
              itemCount: listItems.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(listItems[index]["rank"].toString() + '位'),
                );
              },
            )),
            Flexible(
                child: ListView.builder(
              itemCount: listItems.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(listItems[index]["name"].toString()),
                );
              },
            )),
            Flexible(
                child: ListView.builder(
              itemCount: listItems.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(listItems[index]["amount"].toString() + '(ml)'),
                );
              },
            )),
          ],
        )),
      ),
    );
  }
}
