import 'package:flutter/material.dart';
import 'package:newflutter/model/filtredb.dart';
import 'package:newflutter/pages/bottomnavpages/filterpages/FilterDetail.dart';
import 'package:newflutter/pages/bottomnavpages/filterpages/list_filters.dart';
import 'package:newflutter/pages/homepages.dart';
import 'package:newflutter/utils/const.dart';
import 'package:newflutter/utils/database_helper.dart';
import 'package:newflutter/utils/marka_model.dart';
import 'dart:convert';

class ThirdPage extends StatefulWidget{
  const ThirdPage({Key key}) : super(key: key);
  @override
  ThirdPageState createState() => ThirdPageState();
}

class ThirdPageState extends State<ThirdPage> {
   

  static DatabaseHelper databaseHelper = DatabaseHelper();

List<String> Markalar = [];
List<String> Modeller = [];
List<String> Seri = ['Tümü'];


Map<String, dynamic> map;

  Future<void>loadmmodel() async{
    String jsonString = await Markamodel.loadAsset();
    final jsonResponse = json.decode(jsonString);
    
    //var List =jsonDecode(jsonResponse);
    map = json.decode(jsonResponse);
    //List<dynamic> data = map["dataKey"];
    //print(data[0]["name"]);
    map.forEach((k,v){
      Markalar.add(k);
    });
  }

  Future<void> modelgetir(String marka){
    Modeller.clear();
    map[marka].forEach((k,v){
      Modeller.add(k);

    });

  }

  Future<void> serigetir(String marka,String model){
    if(Seri.length>1){Seri=['Tümü'];}
    map[marka][model].forEach((k){
      Seri.add(k);
    });
  }



    



  @override
  Widget build(BuildContext context) {
    setState(() {
      loadmmodel();
    });
    return Scaffold(
      body: FiltrelemeDuzenleFul(), //Filtreleri getir
      floatingActionButton: FloatingActionButton(
        heroTag: null,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  markaBuild(context), //fab ile yeni filtre oluştur
            ),
          );
          // Add your onPressed code here!
        },
        child: Icon(Icons.add),
        backgroundColor: Constants.white,
        foregroundColor: Constants.primaryColor,
      ),
    );
  }

//markalar ekranı
  Widget markaBuild(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text(Constants.brands),
      ),
      body: ListView.builder(
          itemCount: Markalar.length,
          itemBuilder: (context, index) {
            return ListTile(
                leading: Icon(Icons.directions_car),
                title: Text(Markalar[index]),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      //Modelleri oluştur
                      builder: (context) => modelBuild(context, index, Markalar[index]),
                    ),
                  );
                });
          }),
    );
  }

//modeller ekranı
  Widget modelBuild(BuildContext context, int gelenMarkaIndex, String gelenMarka) {
    modelgetir(gelenMarka);
    return Scaffold(
      appBar: AppBar(
        title: Text(gelenMarka),
      ),
      body: ListView.builder(
        itemCount: Modeller.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(Icons.directions_car),
            title: Text(Modeller[index]),
            onTap: () {
//              bottomsheet(context, gelenMarka, Modeller[gelenMarkaIndex][index]);
              Navigator.push(context,
                MaterialPageRoute(
                  builder: (context) => seriBuild(
                    context,
                    gelenMarka,
                    Modeller[index]),
                ),
              );
            },
          );
        },
      ),
    );


  }

//Seri Ekranı
  Widget seriBuild(BuildContext context,String gelenmarka,String gelenmodel){
    serigetir(gelenmarka,gelenmodel);
    return Scaffold(
      appBar: AppBar(title: Text(gelenmodel),),
      body: ListView.builder(
      itemCount: Seri.length, 
      itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(Icons.directions_car),
            title: Text(Seri[index]),
            onTap: () {
//              bottomsheet(context, gelenMarka, Modeller[gelenMarkaIndex][index]);
              Navigator.push(context,
                MaterialPageRoute(
                  builder: (context) => FilterDetail(
                    gelenmodel,
                    Seri[index]=="Tümü" ? "" : Seri[index]),
                ),
              );
            },
          );
        },),);
  }
}
