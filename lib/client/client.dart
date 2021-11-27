import 'package:flutter/material.dart';
import 'components/components.dart';

class Client extends StatefulWidget {
  const Client({Key? key}) : super(key: key);

  @override
  _ClientState createState() => _ClientState();
}

class _ClientState extends State<Client> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        child: Column(
          children: [
            Container(
              color: Colors.blue,
              height: 55,
            ),
            const DropDownComponent(),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: TextFormField(
                decoration: const InputDecoration(hintText: "Pesquisa"),
              ),
            )
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text('Livro de Receitas'),
        leading: IconButton(
          // ignore: prefer_const_constructors
          icon: Icon(Icons.filter_alt),
          onPressed: () => _scaffoldKey.currentState!.openDrawer(),
        ),
      ),
    );
  }
}
