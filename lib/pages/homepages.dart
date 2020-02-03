import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
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


    Widget _bottomNavigationBar(int selectedIndex)=>FancyBottomNavigation(
      circleColor: Colors.amber,
      activeIconColor: Colors.white,
      barBackgroundColor: Colors.white,
      inactiveIconColor: Colors.amber,

          tabs: [
       TabData(iconData: Icons.drive_eta, title: "Anasayfa"),
       TabData(iconData: Icons.shopping_cart, title: "Paketler"),
       TabData(iconData: Icons.zoom_in, title: "Filtreleme"),
       TabData(iconData: Icons.favorite, title: "Garajım"),
       TabData(iconData: Icons.person, title: "Profil")
    ],



          onTabChangedListener: (int position){
      setState((){
        _selectedIndex=position;
      });
    },
          
          );

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