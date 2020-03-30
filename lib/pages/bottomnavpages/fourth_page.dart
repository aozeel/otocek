import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:newflutter/model/car.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:newflutter/model/cardb.dart';
import 'package:newflutter/utils/const.dart';
import 'package:newflutter/utils/database_helper.dart';
import 'package:sqflite/sqflite.dart';

class FourthPage extends StatelessWidget {
  const FourthPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Constants.primaryColor,
    ));
    return Scaffold(
      body: FourthPageStateFul(),
    );
  }
}

class FourthPageStateFul extends StatefulWidget {
  @override
  FourthPageState createState() => FourthPageState();
}

class FourthPageState extends State<FourthPageStateFul> {
  //static List<Car> carList = Car.getFavori();
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Cardb> favList;
  int count = 0;

  FlutterMoneyFormatter fmf = FlutterMoneyFormatter(amount: 12345678.9012345);
  @override
  Widget build(BuildContext context) {
    if (favList == null) {
      favList = List<Cardb>();

      updateFavListView();
    }
    return _buildListView();
  }

  Widget _buildListView() {
    return Container(
      margin: EdgeInsets.only(top: 40.0),
      child: ListView.builder(
        padding: const EdgeInsets.all(5.0),
        itemCount: favList.length,
        itemBuilder: (context, index) {
          final item = favList[index].title;
          return Slidable(
            key: ValueKey(index),
            actionPane: SlidableDrawerActionPane(),
            actions: <Widget>[
              IconSlideAction(
                caption: Constants.remove,
                color: Constants.iconcolorred,
                icon: Icons.delete,
                onTap: () {
                  setState(() {
                    favList.removeAt(index);
                    Scaffold.of(context).showSnackBar(
                        SnackBar(content: Text("$item kaldırıldı")));
                  });
                },
              ),
            ],
            secondaryActions: <Widget>[
              IconSlideAction(
                caption: Constants.remove,
                color: Constants.iconcolorred,
                icon: Icons.delete,
                onTap: () {
                  setState(() {
                    //favList.removeAt(index);
                    deleteFavori(favList[index].id);
                    Scaffold.of(context).showSnackBar(
                        SnackBar(content: Text("$item kaldırıldı")));
                  });
                },
              ),
            ],
            child: _buildImageColumn(index),
          );
        },
      ),
    );
  }

  Widget _buildImageColumn(index) => Container(
        decoration: BoxDecoration(color: Colors.blue[50]),
        margin: const EdgeInsets.all(8),
        child: Card(
          child: Column(
            children: <Widget>[
              image(index),
              ilanmodel(index),
              ilanicerik(index),
            ],
          ),
        ),
      );

  Widget image(index) => Container(
        child: Stack(
          // Yazıyı resim içerisinde yazmak için kulanılır
          alignment: Alignment
              .bottomRight, //Container ı resmin sağ alt konumuna götürdü
          children: <Widget>[
            Container(
              height: 150,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage(favList[index].image),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(4),
              color: Constants.primaryColor,
              child: Text(
                fmf
                        .copyWith(
                            amount: favList[index].price, fractionDigits: 3)
                        .output
                        .nonSymbol +
                    " TL",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      );

  Widget ilanmodel(index) => new Container(
        margin: const EdgeInsets.only(top: 8.0, left: 8.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Expanded(
              child: Container(
                child: RichText(
                  overflow: TextOverflow.ellipsis,
                  strutStyle: StrutStyle(fontSize: 14.0),
                  text: TextSpan(
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                      text: favList[index].title),
                ),
              ),
            ),
          ],
        ),
      );

  Widget ilanicerik(index) => new Container(
        margin: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Expanded(
              flex: 5,
              child: Container(
                margin: const EdgeInsets.only(right: 8.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Constants.primaryColor,
                  boxShadow: [
                    BoxShadow(color:Constants.primaryColor, spreadRadius: 3),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new IconTheme(
                      data: new IconThemeData(color: Constants.white,),
                      child: new Icon(
                        Icons.location_on,
                        size: 15,
                      ),
                    ),
                    Container(
                      child: RichText(
                        overflow: TextOverflow.ellipsis,
                        strutStyle: StrutStyle(fontSize: 10.0),
                        text: TextSpan(
                            style: TextStyle(color: Constants.white,),
                            text: favList[index].location),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                margin: const EdgeInsets.only(right: 8.0),
                child: Center(
                  child: Text(
                    favList[index].year,
                    style: TextStyle(color: Constants.white,),
                    textAlign: TextAlign.center,
                  ),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Constants.primaryColor,
                  boxShadow: [
                    BoxShadow(color: Constants.primaryColor, spreadRadius: 3),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                child: Image.asset(
                  "assets/" + favList[index].logo,
                  fit: BoxFit.fitWidth,
                  width: 100,
                ),
              ),
            )
          ],
        ),
      );

  /*
                                static void addtoFav(Car){
                                  favList.add(Car);
                                }*/

  void updateFavListView() {
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();

    dbFuture.then((database) {
      Future<List<Cardb>> favListFuture = databaseHelper.getFavList();

      favListFuture.then((favList) {
        setState(() {
          this.favList = favList;
          this.count = favList.length;
        });
      });
    });
  }

  void deleteFavori(int id) async {
    await databaseHelper.deleteFav(id);
    updateFavListView();
  }
}
