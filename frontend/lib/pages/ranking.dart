import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Data {
  final double winRate;
  final String name;
  final double amount;

  const Data({
    required this.winRate,
    required this.name,
    required this.amount,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      winRate: json['win_rate'],
      name: json['name'],
      amount: json['amount'],
    );
  }
}

class Ranking extends StatefulWidget {
  @override
  _RankingState createState() => _RankingState();
}

class _RankingState extends State<Ranking> {
  late Future<List<Data>> listItems;
  var test = [];
  void initState() {
    print("Ranking画面が表示されました。");
    super.initState();
    listItems = getRanking();
  }

  Future<List<Data>> getRanking() async {
    final response =
        await http.get(Uri.parse('http://127.0.0.1:3000/battles/all'));

    if (response.statusCode == 200) {
      print(response.body);
      return (jsonDecode(response.body) as List)
          .map((e) => Data.fromJson(e))
          .toList();
    } else {
      throw Exception('Failed to load ranking');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
            future: listItems,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<Data> battles = snapshot.data as List<Data>;
                battles.sort((a, b) => b.winRate.compareTo(a.winRate));
                return Container(
                    padding: EdgeInsets.all(32),
                    child: Column(children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("順位"),
                          SizedBox(width: 80, child: Text("勝率(%)")),
                          SizedBox(width: 80, child: Text("名前")),
                          Text("純アルコール"),
                        ],
                      ),
                      Flexible(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                              child: ListView.builder(
                            itemCount: battles.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Text((index + 1).toString()),
                              );
                            },
                          )),
                          SizedBox(
                              width: 80,
                              child: Flexible(
                                  child: ListView.builder(
                                      itemCount: battles.length,
                                      itemBuilder: (context, index) {
                                        return ListTile(
                                          title: Text(battles[index]
                                              .winRate
                                              .round()
                                              .toString()),
                                        );
                                      }))),
                          SizedBox(
                              width: 120,
                              child: Flexible(
                                  child: ListView.builder(
                                itemCount: battles.length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    title: Text(battles[index].name.toString()),
                                  );
                                },
                              ))),
                          SizedBox(
                            width: 80,
                            child: Flexible(
                                child: ListView.builder(
                              itemCount: battles.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  title: Text(battles[index]
                                      .amount
                                      .toStringAsFixed(2)
                                      .toString()),
                                );
                              },
                            )),
                          )
                        ],
                      )),
                    ]));
              } else {
                return Text("戦績がありません");
              }
              ;
            }));
  }
}
