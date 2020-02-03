import 'package:flutter/material.dart';
import 'package:newflutter/pages/loginpages/login_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: new GirisEkrani(),
    );
 
  }
}


