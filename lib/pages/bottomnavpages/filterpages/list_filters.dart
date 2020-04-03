import 'package:flutter/material.dart';
//import 'package:newflutter/model/filtre.dart';
import 'package:newflutter/model/filtredb.dart';
import 'package:newflutter/utils/const.dart';
import 'package:newflutter/utils/database_helper.dart';
import 'package:sqflite/sqflite.dart';

class FiltrelemeDuzenle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My App',
      home: Scaffold(
        appBar: AppBar(
          title: Text(Constants.myfilter),
          backgroundColor: Constants.primaryColor,
        ),
        body: FiltrelemeDuzenleFul(),
      ),
    );
  }
}

class FiltrelemeDuzenleFul extends StatefulWidget {
  @override
  FiltrelemeDuzenleState createState() => FiltrelemeDuzenleState();
}

class FiltrelemeDuzenleState extends State<FiltrelemeDuzenleFul> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  static List<Filtredb> _lstofFiltres;
  int count = 0;

  @override
  Widget build(BuildContext context) {
    if(this.mounted){
      setState(() {
        updateFiltreListView();
      });
    }


   if (_lstofFiltres == null) {
      _lstofFiltres = List<Filtredb>();
      updateFiltreListView();
    }

    return ListView.builder(
        itemCount: count, //_lstofFiltres.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
              _lstofFiltres[index].marka +
                  " " +
                  _lstofFiltres[index].model, //FiltrelemeDuzenle.gelenMarka
              style: TextStyle(color: Constants.black,),
            ),
            subtitle: Text(
              "Fiyat=" +
                  _lstofFiltres[index].minFiyat.toString() +
                  "-" +
                  _lstofFiltres[index].maxFiyat.toString() +
                  " / " +
                  "Yıl=" +
                  _lstofFiltres[index].minYil.toString() +
                  "-" +
                  _lstofFiltres[index].maxYil.toString(),
              style: TextStyle(color: Constants.black,),
            ),
            trailing: Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
              GestureDetector(
                onTap: () {
                  if(this.mounted){
                    setState(() {
                      //Delete Button for delete filtre from database
                      deleteFiltre(_lstofFiltres[index].id, index);
                    });
                  }


                },
                child: Icon(Icons.delete, color: Constants.redAccent,),
              ),
              Switch(
                value: getbool(_lstofFiltres[index].isActive),
                onChanged: (bool newvalue) {
                  if(this.mounted){
                    setState(() {
                      //Click switch to update filter database(active-passive)
                      _lstofFiltres[index].isActive = convertBool(newvalue);
                      updateFiltre(_lstofFiltres[index]);
                    });
                  }


                },
                activeTrackColor: Constants.lightGreenAccent,
                activeColor: Constants.green,
              ),
            ]),
            onTap: () {
             """ print(_lstofFiltres[index].marka);
              print(_lstofFiltres[index].model);
              print("fiyat");
              print(_lstofFiltres[index].minFiyat);
              print(_lstofFiltres[index].maxFiyat);
              print("km");
              print(_lstofFiltres[index].colminKm);
              print(_lstofFiltres[index].colmaxKm);

              print("transmission");
              print(_lstofFiltres[index].colTransmission);""";

              print("engine pow");
              print(_lstofFiltres[index].hp);



              //print(_lstofFiltres[index].colTransmission);
              //print(_lstofFiltres[index].color);
              //print(_lstofFiltres[index].hp);
              //print(_lstofFiltres[index].location);
              //print(_lstofFiltres[index].colFuel);
            },
            selected: true,
          );
        });
  }

  void updateFiltreListView() {
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {
      Future<List<Filtredb>> filtreListFuture = databaseHelper.getFiltreList();
      filtreListFuture.then((_lstofFiltres) {
        if(this.mounted){
          setState(() {
            FiltrelemeDuzenleState._lstofFiltres = _lstofFiltres;
            this.count = _lstofFiltres.length;
          });
        }
      });
    });
  }

  bool getbool(int deger) {
    switch (deger) {
      case 0:
        return false;
        break;

      case 1:
        return true;
        break;

      default:
        return true;
    }
  }

  int convertBool(bool value) {
    switch (value) {
      case false:
        return 0;
        break;

      case true:
        return 1;
        break;
    }
  }

  void updateFiltre(Filtredb filtredb) async {
    await databaseHelper.updateFilt(filtredb);
  }

  void deleteFiltre(int id, int index) async {
    await databaseHelper.deleteFiltre(id);
    updateFiltreListView();
  }
  static Future<List<Filtredb>> getfiltreler()async{
    
    return FiltrelemeDuzenleState._lstofFiltres;
  }
}
