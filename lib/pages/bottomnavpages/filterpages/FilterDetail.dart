import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newflutter/deneme.dart';
import 'package:newflutter/model/filtredb.dart';
import 'package:newflutter/pages/homepages.dart';
import 'package:newflutter/utils/CityTown.dart';
import 'package:newflutter/utils/const.dart';
import 'package:newflutter/utils/database_helper.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';
import 'dart:convert';

const List<String> enginepower_data = const <String>[
  "50 HP'ye kadar",
  "51-75 HP",
  "76-100 HP",
  "101-125 HP",
  "126-150 HP",
  "151-175 HP",
  "176-200 HP",
  "201-225 HP",
  "226-250 HP",
  "251-275 HP",
  "276-300 HP",
  "301-325 HP",
  "326-350 HP",
  "351-375 HP",
  "376-400 HP",
  "401-425 HP",
  "426-450 HP",
  "451-475 HP",
  "476-500 HP",
  "501-525 HP",
  "526-550 HP",
  "551-575 HP",
  "576-600 HP",
  "601 HP ve üzeri",
];
const List<String> enginevolume_data = const <String>[
  "1300 cm3'ye kadar",
  "1301-1600 cm3",
  "1601-1800 cm3",
  "1801-20000 cm3",
  "2001-2500 cm3",
  "2501-3000 cm3",
  "3001-3500 cm3",
  "3501-4000 cm3",
  "4001-4500 cm3",
  "4501-5000 cm3",
  "5001-5500 cm3",
  "5501-6000 cm3",
  "6001 cm3 ve üzeri",
];
const List<String> carsafe_data = const <String>[
  "Cabrio",
  "Coupe",
  "Hatchback 3 kapı",
  "Hatchback 5 kapı",
  "Sedan",
  "Station Wagon",
  "Crossover",
  "MPV",
  "Roadster"
];
const List<String> traction_type = const <String>[
  "Önden Çekiş",
  "Arkadan İtiş",
  "4WD(Sürekli)",
  "AWD(Elektronik)",
];
const List<String> gear_type = const <String>[
  "Manuel",
  "Yarı Otomatik",
  "Otomatik",
];
const List<String> cars_color = const <String>[
  "Bej",
  "Beyaz",
  "Bordo",
  "Füme",
  "Gri",
  "Gümüş Gri",
  "Kahverengi",
  "Kırmızı",
  "Lacivert",
  "Mavi",
  "Mor",
  "Pembe",
  "Sarı",
  "Siyah",
  "Şampanya",
  "Turkuaz",
  "Turuncu",
  "Yeşil",
];

class FilterDetail extends StatefulWidget {
  String gelenMarka;
  String gelenModel;

  FilterDetail(this.gelenMarka, this.gelenModel);

  @override
  _FilterDetailState createState() => _FilterDetailState();
}

class _FilterDetailState extends State<FilterDetail> {
  final minFiyatController = TextEditingController();
  final maxFiyatController = TextEditingController();
  final minTarihController = TextEditingController();
  final maxTarihController = TextEditingController();
  static DatabaseHelper databaseHelper = DatabaseHelper();
  int minFiyat = 0;
  int maxFiyat = 1000000;
  int minYil = 1900;
  int maxYil = 3000;

  final List<DropdownMenuItem> city_items = [];
  final List<DropdownMenuItem> town_items = [];
  String city_text;
  String town_text;
  String town_text1="1";
  var data = ['Benzinli', 'Dizel', 'LPG'];
  var selected = [];
  bool selectedicon = false;
  int _selectedenginepowerIndex = 0;
  int _selectedenginevolumeIndex = 0;
  int _selectedcarsafeIndex = 0;
  int _selectedtractiontypeIndex = 0;
  int _selectedgeartypeIndex = 0;
  int _selectedcarscolorsIndex = 0;

  Future<List<City>> a;
  List<City> city_list;
  int id;
  City city;
  Future<void> loadStudent() async {
    String jsonString = await CityTown.loadAsset();
    final jsonResponse = json.decode(jsonString);
    CityList city = new CityList.fromJson(jsonResponse);
    city_list = city.citys;
    for (int i = 0; i < city_list.length; i++) {
      city_items.add(DropdownMenuItem(
        child: Text(city_list[i].name),
        value: [city_list[i].name,city_list[i].id],
      ));
    }

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      loadStudent();
    });
  }

  void AddTownList() async{
    String jsonString = await CityTown.loadAsset();
    final jsonResponse = json.decode(jsonString);
    CityList city = new CityList.fromJson(jsonResponse);
    city_list = city.citys;
    print(town_text1);
    for (int k = 0; k < city_list[int.parse(town_text1)-1].townList.length; k++) {
      town_items.add(DropdownMenuItem(
        child: Text(city_list[int.parse(town_text1)-1].townList[k]),
        value: city_list[int.parse(town_text1)-1].townList[k],
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.grey200,
      appBar: AppBar(
        title: Center(
          child: Text(
            Constants.dofilter,
            textAlign: TextAlign.justify,
          ),
        ),
        backgroundColor: Constants.primaryColor,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.send),
            onPressed: () {
              if (minFiyatController.text == "") {
                minFiyat = 0;
              } else {
                minFiyat = int.parse(minFiyatController.text);
              }
              if (maxFiyatController.text == "") {
                maxFiyat = 10000000;
              } else {
                maxFiyat = int.parse(maxFiyatController.text);
              }
              if (minTarihController.text == "") {
                minYil = 1900;
              } else {
                minYil = int.parse(minTarihController.text);
              }
              if (maxTarihController.text == "") {
                maxYil = 2030;
              } else {
                maxYil = int.parse(maxTarihController.text);
              }

              databaseHelper.insertFiltre(new Filtredb(widget.gelenMarka,
                  widget.gelenModel, minFiyat, maxFiyat, minYil, maxYil, 1));

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HomePage.navigate(2, null),
                ),
              );
            },
          )
        ],
      ),
      body: SingleChildScrollView(
          child: Container(
        child: Column(
          children: <Widget>[
            Container(
              child: Column(
                children: <Widget>[
                  Container(
                    alignment: Alignment.topLeft,
                    margin:
                        EdgeInsets.only(left: 10.0, top: 20.0, bottom: 10.0),
                    child: Text(Constants.brandsmodels),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: new Container(
                      width: 500.0,
                      margin: EdgeInsets.only(left: 10.0, right: 10.0),
                      padding: new EdgeInsets.all(8.0),
                      color: Constants.white,
                      child: new Row(
                        children: [
                          Text(widget.gelenMarka + "/" + widget.gelenModel),
                          //filtreleme detaydan gelen deger boş ise "Marka seciniz" dolu ise kendisine
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Icon(Icons.chevron_right),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  //Fiyat Aralığı
                  Container(
                    margin: EdgeInsets.only(left: 10.0, top: 10.0),
                    child: Text(Constants.pricerange),
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        width: 160.0,
                        height: 40.0,
                        margin: EdgeInsets.all(10.0),
                        child: TextField(
                          controller: minFiyatController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: Constants.minprice,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Container(
                              width: 160.0,
                              height: 40.0,
                              margin: EdgeInsets.only(right: 10.0),
                              child: TextField(
                                controller: maxFiyatController,
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'En Fazla (TL)',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  //Km Aralıgı
                  Container(
                    margin: EdgeInsets.only(left: 10.0, top: 10.0),
                    child: Text(Constants.kmrange),
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        width: 160.0,
                        height: 40.0,
                        margin: EdgeInsets.all(10.0),
                        child: TextField(
                          controller: minFiyatController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: Constants.minkm,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Container(
                              width: 160.0,
                              height: 40.0,
                              margin: EdgeInsets.only(right: 10.0),
                              child: TextField(
                                controller: maxFiyatController,
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'En Fazla (Km)',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  //Yakıt Tipi
                  Container(
                    margin: EdgeInsets.only(left: 10.0, top: 10.0),
                    child: Text("Yakıt Tipi"),
                  ),
                  Container(
                    height: 100,
                    margin: EdgeInsets.only(
                      left: 10.0,
                    ),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: data.length,
                      itemBuilder: (BuildContext context, int index) => Center(
                        child: Container(
                          margin: EdgeInsets.only(right: 10.0),
                          child: FilterChip(
                            label: Text(data[index]),
                            onSelected: (bool value) {
                              if (selected.contains(index)) {
                                selected.remove(index);
                              } else {
                                selected.add(index);
                              }
                              setState(() {});
                            },
                            checkmarkColor: Colors.white,
                            selected: selected.contains(index),
                            selectedColor: Colors.green,
                            labelStyle: TextStyle(
                              color: Colors.white,
                            ),
                            backgroundColor: Colors.deepOrange,
                          ),
                        ),
                      ),
                    ),
                  ),
                  //Vites Türü
                  Container(
                    margin:
                        EdgeInsets.only(left: 10.0, top: 10.0, bottom: 10.0),
                    child: Text("Vites Türü"),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) {
                              return CupertinoPageScaffold(
                                navigationBar: CupertinoNavigationBar(
                                  backgroundColor: Constants.primaryColor,
                                  middle: Text(
                                    "Vites Türü",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  leading: GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Icon(
                                        Icons.arrow_back,
                                        color: Colors.white,
                                      )),
                                  trailing: GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Icon(
                                        Icons.send,
                                        color: Colors.white,
                                      )),
                                ),
                                child: Container(
                                  height: 200.0,
                                  child: CupertinoPicker(
                                      itemExtent: 32.0,
                                      onSelectedItemChanged: (int index) {
                                        setState(() {
                                          _selectedgeartypeIndex = index;
                                        });
                                      },
                                      children: new List<Widget>.generate(
                                          gear_type.length, (int index) {
                                        return new Center(
                                          child: new Text(gear_type[index]),
                                        );
                                      })),
                                ),
                              );
                            });
                      });
                    },
                    child: Container(
                        width: 500.0,
                        margin: EdgeInsets.only(left: 10.0, right: 10.0),
                        padding: new EdgeInsets.all(8.0),
                        color: Constants.white,
                        child: new Row(
                          children: [
                            Text(gear_type[_selectedgeartypeIndex]), //filtreleme detaydan gelen deger boş ise "Marka seciniz" dolu ise kendisine
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  Icon(Icons.chevron_right),
                                ],
                              ),
                            ),
                          ],
                        )),
                  ),
                  //Motor Gücü
                  Container(
                    margin:
                        EdgeInsets.only(left: 10.0, top: 10.0, bottom: 10.0),
                    child: Text("Motor Gücü"),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) {
                              return CupertinoPageScaffold(
                                navigationBar: CupertinoNavigationBar(
                                  backgroundColor: Constants.primaryColor,
                                  middle: Text(
                                    "Bitirilme Zamanı",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  leading: GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Icon(
                                        Icons.arrow_back,
                                        color: Colors.white,
                                      )),
                                  trailing: GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Icon(
                                        Icons.send,
                                        color: Colors.white,
                                      )),
                                ),
                                child: Container(
                                  height: 200.0,
                                  child: CupertinoPicker(
                                      itemExtent: 32.0,
                                      onSelectedItemChanged: (int index) {
                                        setState(() {
                                          _selectedenginepowerIndex = index;
                                        });
                                      },
                                      children: new List<Widget>.generate(
                                          enginepower_data.length, (int index) {
                                        return new Center(
                                          child:
                                              new Text(enginepower_data[index]),
                                        );
                                      })),
                                ),
                              );
                            });
                      });
                    },
                    child: Container(
                        width: 500.0,
                        margin: EdgeInsets.only(left: 10.0, right: 10.0),
                        padding: new EdgeInsets.all(8.0),
                        color: Constants.white,
                        child: new Row(
                          children: [
                            Text(enginepower_data[_selectedenginepowerIndex]),
                            //filtreleme detaydan gelen deger boş ise "Marka seciniz" dolu ise kendisine
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  Icon(Icons.chevron_right),
                                ],
                              ),
                            ),
                          ],
                        )),
                  ),
                  //Motor Hacmi
                  Container(
                    margin:
                        EdgeInsets.only(left: 10.0, top: 10.0, bottom: 10.0),
                    child: Text("Motor Hacmi"),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) {
                              return CupertinoPageScaffold(
                                navigationBar: CupertinoNavigationBar(
                                  backgroundColor: Constants.primaryColor,
                                  middle: Text(
                                    "Bitirilme Zamanı",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  leading: GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Icon(
                                        Icons.arrow_back,
                                        color: Colors.white,
                                      )),
                                  trailing: GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Icon(
                                        Icons.send,
                                        color: Colors.white,
                                      )),
                                ),
                                child: Container(
                                  height: 200.0,
                                  child: CupertinoPicker(
                                      itemExtent: 32.0,
                                      onSelectedItemChanged: (int index) {
                                        setState(() {
                                          _selectedenginevolumeIndex = index;
                                        });
                                      },
                                      children: new List<Widget>.generate(
                                          enginevolume_data.length,
                                          (int index) {
                                        return new Center(
                                          child: new Text(
                                              enginevolume_data[index]),
                                        );
                                      })),
                                ),
                              );
                            });
                      });
                    },
                    child: Container(
                        width: 500.0,
                        margin: EdgeInsets.only(left: 10.0, right: 10.0),
                        padding: new EdgeInsets.all(8.0),
                        color: Constants.white,
                        child: new Row(
                          children: [
                            Text(enginevolume_data[_selectedenginevolumeIndex]),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  Icon(Icons.chevron_right),
                                ],
                              ),
                            ),
                          ],
                        )),
                  ),
                  //Kasa tipi
                  Container(
                    margin:
                        EdgeInsets.only(left: 10.0, top: 10.0, bottom: 10.0),
                    child: Text("Kasa Tipi"),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) {
                              return CupertinoPageScaffold(
                                navigationBar: CupertinoNavigationBar(
                                  backgroundColor: Constants.primaryColor,
                                  middle: Text(
                                    "Kasa Tipi",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  leading: GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Icon(
                                        Icons.arrow_back,
                                        color: Colors.white,
                                      )),
                                  trailing: GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Icon(
                                        Icons.send,
                                        color: Colors.white,
                                      )),
                                ),
                                child: Container(
                                  height: 200.0,
                                  child: CupertinoPicker(
                                      itemExtent: 32.0,
                                      onSelectedItemChanged: (int index) {
                                        setState(() {
                                          _selectedcarsafeIndex = index;
                                        });
                                      },
                                      children: new List<Widget>.generate(
                                          carsafe_data.length, (int index) {
                                        return new Center(
                                          child: new Text(carsafe_data[index]),
                                        );
                                      })),
                                ),
                              );
                            });
                      });
                    },
                    child: Container(
                        width: 500.0,
                        margin: EdgeInsets.only(left: 10.0, right: 10.0),
                        padding: new EdgeInsets.all(8.0),
                        color: Constants.white,
                        child: new Row(
                          children: [
                            Text(carsafe_data[_selectedcarsafeIndex]),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  Icon(Icons.chevron_right),
                                ],
                              ),
                            ),
                          ],
                        )),
                  ),
                  //Çekiş Tipi
                  Container(
                    margin:
                        EdgeInsets.only(left: 10.0, top: 10.0, bottom: 10.0),
                    child: Text("Çekiş Tipi"),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) {
                              return CupertinoPageScaffold(
                                navigationBar: CupertinoNavigationBar(
                                  backgroundColor: Constants.primaryColor,
                                  middle: Text(
                                    "Çekiş Tipi",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  leading: GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Icon(
                                        Icons.arrow_back,
                                        color: Colors.white,
                                      )),
                                  trailing: GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Icon(
                                        Icons.send,
                                        color: Colors.white,
                                      )),
                                ),
                                child: Container(
                                  height: 200.0,
                                  child: CupertinoPicker(
                                      itemExtent: 32.0,
                                      onSelectedItemChanged: (int index) {
                                        setState(() {
                                          _selectedtractiontypeIndex = index;
                                        });
                                      },
                                      children: new List<Widget>.generate(
                                          traction_type.length, (int index) {
                                        return new Center(
                                          child: new Text(traction_type[index]),
                                        );
                                      })),
                                ),
                              );
                            });
                      });
                    },
                    child: Container(
                        width: 500.0,
                        margin: EdgeInsets.only(left: 10.0, right: 10.0),
                        padding: new EdgeInsets.all(8.0),
                        color: Constants.white,
                        child: new Row(
                          children: [
                            Text(traction_type[_selectedtractiontypeIndex]),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  Icon(Icons.chevron_right),
                                ],
                              ),
                            ),
                          ],
                        )),
                  ),
                  //Renk
                  Container(
                    margin:
                        EdgeInsets.only(left: 10.0, top: 10.0, bottom: 10.0),
                    child: Text("Renk"),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) {
                              return CupertinoPageScaffold(
                                navigationBar: CupertinoNavigationBar(
                                  backgroundColor: Constants.primaryColor,
                                  middle: Text(
                                    "Renk",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  leading: GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Icon(
                                        Icons.arrow_back,
                                        color: Colors.white,
                                      )),
                                  trailing: GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Icon(
                                        Icons.send,
                                        color: Colors.white,
                                      )),
                                ),
                                child: Container(
                                  height: 200.0,
                                  child: CupertinoPicker(
                                      itemExtent: 32.0,
                                      onSelectedItemChanged: (int index) {
                                        setState(() {
                                          _selectedcarscolorsIndex = index;
                                        });
                                      },
                                      children: new List<Widget>.generate(
                                          cars_color.length, (int index) {
                                        return new Center(
                                          child: new Text(cars_color[index]),
                                        );
                                      })),
                                ),
                              );
                            });
                      });
                    },
                    child: Container(
                        width: 500.0,
                        margin: EdgeInsets.only(left: 10.0, right: 10.0),
                        padding: new EdgeInsets.all(8.0),
                        color: Constants.white,
                        child: new Row(
                          children: [
                            Text(cars_color[_selectedcarscolorsIndex]),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  Icon(Icons.chevron_right),
                                ],
                              ),
                            ),
                          ],
                        )),
                  ),
                  //Yıl Aralığı
                  Container(
                    margin: EdgeInsets.only(left: 10.0, top: 10.0),
                    child: Text(Constants.yearange),
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        width: 160.0,
                        height: 40.0,
                        margin: EdgeInsets.all(10.0),
                        child: TextField(
                          controller: minTarihController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: Constants.minimum,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Container(
                              width: 160.0,
                              height: 40.0,
                              margin: EdgeInsets.only(right: 10.0),
                              child: TextField(
                                controller: maxTarihController,
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'En Fazla',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  //Lokasyon
                  Container(
                    alignment: Alignment.topLeft,
                    margin: EdgeInsets.all(10.0),
                    child: Text(Constants.location),
                  ),
                   new Container(
                      width: 500.0,
                      margin: EdgeInsets.only(left: 10.0, right: 10.0),
                      padding: new EdgeInsets.all(8.0),
                      color: Constants.white,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Card(
                            elevation: 3.0,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(5.0),
                                ),
                              ),
                              child: SearchableDropdown(
                                closeButton: "Vazgeç",
                                items: city_items,
                                value:city_text,
                                hint: Text('İl Seç'),
                                searchHint: new Text(
                                  'İl Seç',
                                  style: new TextStyle(fontSize: 20),
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    city_text = value[0];
                                    town_text1=value[1];
                                    AddTownList();
                                    town_items.clear();
                                  });
                                },
                                isExpanded: true,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 8.0,
                          ),
                          Visibility(
                            visible: city_text == null ?false:true,
                            child: Card(
                              elevation: 3.0,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(5.0),
                                  ),
                                ),
                                child: SearchableDropdown(
                                  closeButton: "Vazgeç",
                                  items: town_items,
                                  value: town_text,
                                  hint: Text('İlçe Seç'),
                                  searchHint: new Text(
                                    'İlçe Seç',
                                    style: new TextStyle(fontSize: 20),
                                  ),
                                  onChanged: (value) {
                                    setState(() {
                                      town_text = value;
                                    });
                                  },
                                  isExpanded: true,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}
