import 'package:flutter/material.dart';

class Ranking extends StatelessWidget {
  final listItems = [
    {
      "name": "まつお",
      "rank": 1,
      "amount": 3,
    },
    {
      "name": "けんた",
      "rank": 2,
      "amount": 6,
    },
    {
      "name": "かぜ",
      "rank": 3,
      "amount": 22,
    }
  ];

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
