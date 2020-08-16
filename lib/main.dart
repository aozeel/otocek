import 'package:flutter/material.dart';
import 'package:newflutter/pages/splashpages/splash.dart';
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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserModel>( create:(context)=>UserModel(),),
      ],
      child: new MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: new ThemeData(
          primarySwatch: Colors.amber,
        ),
      home:SplashScreen(),
//      home:HomePage(user: null,),
        ),
    );
  }
}
