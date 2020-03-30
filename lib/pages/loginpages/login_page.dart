import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:newflutter/pages/loginpages/login.dart';
import 'package:newflutter/pages/loginpages/register.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:newflutter/services/auth_base.dart';
import 'package:newflutter/services/firebase_auth_service.dart';
import 'package:newflutter/services/locator.dart';
import 'package:newflutter/utils/const.dart';


class GirisEkraniFul extends StatefulWidget {
  @override
  GirisEkraniState createState() => GirisEkraniState();
}



class GirisEkraniState extends State<GirisEkraniFul> with SingleTickerProviderStateMixin{

  static TabController _tabController;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  static int _selectedIndex=0;
  AutBase authService=locator<FirebaseAuthService>();
  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, initialIndex: 1, length: 2);
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
  }

  static void changePage(int pageNumber) {
    _tabController.index=pageNumber;
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Constants.primaryColor,
      ),
      home: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          bottom: TabBar(
            controller: _tabController,
            indicatorColor: Theme.of(context).accentColor,
            labelColor: Constants.white,
            unselectedLabelColor: Constants.white,
            labelStyle: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w800,
            ),
            unselectedLabelStyle: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w800,
            ),
            tabs: <Widget>[
              Tab(
                text: "Giriş Yap",
              ),
              Tab(
                text: "Kayıt Ol",
              ),
            ],
          ),
        ),

        body: TabBarView(
          controller: _tabController,
          children: <Widget>[
            GirisYap(),
            KayitOl(),
          ],
        ),


      ),
    );
  }
}