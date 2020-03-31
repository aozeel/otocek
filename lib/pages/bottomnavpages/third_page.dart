import 'package:flutter/material.dart';
import 'package:newflutter/model/filtredb.dart';
import 'package:newflutter/pages/bottomnavpages/filterpages/FilterDetail.dart';
import 'package:newflutter/pages/bottomnavpages/filterpages/list_filters.dart';
import 'package:newflutter/pages/homepages.dart';
import 'package:newflutter/utils/const.dart';
import 'package:newflutter/utils/database_helper.dart';

class ThirdPage extends StatelessWidget {
  const ThirdPage({Key key}) : super(key: key);

  static DatabaseHelper databaseHelper = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
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
    final List<String> Markalar = [
      'Audi',
      'Mercedes - Benz',
      'BMW',
      'Ford',
      'Volkswagen'
    ];
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
    List<List<String>> Modeller = [
      ["A2", "A3", "A4"],
      ["A", "C", "S", "E"],
      ["1", "2", "3"],
      ["Focus", "Fiesta", "Mondeo"],
      ["Golf", "Polo", "Scirocco", "Jetta", "Passat"]
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text(gelenMarka),
      ),
      body: ListView.builder(
        itemCount: Modeller[gelenMarkaIndex].length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(Icons.directions_car),
            title: Text(Modeller[gelenMarkaIndex][index]),
            onTap: () {
//              bottomsheet(context, gelenMarka, Modeller[gelenMarkaIndex][index]);
              Navigator.push(context,
                MaterialPageRoute(
                  builder: (context) => FilterDetail(gelenMarka,Modeller[gelenMarkaIndex][index]),
                ),
              );
            },
          );
        },
      ),
    );


  }
}
