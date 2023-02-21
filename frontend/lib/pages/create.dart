import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Create extends StatefulWidget {
  @override
  _CreateRecord createState() => _CreateRecord();
}

Future<List<Name>> fetchName() async {
  final response = await http.get(Uri.parse('http://127.0.0.1:3000/users'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return (jsonDecode(response.body) as List)
        .map((e) => Name.fromJson(e))
        .toList();
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

class Name {
  final String name;

  const Name({
    required this.name,
  });

  factory Name.fromJson(Map<String, dynamic> json) {
    return Name(
      name: json['name'],
    );
  }
}

Future<List<Sake>> fetchSake() async {
  final response = await http.get(Uri.parse('http://127.0.0.1:3000/sakes'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    //
    return (jsonDecode(response.body) as List)
        .map((e) => Sake.fromJson(e))
        .toList();
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

class Sake {
  final int id;
  final String name;
  final int ratio;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Sake({
    required this.id,
    required this.name,
    required this.ratio,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Sake.fromJson(Map<String, dynamic> json) {
    return Sake(
      id: json['id'],
      name: json['name'],
      ratio: json['ratio'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}

class _CreateRecord extends State<Create> {
  late Future<List<Sake>> futureSake;
  List<String> sakeList = [];
  List<String> addedSakeList = [];

  late Future<List<Name>> futureName;
  List<String> nameList = [];
  List<String> addedNameList = [];

  @override
  void initState() {
    print("CreateRecord画面が表示されました。");

    super.initState();
    futureName = fetchName();
    futureSake = fetchSake();
  }

  var dropdownValue1;
  var dropdownValue2;
  var dropdownValue3;

  var selectedUser1Value;
  var selectedUser2Value;
  var selectedUser3Value;

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
              child: FutureBuilder<List<Sake>>(
                  future: futureSake,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<Sake> sakes = snapshot.data as List<Sake>;
                      sakeList =
                          addedSakeList + sakes.map((e) => e.name).toList();
                      print(sakeList);
                      return FutureBuilder<List<Name>>(
                          future: futureName,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              List<Name> names = snapshot.data as List<Name>;
                              nameList = addedNameList +
                                  names.map((e) => e.name).toList();
                              print(nameList);
                              return Column(children: [
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
                                          items: nameList
                                              .map((String list) =>
                                                  DropdownMenuItem(
                                                      value: list,
                                                      child: Text(list)))
                                              .toList(),
                                          onChanged: (String? value) {
                                            setState(() {
                                              selectedUser1Value = value!;
                                            });
                                          },
                                        ),
                                        TextFormField(
                                          decoration:
                                              InputDecoration(labelText: '順位'),
                                          onChanged: (value) => rank1 = value,
                                        ),
                                        DropdownButtonFormField<String>(
                                          decoration: InputDecoration(
                                            labelText: 'お酒',
                                          ),
                                          value: dropdownValue1,
                                          items: sakeList
                                              .map((String list) =>
                                                  DropdownMenuItem(
                                                      value: list,
                                                      child: Text(list)))
                                              .toList(),
                                          onChanged: (String? value) {
                                            setState(() {
                                              dropdownValue1 = value!;
                                            });
                                          },
                                        ),
                                        TextFormField(
                                          decoration: InputDecoration(
                                              labelText: 'お酒の量'),
                                          onChanged: (value) => amount1 = value,
                                        ),
                                        TextFormField(
                                          decoration: InputDecoration(
                                              labelText: 'お酒の度数'),
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
                                          items: nameList
                                              .map((String list) =>
                                                  DropdownMenuItem(
                                                      value: list,
                                                      child: Text(list)))
                                              .toList(),
                                          onChanged: (String? value) {
                                            setState(() {
                                              selectedUser2Value = value!;
                                            });
                                          },
                                        ),
                                        TextFormField(
                                          decoration:
                                              InputDecoration(labelText: '順位'),
                                          onChanged: (value) => rank2 = value,
                                        ),
                                        DropdownButtonFormField<String>(
                                          decoration: InputDecoration(
                                            labelText: 'お酒',
                                          ),
                                          value: dropdownValue2,
                                          items: sakeList
                                              .map((String list) =>
                                                  DropdownMenuItem(
                                                      value: list,
                                                      child: Text(list)))
                                              .toList(),
                                          onChanged: (String? value) {
                                            setState(() {
                                              dropdownValue2 = value!;
                                            });
                                          },
                                        ),
                                        TextFormField(
                                          decoration: InputDecoration(
                                              labelText: 'お酒の量'),
                                          onChanged: (value) => amount2 = value,
                                        ),
                                        TextFormField(
                                          decoration: InputDecoration(
                                              labelText: 'お酒の度数'),
                                          onChanged: (value) => ratio2 = value,
                                        ),
                                      ],
                                    ))),
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
                                          items: nameList
                                              .map((String list) =>
                                                  DropdownMenuItem(
                                                      value: list,
                                                      child: Text(list)))
                                              .toList(),
                                          onChanged: (String? value) {
                                            setState(() {
                                              selectedUser3Value = value!;
                                            });
                                          },
                                        ),
                                        TextFormField(
                                          decoration:
                                              InputDecoration(labelText: '順位'),
                                          onChanged: (value) => rank3 = value,
                                        ),
                                        DropdownButtonFormField<String>(
                                          decoration: InputDecoration(
                                            labelText: 'お酒',
                                          ),
                                          value: dropdownValue3,
                                          items: sakeList
                                              .map((String list) =>
                                                  DropdownMenuItem(
                                                      value: list,
                                                      child: Text(list)))
                                              .toList(),
                                          onChanged: (String? value) {
                                            setState(() {
                                              dropdownValue3 = value!;
                                            });
                                          },
                                        ),
                                        TextFormField(
                                          decoration: InputDecoration(
                                              labelText: 'お酒の量'),
                                          onChanged: (value) => amount3 = value,
                                        ),
                                        TextFormField(
                                          decoration: InputDecoration(
                                              labelText: 'お酒の度数'),
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
                                        "sake": dropdownValue1,
                                        "amount": amount1 == null
                                            ? 0
                                            : int.parse(amount1),
                                        "ratio": ratio1 == null
                                            ? 0
                                            : int.parse(ratio1)
                                      });
                                    }
                                    if (rank2 != null) {
                                      params.add({
                                        "name": selectedUser2Value,
                                        "rank": int.parse(rank2),
                                        "sake": dropdownValue2,
                                        "amount": amount2 == null
                                            ? 0
                                            : int.parse(amount2),
                                        "ratio": ratio2 == null
                                            ? 0
                                            : int.parse(ratio2)
                                      });
                                    }
                                    if (rank3 != null) {
                                      params.add({
                                        "name": selectedUser3Value,
                                        "rank": int.parse(rank3),
                                        "sake": dropdownValue3,
                                        "amount": amount3 == null
                                            ? 0
                                            : int.parse(amount3),
                                        "ratio": ratio3 == null
                                            ? 0
                                            : int.parse(ratio3)
                                      });
                                    }
                                    if (!params.isEmpty) {
                                      final response = http.post(
                                          Uri.parse(
                                              'http://127.0.0.1:3000/battle'),
                                          headers: <String, String>{
                                            'Content-Type':
                                                'application/json; charset=UTF-8',
                                          },
                                          body: jsonEncode(params));
                                    }
                                  },
                                ),
                              ]);
                            }
                            return Center(child: Text('エラーが発生しました'));
                          });
                    } else if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text("エラーが発生しました"));
                    }
                    {
                      return Center(child: Text('エラーが発生しました'));
                    }
                  }))),
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
                                          addedNameList.add(newUser);
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
                                          addedSakeList.add(newSake);
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
