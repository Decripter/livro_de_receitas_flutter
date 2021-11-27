import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Client extends StatefulWidget {
  const Client({Key? key}) : super(key: key);

  @override
  _ClientState createState() => _ClientState();
}

class _ClientState extends State<Client> {
  String dropdownValue = '----';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Drawer Demo'),
            leading: IconButton(
              // ignore: prefer_const_constructors
              icon: Icon(Icons.filter_alt),
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
          ),
          drawer: Drawer(
            child: Column(
              children: [
                Container(
                  color: Colors.blue,
                  height: 55,
                ),
                DropdownButton<String>(
                  value: dropdownValue,
                  underline: Container(),
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownValue = newValue!;
                    });
                  },
                  items: <String>['----', 'Ana', 'Antonio', 'Marcos', 'Joana']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: TextFormField(
                    decoration: const InputDecoration(hintText: "Pesquisa"),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
