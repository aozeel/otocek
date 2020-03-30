import 'package:flutter/material.dart';
//import 'package:restaurant_ui_kit/screens/join.dart';
import 'package:newflutter/pages/loginpages/login_page.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:newflutter/services/auth_base.dart';
import 'package:newflutter/utils/const.dart';

class Walkthrough extends StatefulWidget {
  final AutBase authService;

  const Walkthrough({Key key, this.authService}) : super(key: key);

  @override
  _WalkthroughState createState() => _WalkthroughState();
}

class _WalkthroughState extends State<Walkthrough> {
  @override
  Widget build(BuildContext context) {
    List<PageViewModel> pages = [
      PageViewModel(
        "Kolay Filtreleme",
        "Vivamus magna justo, lacinia eget consectetur sed, convallis at tellus."
            " Vestibulum ac diam sit amet quam vehicula elementum sed sit amet "
            "dui. Nulla porttitor accumsan tincidunt.",
        image: Image.asset(
          "assets/on1.png",
          height: 175.0,
        ),
        decoration: PageDecoration(
          titleTextStyle: TextStyle(
            fontSize: 28.0,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).accentColor,
          ),
          bodyTextStyle: TextStyle(fontSize: 15.0),
        /*  dotsDecorator: DotsDecorator(
            activeColor: Theme.of(context).accentColor,
            activeSize: Size.fromRadius(8),
          ),*/
          pageColor:Constants.white,// Theme.of(context).primaryColor,
        ),
      ),

      PageViewModel(
        "Anında Bildirim",
        "Vivamus magna justo, lacinia eget consectetur sed, convallis at tellus."
            " Vestibulum ac diam sit amet quam vehicula elementum sed sit amet "
            "dui. Nulla porttitor accumsan tincidunt.",
        image: Image.asset(
          "assets/on2.png",
          height: 185.0,
        ),
        decoration: PageDecoration(
          titleTextStyle: TextStyle(
            fontSize: 28.0,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).accentColor,
          ),
          bodyTextStyle: TextStyle(fontSize: 15.0),
          dotsDecorator: DotsDecorator(
            activeColor: Theme.of(context).accentColor,
            activeSize: Size.fromRadius(8),
          ),
          pageColor: Constants.white,//Theme.of(context).primaryColor,
        ),
      ),

      PageViewModel(
        "Kolay Ödeme",
        "Vivamus magna justo, lacinia eget consectetur sed, convallis at tellus."
            " Vestibulum ac diam sit amet quam vehicula elementum sed sit amet "
            "dui. Nulla porttitor accumsan tincidunt.",
        image: Image.asset(
          "assets/on3.png",
          height: 175.0,
        ),
        decoration: PageDecoration(
          titleTextStyle: TextStyle(
            fontSize: 28.0,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).accentColor,
          ),
          bodyTextStyle: TextStyle(fontSize: 15.0),
          dotsDecorator: DotsDecorator(
            activeColor: Theme.of(context).accentColor,
            activeSize: Size.fromRadius(8),
          ),
          pageColor:Constants.white,// Theme.of(context).primaryColor,
        ),
      ),
    ];

    return WillPopScope(
      onWillPop: ()=>Future.value(false),
      child: Scaffold(
        backgroundColor:Constants.white,//Theme.of(context).primaryColor,
        body: Padding(
          padding: EdgeInsets.all(10.0),
          child: IntroductionScreen(
            pages: pages,
            onDone: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context){
                    return GirisEkraniFul();//JoinApp();
                  },
                ),
              );
            },
            onSkip: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context){
                    return GirisEkraniFul(); //JoinApp();
                  },
                ),
              );
            },
            showSkipButton: true,
            skip: Text("Skip"),
            next: Text(
              "Next",
              style: TextStyle(
                fontWeight: FontWeight.w800,
                color: Theme.of(context).accentColor,
              ),
            ),
            done: Text(
              "Done",
              style: TextStyle(
                fontWeight: FontWeight.w800,
                color: Theme.of(context).accentColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
