import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:newflutter/model/cardb.dart';
import 'package:newflutter/model/filtredb.dart';
import 'package:newflutter/utils/database_helper.dart';
import 'package:sqflite/sqflite.dart';

class filterhandler {
  static DatabaseHelper databaseHelper = DatabaseHelper();
  static List<Filtredb> filtreList;

  

  static Future<List<Cardb>> getData(String fbasekey) async {
  var carList = new List<Cardb>();
  //filtreList=await FiltrelemeDuzenleState.getfiltreler();
  //if(filtreList==null){updateFiltre();}
  updateFiltre();
  
    DatabaseReference ref = FirebaseDatabase.instance.reference();
    String model, title, year, price, location, image,logo,link_detay,km,hp,fuel,color,transmission;
    await ref.child('cars').once().then((DataSnapshot snapshot){
      var data1=snapshot.value;
      //var  key1= snapshot.value.keys;
      //for (var keydeger in key1){
      //var bilgi = data1[keydeger];
      print("bildirim geldi !");
      for (var arabam in data1[fbasekey]){
            model = arabam[0].toString();
            title = arabam[1].toString();
            year = arabam[2].toString();
            price = arabam[3].toString();
            String nextprice=price.substring(0,price.length-3);
            String clearprice = nextprice.replaceAll(".","");
            double dblprice = double.parse(nextprice);
            location = arabam[4].toString();
            image = arabam[5].toString();
            link_detay = arabam[6].toString();
            km = arabam[7].toString();
            String clearkm=km.substring(0,km.length-3);
            hp = arabam[8].toString();
            String clearhp = hp.substring(0,hp.length-3),
            fuel = arabam[9].toString();
            transmission = arabam[10].toString();
            color = arabam[11].toString();
            logo = arabam[12].toString();

            for(var myfiltre in filtreList)
            {
            bool modelfilter = model.contains(myfiltre.marka + " " + myfiltre.model);
            bool yearfilter  = (int.parse(year) >= myfiltre.minYil) && (int.parse(year)<= myfiltre.maxYil); 
            bool pricefilter = (int.parse(clearprice)>=myfiltre.minFiyat) && (int.parse(clearprice)<=myfiltre.maxFiyat);
            bool kmfilter =(int.parse(clearkm)>=myfiltre.colminKm) && (int.parse(clearkm)<=myfiltre.colmaxKm);
            

            

            if((modelfilter&&yearfilter)&&(pricefilter&&kmfilter)){
              bool transfilter= (myfiltre.colTransmission.contains("Tümü")) ? true : transmission.contains(myfiltre.colTransmission);
              bool fuelfilter = myfiltre.colFuel.contains("Tümü") ? true : myfiltre.colFuel.contains(fuel);
              bool colorfilter = myfiltre.color.contains("Tümü") ? true : myfiltre.color.contains(color);
              bool locatfilter = myfiltre.location.contains("Tümü") ? true : location.contains(myfiltre.location);
              if((transfilter&&fuelfilter)&&(colorfilter&& locatfilter)){
                bool hpfilter=true;
                if(!myfiltre.hp.contains("Tümü")){
                  String minhp=myfiltre.hp.split("-")[0];
                 String maxhp = myfiltre.hp.split("-")[1].substring(0,myfiltre.hp.split("-")[1].length-3);
                 hpfilter = (int.parse(clearhp)>=int.parse(minhp)) && (int.parse(clearhp)<=int.parse(maxhp));
                }
                
                if(hpfilter){
              print("KM $km");
              print("HP $hp");
              print("FUEL $fuel");
              print("TRANSMİSSİON $transmission");
              print("COLOR $color");
              carList.add(new Cardb(image, dblprice, title, location, model, year, logo,link_detay,km,fuel,transmission,hp,color));
              break;
                  }}}
            }
      }
    });
    return carList;
  }

  static void updateFiltre() async{
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {
      Future<List<Filtredb>> filtreListFuture = databaseHelper.getActiveFiltreList();
      filtreListFuture.then((_lstofFiltress) {
         filtreList  = _lstofFiltress;
      });
    });
}  
  }

  