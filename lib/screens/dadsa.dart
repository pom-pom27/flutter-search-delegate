import 'package:flutter/material.dart';

class Dadsa extends StatefulWidget {
  const Dadsa({Key? key}) : super(key: key);

  @override
  _DadsaState createState() => _DadsaState();
}

class _DadsaState extends State<Dadsa> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dadsa'),
      ),
      body: Center(
        child: Text('Dadsa'),
      ),
    );
  }
}
