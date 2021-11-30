import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<Album> fetchAlbum(id) async {
  final response = await http.get(
      Uri.parse('https://livro-de-receita.herokuapp.com/client/' + id + '/'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Album.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

class Album {
  final int id;
  final int chef;
  final String receita;

  Album({
    required this.id,
    required this.chef,
    required this.receita,
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      id: json['id'],
      chef: json['chef'],
      receita: json['receita'],
    );
  }
}

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  TextEditingController _textcontroller = TextEditingController();

  @override
  void dispose() {
    _textcontroller.dispose();
    super.dispose();
  }

  @override
  late Future<Album> futureAlbum;

  @override
  void initState() {
    super.initState();
    String id = '1';
    futureAlbum = fetchAlbum(id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fetch Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Receita'),
          leading: IconButton(
            // ignore: prefer_const_constructors
            icon: Icon(Icons.download),
            onPressed: () {
              setState(() {
                String id = '1';
                futureAlbum = fetchAlbum(id);
              });
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Container(
                        child: TextField(
                          controller: _textcontroller,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Enter a search term'),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: () {
                        setState(() {
                          String id = _textcontroller.text;

                          futureAlbum = fetchAlbum(id);
                        });
                      },
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 18),
                  child: Center(
                    child: FutureBuilder<Album>(
                      future: futureAlbum,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Text(snapshot.data!.receita);
                        } else if (snapshot.hasError) {
                          return Text('${snapshot.error}');
                        }

                        // By default, show a loading spinner.
                        return const CircularProgressIndicator();
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
