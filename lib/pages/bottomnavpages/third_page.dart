import 'package:flutter/material.dart';
import 'package:newflutter/pages/bottomnavpages/filterpages/list_filters.dart';


class ThirdPage extends StatelessWidget {
  const ThirdPage({Key key}) : super(key: key);

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FiltrelemeDuzenle(),//Filtreleri getir

      floatingActionButton: FloatingActionButton(
      onPressed: () {
        Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => markaBuild(context),//fab ile yeni filtre oluştur
                  ),
            );  
        // Add your onPressed code here!
      },
      child: Icon(Icons.add),
      backgroundColor: Colors.white,
      foregroundColor: Colors.amber,
    ),
    );
  }

//markalar ekranı
  Widget markaBuild(BuildContext context){
    final List<String> Markalar=['Audi','Mercedes','BMW','Ford','Volkswagen'];
    return Scaffold(
      appBar: AppBar(
        title: Text("Markalar"),
      ),
      body: ListView.builder(
        itemCount: Markalar.length,
        itemBuilder: (context, index) {
        return ListTile(
          leading: Icon(Icons.directions_car),
          title: Text(Markalar[index]),

          onTap:(){Navigator.push(
              context,
              MaterialPageRoute(         //Modelleri oluştur
                  builder: (context) => modelBuild(context, index,Markalar[index]),
                  ),
            );
            
            }
        );
      }),
    );
    
     

  }

//modeller ekranı
  Widget modelBuild(BuildContext context,int gelenMarkaIndex,String gelenMarka){

    List<List<String>> Modeller=[
    ["A2","A3","A4"],
    ["A","C","S"],
    ["1","2","3"],
    ["Focus","Fiesta","Mondeo"],
    ["Golf","Polo","Scirocco"]];
    return Scaffold(
      appBar: AppBar(
        title: Text(gelenMarka),
      ),
      body:
       ListView.builder(
      itemCount: Modeller[gelenMarkaIndex].length,
      itemBuilder: (context, index){
        return ListTile(
          leading:Icon(Icons.directions_car),
          title:Text(Modeller[gelenMarkaIndex][index]),
          onTap: (){bottomsheet(context,gelenMarka,Modeller[gelenMarkaIndex][index]);},
        );
      },
    ),
    ); 
  }

//alt filtre menüsü
void bottomsheet(context,String gelenMarka,String gelenModel) {
  final minFiyatController = TextEditingController();
  final maxFiyatController = TextEditingController();
  final minTarihController = TextEditingController();
  final maxTarihController = TextEditingController();
  

  int minFiyat=0;
  int maxFiyat=1000000;
  int minYil=1900;
  int maxYil=3000;
  showModalBottomSheet(
      context: context,
      backgroundColor: Colors.grey[200],
      builder: (BuildContext bc) {
        return Scaffold(
          backgroundColor: Colors.grey[200],
          appBar: AppBar(
            title: Center(child: Text(
              "Filtreleme Yapınız",
              textAlign: TextAlign.justify,
            ),),
            
            
            backgroundColor: Colors.amber,
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.send),
                onPressed: () {
                  if(minFiyatController.text==""){minFiyat=0;}else{minFiyat=int.parse(minFiyatController.text);}
                  if(maxFiyatController.text==""){maxFiyat=10000000;}else{maxFiyat=int.parse(maxFiyatController.text);}
                  if(minTarihController.text==""){minYil=1900;}else{minYil=int.parse(minTarihController.text);}
                  if(maxTarihController.text==""){maxYil=2030;}else{maxYil=int.parse(maxTarihController.text);}

                  Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => FiltrelemeDuzenle.filtreekle(gelenMarka,gelenModel,minFiyat,maxFiyat,minYil,maxYil),
                  ),
            );

                },
              )
            ],
          ),
          body: SingleChildScrollView(
      child: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.topLeft,
                      margin: EdgeInsets.only(left: 10.0,top: 20.0,bottom: 10.0),
                      child: Text("Marka/Model"),
                    ),

                    GestureDetector(
                      onTap:(){Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => markaBuild(context)),
            );},
                      child:new Container(
                      width: 500.0,
                      margin: EdgeInsets.only(left: 10.0, right: 10.0),
                      padding: new EdgeInsets.all(8.0),
                      color: Colors.white,
                      child: new Row(
                        children: [
                          Text(
                              gelenMarka+"/"+gelenModel), //filtreleme detaydan gelen deger boş ise "Marka seciniz" dolu ise kendisine
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
                    ),),

                    
                    //Fiyat Aralığı
                    Container(
                      margin: EdgeInsets.only(left: 10.0, top: 10.0),
                      child: Text("Fiyat Aralığı"),
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
                              labelText: 'En Az (TL)',
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

                    //Yıl Aralığı
                    Container(
                      margin: EdgeInsets.only(left: 10.0, top: 10.0),
                      child: Text("Yıl Aralığı"),
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
                              labelText: 'En Az',
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
                  ],
                ),
              ),
              //Lokasyon
              Container(
                alignment: Alignment.topLeft,
                margin: EdgeInsets.all(10.0),
                child: Text("Lokasyon"),
              ),
              new Container(
                width: 500.0,
                margin: EdgeInsets.only(left: 10.0, right: 10.0),
                padding: new EdgeInsets.all(8.0),
                color: Colors.white,
                child: new Row(
                  children: [
                    Text(
                        "Lokasyon Seçiniz"), //filtreleme detaydan gelen deger boş ise "Marka seciniz" dolu ise kendisine
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
              
            ],
          )
        ],
      ),
    ),
        );
      });
}



}