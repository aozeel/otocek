import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:newflutter/pages/loginpages/login.dart';
import 'package:newflutter/pages/loginpages/register.dart';

class GirisEkrani extends StatelessWidget {
    
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: new GirisEkraniFul(),
    );
 
  }
}
class GirisEkraniFul extends StatefulWidget {
  @override
  GirisEkraniState createState() => GirisEkraniState();
}



class GirisEkraniState extends State<GirisEkraniFul> with SingleTickerProviderStateMixin{

  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, initialIndex: 1, length: 2);
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
    
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Theme.of(context).accentColor,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white,
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


    );
  }
}