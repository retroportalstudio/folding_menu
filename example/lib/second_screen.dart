import 'package:flutter/material.dart';

class SecondScreen extends StatelessWidget {
  final String text;

  const SecondScreen({Key? key, this.text = "Demo Screen"}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: Text("Second Screen"),),
      body: Container(
        child: Center(child: Text(text),),
      ),
    );
  }
}
