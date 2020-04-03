import 'dart:async';
import 'package:flutter/material.dart';
import 'package:newflutter/handler/notification_handler.dart';
import 'package:newflutter/model/user.dart';
import 'package:newflutter/pages/bottomnavpages/first_page.dart';
import 'package:newflutter/pages/bottomnavpages/second_page.dart';
import 'package:newflutter/pages/bottomnavpages/third_page.dart';
import 'package:newflutter/pages/bottomnavpages/fourth_page.dart';
import 'package:newflutter/pages/bottomnavpages/fifth_page.dart';
import 'package:newflutter/services/auth_base.dart';
import 'package:newflutter/services/firebase_auth_service.dart';
import 'package:newflutter/services/locator.dart';
import 'package:newflutter/viewmodel/usermodel.dart';
import 'package:provider/provider.dart';
import 'package:showcaseview/showcase.dart';
import 'package:showcaseview/showcase_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
class HomePage extends StatefulWidget {
  static const PREFERENCES_IS_FIRST_LAUNCH_STRING = "PREFERENCES_IS_FIRST_LAUNCH_STRING";
  final User user;

  const HomePage({Key key,@required this.user}) : super(key: key);
  @override
  HomePageState createState() => HomePageState();

  HomePage.navigate(int page, this.user) {
    HomePageState.changePage(2);

  }
}

class HomePageState extends State<HomePage> {

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
      onSignOut: null,
    ),
  ];

  AutBase authService=locator<FirebaseAuthService>();
  GlobalKey _one = GlobalKey();
  BuildContext myContext;
  @override
  void initState() {
    NotificationHandler().initializeFCMNotification(context);
    WidgetsBinding.instance.addPostFrameCallback((_) {
        _isFirstLaunch().then((result){
          if(result)
          ShowCaseWidget.of(myContext).startShowCase([_one]);
        });


    });
  }
  final PageStorageBucket bucket = PageStorageBucket();

  static int _selectedIndex = 0;

  static void changePage(int pageNumber) {
    _selectedIndex = pageNumber;
  }

  Widget newNavigation(int selectedIndex) => BottomAppBar(
        child: new Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SizedBox(width: 7),
            IconButton(
              icon: Icon(
                Icons.directions_car,
                size: 24.0,
              ),
              color: _selectedIndex == 0
                  ? Theme.of(context).accentColor
                  : Theme.of(context).textTheme.caption.color,
              onPressed: () => setState(() {
                _selectedIndex = 0;
              }),
            ),
            IconButton(
              icon: Icon(
                //Icons.redeem,
                //Icons.view_stream
                Icons.shopping_cart,
                size: 24.0,
              ),
              color: _selectedIndex == 1
                  ? Theme.of(context).accentColor
                  : Theme.of(context).textTheme.caption.color,
              onPressed: () => setState(() {
                _selectedIndex = 1;
              }),
            ),
            IconButton(
              icon: Icon(
                Icons.search,
                size: 24.0,
                color: Colors.white, //Theme.of(context).primaryColor,
              ),
              color: _selectedIndex == 2
                  ? Theme.of(context).accentColor
                  : Theme.of(context).textTheme.caption.color,
              onPressed: () => setState(() {
                _selectedIndex = 2;
              }),
            ),
            IconButton(
                icon: Icon(
                  Icons.favorite,
                  size: 24.0,
                ),
                color: _selectedIndex == 3
                    ? Theme.of(context).accentColor
                    : Theme.of(context).textTheme.caption.color,
                onPressed: () => setState(() {
                      _selectedIndex = 3;
                    })),
            IconButton(
              icon: Icon(
                Icons.person,
                size: 24.0,
              ),
              color: _selectedIndex == 4
                  ? Theme.of(context).accentColor
                  : Theme.of(context).textTheme.caption.color,
              onPressed: () => setState(() {
                _selectedIndex = 4;
              }),
            ),
            SizedBox(width: 7),
          ],
        ),
        color: Colors.white, // Theme.of(context).primaryColor,
        shape: CircularNotchedRectangle(),
      );

          @override
          Widget build(BuildContext context) {
            final _usermodel=Provider.of<UserModel>(context);
            return   ShowCaseWidget(
              builder: Builder(
                builder: (context) {
                  myContext=context;
                  return Scaffold(
                    bottomNavigationBar: newNavigation(_selectedIndex),
                    body: PageStorage(
                      child: pages[_selectedIndex],
                      bucket: bucket,
                    ),
                    floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
                    floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
                    floatingActionButton:Showcase(
                      key: _one,
                      title: 'Filtre Ekle',
                      description: 'Tıklayıp sayfaya gidiniz',
                      shapeBorder: CircleBorder(),
                      child: FloatingActionButton(
                        elevation: 4.0,
                        child: Icon(
                          Icons.search,
                          color: Colors.white,
                        ),
                        onPressed: () => setState(() {
                          _selectedIndex = 2;
                        }),
                      ),
                    ),

                  );
                },
              ),
            );
          }

  Future<bool> _isFirstLaunch() async{
    final sharedPreferences = await SharedPreferences.getInstance();
    bool isFirstLaunch = sharedPreferences.getBool(HomePage.PREFERENCES_IS_FIRST_LAUNCH_STRING) ?? true;

    if(isFirstLaunch)
      sharedPreferences.setBool(HomePage.PREFERENCES_IS_FIRST_LAUNCH_STRING, false);

    return isFirstLaunch;
  }

          
}
