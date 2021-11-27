import 'package:flutter/material.dart';

class DropDownComponent extends StatefulWidget {
  const DropDownComponent({Key? key}) : super(key: key);

  @override
  _DropDownComponentState createState() => _DropDownComponentState();
}

class _DropDownComponentState extends State<DropDownComponent> {
  String dropdownValue = '----';
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
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
    );
  }
}
