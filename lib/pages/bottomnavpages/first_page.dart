import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:newflutter/model/cardb.dart';
import 'package:newflutter/pages/vebview.dart';
import 'package:newflutter/utils/const.dart';
import 'package:newflutter/utils/database_helper.dart';
import 'package:sqflite/sqflite.dart';
import 'package:newflutter/model/choice.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({Key key}) : super(key: key);
  @override
  FirstPageState createState() => FirstPageState();
}
  const List<Choice> choices = const <Choice>[
  const Choice(id:0,title: 'Son Eklenen Üstte', icon: Icons.directions_car),
  const Choice(id:1,title: 'Son Eklenen Altta', icon: Icons.directions_bike),
  const Choice(id:2,title: 'Fiyata Göre Artan', icon: Icons.directions_boat),
  const Choice(id:3,title: 'Fiyata Göre Azalan', icon: Icons.directions_bus),
  const Choice(id:4,title: 'Yıla Göre Artan', icon: Icons.directions_railway),
  const Choice(id:5,title: 'Yıla Göre Azalan', icon: Icons.directions_walk),
];


class FirstPageState extends State<FirstPage> {
  //static List<Car> carList = Car.getCar();
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Cardb> carList;
  int count = 0;

  FlutterMoneyFormatter fmf = FlutterMoneyFormatter(amount: 12345678.9012345);

  @override
  Widget build(BuildContext context) {
    if(this.mounted){
      setState(() {
        updateCarListView();
      });
    }

    if (carList == null) {
      return Scaffold(
          body: Center(
        child: CircularProgressIndicator(),
      ));
    }

    //listeleme yok ise gelen sayfa
    if (carList.length <=
        0 /* && FiltrelemeDuzenleState.lengthofFilter()<= 0*/) {
      return _buildEmptyFilter();
    }
    return Scaffold(appBar: AppBar(
        title: Text("OtoÇek"),
        actions: <Widget>[
          PopupMenuButton<Choice>(
              icon: Icon(Icons.format_line_spacing),
              onSelected: _select,
              itemBuilder: (BuildContext context) {
                return choices.map((Choice choice) {
                  return PopupMenuItem<Choice>(
                    value: choice,
                    child: Text(choice.title),
                  );
                }).toList();
              },
            ),
        ],
      ),
      body:_buildListView());
  }

   Widget _buildEmptyFilter() {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 150, 10, 0),
      alignment: Alignment.bottomCenter,
      child: Column(children: <Widget>[
        Text(
          Constants.welcome,
          style: TextStyle(
            fontSize: 25.0,
            fontWeight: FontWeight.w700,
            color: Constants.primaryColor,
          ),
        ),
        Divider(
          color: Colors.transparent,
          height: 20,
        ),
        Text(
          Constants.welcome1,
          style: TextStyle(
            fontSize: 25.0,
            fontWeight: FontWeight.w700,
            color: Constants.primaryColor,
          ),
        ),
        Divider(
          color: Colors.transparent,
          height: 50,
        ),
        Icon(Icons.drive_eta, size: 200, color: Colors.black26),
        Icon(Icons.arrow_downward, size: 150, color: Colors.black26),
      ]),
    );
  }

  Choice _selectedChoice = choices[0];
  void _select(Choice choice) {
    // Causes the app to rebuild with the new _selectedChoice.
    if(this.mounted){
      setState(() {
        _selectedChoice = choice;
        //updateCarListView();
      });
    }

  }

  Widget _buildListView() {
    return Container(
      margin: EdgeInsets.only(top: 40.0),
      child: ListView.builder(
        padding: const EdgeInsets.all(5.0),
        itemCount: carList.length,
        itemBuilder: (context, index) {
          final item = carList[index].title;
          return Slidable(
            key: ValueKey(index),
            actionPane: SlidableDrawerActionPane(),
            actions: <Widget>[
              IconSlideAction(
                caption:  Constants.garage,
                color: Constants.blue,
                icon: Icons.archive,
                onTap: () {
                  if(this.mounted){
                    setState(() {
                      //FourthPageState.addtoFav(carList[index]);
                      insertToFavori(carList[index]);
                      Scaffold.of(context).showSnackBar(
                          SnackBar(content: Text("$item favorilere eklendi")));
                    });
                  }

                },
              ),
            ],
            secondaryActions: <Widget>[
              IconSlideAction(
                caption:  Constants.remove,
                color: Constants.iconcolorred,
                icon: Icons.delete,
                onTap: () {
                  //databaseHelper.deleteCar(carList[index].id);
                  if(this.mounted){
                    setState(() {
                      // carList.removeAt(index);
                      deleteCar(carList[index].id);
                      //updateCarListView();
                      Scaffold.of(context).showSnackBar(
                          SnackBar(content: Text("$item kaldırıldı")));
                    });
                  }


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
        decoration: BoxDecoration(color: Constants.blue50,),
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

  Widget image(index) => GestureDetector(
    onTap: () => Navigator.push(
      context,
      MaterialPageRoute(         //Modelleri oluştur
        builder: (context) => WebViewPage(carList[index].link_detay),
      ),
    ),
    child: Container(
          child: Container(
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 7,
                  child: Container(
                    height: 150,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: NetworkImage(carList[index].image),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(4),
                        color: Constants.primaryColor,
                        child: Text(
                          fmf
                              .copyWith(
                              amount: carList[index].price, fractionDigits: 3)
                              .output
                              .nonSymbol +
                              " TL",
                          style: TextStyle(color:Constants.white,),
                        ),
                      ),
                      SizedBox(height: 8,),
                      Container(
                        padding: EdgeInsets.all(4),
                        color: Constants.primaryColor,
                        child: Text("250.000 KM",
                          style: TextStyle(color:Constants.white,),
                        ),
                      ),
                      SizedBox(height: 8,),
                      Container(
                        padding: EdgeInsets.all(4),
                        color: Constants.primaryColor,
                        child: Text("Benzin",
                          style: TextStyle(color:Constants.white,),
                        ),
                      ),
                      SizedBox(height: 8,),
                      Container(
                        padding: EdgeInsets.all(4),
                        color: Constants.primaryColor,
                        child: Text("Otomatik",
                          style: TextStyle(color:Constants.white,),
                        ),
                      ),
                    ],
                  )
                ),
              ],
            ),
          ),

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
                          color: Constants.black, fontWeight: FontWeight.bold),
                      text: carList[index].title),
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
                    BoxShadow(color: Constants.primaryColor, spreadRadius: 3),
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
                            text: carList[index].location),
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
                    carList[index].year,
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
                  "assets/" + carList[index].logo,
                  fit: BoxFit.fitWidth,
                  width: 100,
                ),
              ),
            )
          ],
        ),
      );

  void updateCarListView() {
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();

    dbFuture.then((database) {
      Future<List<Cardb>> carListFuture = databaseHelper.getCarList();

      carListFuture.then((carList) {
        if(this.mounted){
          setState(() {
            this.carList = carList;
            this.count = carList.length;
            switch(_selectedChoice.getid){
              case(0):
                return this.carList.sort( (b, a) => (a.id).compareTo(b.id) );
              case(1):
                return this.carList.sort( (a, b) => (a.id).compareTo(b.id) );
              case(2):
                return this.carList.sort( (a, b) => a.price.compareTo(b.price));
              case(3):
                return this.carList.sort( (b, a) => a.price.compareTo(b.price));
              case(4):
                return this.carList.sort( (a, b) => int.parse(a.year).compareTo(int.parse(b.year)) );
              case(5):
                return this.carList.sort( (b, a) => int.parse(a.year).compareTo(int.parse(b.year)) );
            }

          });
        }


      });
    });
  }

  void insertToFavori(Cardb carList) async {
    await databaseHelper.insertFav(carList);
  }

  void deleteCar(int id) async {
    await databaseHelper.deleteCar(id);
    updateCarListView();
  }
}
