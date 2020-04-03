import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;

class CityTown {

 static Future<String> loadAsset() async {
    return await rootBundle.loadString('assets/il_ilce.json');
  }
}

class CityList{
  final List<City> citys;

  CityList({this.citys});
  factory CityList.fromJson(Map<String,dynamic> json){
    var list=json['cityDetail'] as List;
    List<City> cityList=list.map((i) => City.fromJson(i)).toList();

    return CityList(
      citys: cityList,
    );
  }
}

class City{
  final String name;
  final String id;
  final List<String> townList;
  const City({this.name, this.id,this.townList});

  factory City.fromJson(Map<String, dynamic> parsedJson){
    var streetsFromJson  = parsedJson['ilceleri'];
    //print(streetsFromJson.runtimeType);
    // List<String> streetsList = new List<String>.from(streetsFromJson);
    List<String> townlist = streetsFromJson.cast<String>();

    return City(
        name: parsedJson['name'],
        id : parsedJson['id'],
        townList:townlist
    );
  }
}




