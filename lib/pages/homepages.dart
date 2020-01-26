import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:newflutter/pages/bottomnavpages/first_page.dart';
import 'package:newflutter/pages/bottomnavpages/second_page.dart';
import 'package:newflutter/pages/bottomnavpages/third_page.dart';
import 'package:newflutter/pages/bottomnavpages/fourth_page.dart';
import 'package:newflutter/pages/bottomnavpages/fifth_page.dart';

class HomePage extends StatefulWidget {
  //final List<City> _allCities = City.allCities();

  @override
  _AppBottomNavigationBarControllerState createState() =>
  _AppBottomNavigationBarControllerState();



/*

  HomePage() {}

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(

          title: new Text(
            "ArabaCek",
            style: new TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.black87),
          ),
        ),
        body: new Padding(
            padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
            child: getHomePageBody(context)),
            
        bottomNavigationBar: CurvedNavigationBar(
          color: Colors.amber,
          //buttonBackgroundColor: Colors.white,
          backgroundColor:Colors.transparent,
          height: 50.0,
          items: <Widget>[
            Icon(Icons.verified_user,size: 20,color: Colors.black,),
            Icon(Icons.add,size: 20,color: Colors.black,),
            Icon(Icons.list,size: 20,color: Colors.black,),
          ],
          animationDuration: Duration(milliseconds: 200),
          animationCurve: Curves.bounceInOut,
          //index: 1, //default tab at start
          onTap:(index){
            debugPrint("Current index is $index");
          } ,
        ),
            );
  }

  getHomePageBody(BuildContext context) {
    return ListView.builder(
      itemCount: _allCities.length,
      itemBuilder: _getItemUI,
      padding: EdgeInsets.all(0.0),
    );
  }



  Widget _getItemUI(BuildContext context, int index) {
    return new Container(
          margin:EdgeInsets.all(8.0),
          child: Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8.0))),
            child: InkWell(
              onTap: () => print("ciao"),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,  // add this
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8.0),
                      topRight: Radius.circular(8.0),
                    ),
                    child: Image.asset(
                        "assets/" + _allCities[index].image,
                       // width: 300,
                        height: 200,
                        fit:BoxFit.fill

                    ),
                  ),
                  ListTile(
                    
                    title: Text(_allCities[index].name),
                    subtitle: Text(_allCities[index].population),
                  ),
                ],
              ),
            ),
          ),
        );
  }

  _showSnackBar(BuildContext context, City item) {
    final SnackBar objSnackbar = new SnackBar(
      content: new Text("${item.name} is a city in ${item.country}"),
      backgroundColor: Colors.amber,
    );
    Scaffold.of(context).showSnackBar(objSnackbar);
  }*/

  


}



class _AppBottomNavigationBarControllerState
    extends State<HomePage> {
   final List<Widget> pages = [
    FirstPage(
      key: PageStorageKey('Page1'),
    ),
    SecondPage(
      key: PageStorageKey('Page2'),
    ),
    ThirdPage(
      key: PageStorageKey('Page3'),
    ),
    FourthPage(
      key: PageStorageKey('Page4'),
    ),
    FifthPage(
      key: PageStorageKey('Page5'),
    ),
  ];

  final PageStorageBucket bucket = PageStorageBucket();

  int _selectedIndex = 0;
/*
  Widget _bottomNavigationBar(int selectedIndex) => BottomNavigationBar(
        onTap: (int index) => setState(() => _selectedIndex = index),
        currentIndex: selectedIndex,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.add), title: Text('First Page')),
          BottomNavigationBarItem(
              icon: Icon(Icons.list), title: Text('Second Page')),
        ],
      );*/

    Widget _bottomNavigationBar(int selectedIndex)=>CurvedNavigationBar(color: Colors.amber,
          //buttonBackgroundColor: Colors.white,
          backgroundColor:Colors.transparent,
          height: 50.0,
          items: <Widget>[
            Icon(Icons.drive_eta,size: 20,     color: Colors.black,),
            Icon(Icons.favorite,size: 20,      color: Colors.black,),
            Icon(Icons.zoom_in,size: 20,       color: Colors.black,),
            Icon(Icons.shopping_cart,size: 20, color: Colors.black,),
            Icon(Icons.person,size: 20,        color: Colors.black,),
          ],
          animationDuration: Duration(milliseconds: 200),
          animationCurve: Curves.bounceInOut,
          //index: 1, //default tab at start
          onTap: (int index) => setState(() => _selectedIndex = index),);

  @override
  Widget build(BuildContext context) {
    return Scaffold(     
      bottomNavigationBar: _bottomNavigationBar(_selectedIndex),
      body: PageStorage(
        child: pages[_selectedIndex],
        bucket: bucket,
      ),
    );
  }
    }