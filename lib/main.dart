import 'package:flutter/material.dart';
import 'package:newflutter/deneme.dart';
import 'package:newflutter/pages/deneme.dart';
import 'package:newflutter/pages/homepages.dart';
import 'package:newflutter/pages/loginpages/landing_page.dart';
import 'package:newflutter/services/firebase_auth_service.dart';
import 'package:newflutter/services/locator.dart';
import 'package:newflutter/viewmodel/usermodel.dart';
import 'package:provider/provider.dart';


void main(){
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //ağacımıza usermodel enjecte ettik uygulamamızın her yerinde provider.of diyerek kullanabiliriz
    return ChangeNotifierProvider(
      create: (context) => UserModel(),
      child: new MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: new ThemeData(
          primarySwatch: Colors.amber,
        ),
        home:LandingPage()
//      home: HomePage(user: null,),
        ),
    );
  }
}
