import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Create extends StatefulWidget {
  @override
  _CreateRecord createState() => _CreateRecord();
}

class _CreateRecord extends State<Create> {
  var selectedUser1Value = "まつお";
  var selectedUser2Value = "けんた";
  var selectedUser3Value = "かぜ";
  final user_list = <String>["まつお", "けんた", "かぜ"];
  var selectedSake1Value = "日本酒";
  var selectedSake2Value = "ビール";
  var selectedSake3Value = "焼酎";
  final sake_list = <String>["日本酒", "ビール", "焼酎"];
  var amount1, amount2, amount3;
  var rank1, rank2, rank3;
  var ratio1, ratio2, ratio3;
  var newUser, newSake;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(32),
        child: SingleChildScrollView(
            child: Column(children: [
          Card(
            elevation: 8,
            child: Form(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelText: '名前',
                    ),
                    value: selectedUser1Value,
                    items: user_list
                        .map((String list) =>
                            DropdownMenuItem(value: list, child: Text(list)))
                        .toList(),
                    onChanged: (String? value) {
                      setState(() {
                        selectedUser1Value = value!;
                      });
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: '順位'),
                    onChanged: (value) => rank1 = value,
                  ),
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelText: 'お酒',
                    ),
                    value: selectedSake1Value,
                    items: sake_list
                        .map((String list) =>
                            DropdownMenuItem(value: list, child: Text(list)))
                        .toList(),
                    onChanged: (String? value) {
                      setState(() {
                        selectedSake1Value = value!;
                      });
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'お酒の量'),
                    onChanged: (value) => amount1 = value,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'お酒の度数'),
                    onChanged: (value) => ratio1 = value,
                  ),
                ],
              ),
            ),
          ),
          Card(
            elevation: 8,
            child: Form(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelText: '名前',
                    ),
                    value: selectedUser2Value,
                    items: user_list
                        .map((String list) =>
                            DropdownMenuItem(value: list, child: Text(list)))
                        .toList(),
                    onChanged: (String? value) {
                      setState(() {
                        selectedUser2Value = value!;
                      });
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: '順位'),
                    onChanged: (value) => rank2 = value,
                  ),
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelText: 'お酒',
                    ),
                    value: selectedSake2Value,
                    items: sake_list
                        .map((String list) =>
                            DropdownMenuItem(value: list, child: Text(list)))
                        .toList(),
                    onChanged: (String? value) {
                      setState(() {
                        selectedSake2Value = value!;
                      });
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'お酒の量'),
                    onChanged: (value) => amount2 = value,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'お酒の度数'),
                    onChanged: (value) => ratio2 = value,
                  ),
                ],
              ),
            ),
          ),
          Card(
            elevation: 8,
            child: Form(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelText: '名前',
                    ),
                    value: selectedUser3Value,
                    items: user_list
                        .map((String list) =>
                            DropdownMenuItem(value: list, child: Text(list)))
                        .toList(),
                    onChanged: (String? value) {
                      setState(() {
                        selectedUser3Value = value!;
                      });
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: '順位'),
                    onChanged: (value) => rank3 = value,
                  ),
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelText: 'お酒',
                    ),
                    value: selectedSake3Value,
                    items: sake_list
                        .map((String list) =>
                            DropdownMenuItem(value: list, child: Text(list)))
                        .toList(),
                    onChanged: (String? value) {
                      setState(() {
                        selectedSake3Value = value!;
                      });
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'お酒の量'),
                    onChanged: (value) => amount3 = value,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'お酒の度数'),
                    onChanged: (value) => ratio3 = value,
                  ),
                ],
              ),
            ),
          ),
          ElevatedButton(
            child: const Text('記録する'),
            onPressed: () {
              final params = [];
              if (rank1 != null) {
                params.add({
                  "name": selectedUser1Value,
                  "rank": int.parse(rank1),
                  "sake": selectedSake1Value,
                  "amount": amount1 == null ? 0 : int.parse(amount1),
                  "ratio": ratio1 == null ? null : int.parse(ratio1)
                });
              }
              if (rank2 != null) {
                params.add({
                  "name": selectedUser2Value,
                  "rank": int.parse(rank2),
                  "sake": selectedSake2Value,
                  "amount": amount2 == null ? 0 : int.parse(amount2),
                  "ratio": ratio2 == null ? null : int.parse(ratio2)
                });
              }
              if (rank3 != null) {
                params.add({
                  "name": selectedUser3Value,
                  "rank": int.parse(rank3),
                  "sake": selectedSake3Value,
                  "amount": amount3 == null ? 0 : int.parse(amount3),
                  "ratio": ratio3 == null ? null : int.parse(ratio3)
                });
              }
              if (!params.isEmpty) {
                final response =
                    http.post(Uri.parse('http://127.0.0.1:3000/battle'),
                        headers: <String, String>{
                          'Content-Type': 'application/json; charset=UTF-8',
                        },
                        body: jsonEncode(params));
              }
            },
          ),
        ])),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (_) => SimpleDialog(
                    title: Text('何を追加する？'),
                    children: [
                      SimpleDialogOption(
                        child: Text('ユーザー'),
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  content: TextFormField(
                                    decoration:
                                        InputDecoration(labelText: "ユーザーの名前"),
                                    onChanged: (value) => newUser = value,
                                  ),
                                  actions: [
                                    TextButton(
                                      child: Text('追加'),
                                      onPressed: () {
                                        Navigator.pop(context);
                                        setState(() {
                                          user_list.add(newUser);
                                        });
                                      },
                                    ),
                                  ],
                                );
                              });
                        },
                      ),
                      SimpleDialogOption(
                        child: Text('お酒'),
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  content: TextFormField(
                                    decoration:
                                        InputDecoration(labelText: "お酒の名前"),
                                    onChanged: (value) => newSake = value,
                                  ),
                                  actions: [
                                    TextButton(
                                      child: Text('追加'),
                                      onPressed: () {
                                        Navigator.pop(context);
                                        setState(() {
                                          sake_list.add(newSake);
                                        });
                                      },
                                    ),
                                  ],
                                );
                              });
                        },
                      )
                    ],
                  ));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
