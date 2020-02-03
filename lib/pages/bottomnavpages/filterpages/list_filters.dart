import 'package:flutter/material.dart';
import 'package:newflutter/model/filtre.dart';

class FiltrelemeDuzenle extends StatelessWidget {
  static String gelenMarka,gelenModel; static int minFiyat,maxFiyat,minYil, maxYil;
  static final List<Filtre> _lstofFiltres = Filtre.allFiltres();

  FiltrelemeDuzenle.filtreekle(String gelenMarka1,String gelenModel1, int minFiyat1, int maxFiyat1, int minYil1, int maxYil1){
    gelenMarka=gelenMarka1;gelenModel=gelenModel1;minFiyat=minFiyat1;maxFiyat=maxFiyat1;minYil=minYil1;maxYil=maxYil1;

    _lstofFiltres.add(new Filtre(marka:gelenMarka,model:gelenModel,minFiyat:minFiyat,maxFiyat:maxFiyat,minYil:minYil,maxYil:maxYil,isActive: true));

  }

FiltrelemeDuzenle(){}

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My App',
      home: Scaffold(
        appBar: AppBar(title: Text('Filtrelerim'),backgroundColor: Colors.amber,),
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
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount:FiltrelemeDuzenle._lstofFiltres.length,
      itemBuilder: (context,index){
        return ListTile(
          title: Text(
            FiltrelemeDuzenle._lstofFiltres[index].marka +" "+FiltrelemeDuzenle._lstofFiltres[index].model,//FiltrelemeDuzenle.gelenMarka
            style: TextStyle(color: Colors.black),
          ),
          subtitle: Text(
            "Fiyat="+FiltrelemeDuzenle._lstofFiltres[index].minFiyat.toString()+"-"+ FiltrelemeDuzenle._lstofFiltres[index].maxFiyat.toString()+" / "+
            "Yıl="+FiltrelemeDuzenle._lstofFiltres[index].minYil.toString()+"-"+FiltrelemeDuzenle._lstofFiltres[index].maxYil.toString(),
            style: TextStyle(color: Colors.black),
          ),
          trailing: Switch(
            value: FiltrelemeDuzenle._lstofFiltres[index].isActive,
            onChanged: (value) {
              setState(() {
                FiltrelemeDuzenle._lstofFiltres[index].isActive = value;
              });
            },
            activeTrackColor: Colors.lightGreenAccent,
            activeColor: Colors.green,
          ),
          onTap: () {
            print('horse');
          },
          selected: true,
        );
      }
      );
        
      
    ListView(
      children: <Widget>[
        //,
      ],
    );
  }
}
