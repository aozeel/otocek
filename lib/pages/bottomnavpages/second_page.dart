import 'package:flutter/material.dart';

class SecondPage extends StatelessWidget {
  const SecondPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Second Screen"),
      ),
      body: ListView.builder(itemBuilder: (context, index) {
        return ListTile(
          //leading: Icon(Icons.drive_eta),
          title: Text('Title'),
          subtitle: Text('$index'),
        );
      }
      ),
    );
  }
}