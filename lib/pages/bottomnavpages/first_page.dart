import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FirstPage extends StatelessWidget {
  FirstPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.amber,
    ));
    return Scaffold(
      body: _buildListView(),
    );
  }

  Widget _buildListView() {
    return Container(
      margin: EdgeInsets.only(top: 40.0),
      child: ListView.builder(
        padding: const EdgeInsets.all(5.0),
        itemCount: 10,
        itemBuilder: (context, index) {
          return _buildImageColumn();
        },
      ),
    );
  }

  Widget _buildImageColumn() => Container(
        decoration: BoxDecoration(color: Colors.blue[50]),
        margin: const EdgeInsets.all(8),
        child: Card(
          child: Column(
            children: <Widget>[
              image(),
              ilanmodel,
              ilanicerik,
            ],
          ),
        ),
      );

  Widget image() => Container(
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
                  image: NetworkImage(
                      "https://image5.sahibinden.com/photos/27/53/93/thmb_769275393o5b.jpg"),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(4),
              color: Colors.amber,
              child: Text(
                "38.500 TL",
                style: TextStyle(color: Colors.white),
              ),
            ),

            //sağ ve solda text
            // new Positioned(
            //   left: 0.0,
            //   bottom: 0.0,
            //   child :Container(
            //   padding: EdgeInsets.all(5),
            //   color: Colors.amber,
            //   child: Text(
            //     "78.000 KM",
            //     style: TextStyle(color: Colors.white),
            //   ),
            // ),
            // ),
            // new Positioned(
            //   right: 0.0,
            //   bottom: 0.0,
            //   child :Container(
            //   padding: EdgeInsets.all(5),
            //   color: Colors.amber,
            //   child: Text(
            //     "38.500 TL",
            //     style: TextStyle(color: Colors.white),
            //   ),
            // ),
            // ),
          ],
        ),
      );

  Widget ilanicerik = Container(
    padding: const EdgeInsets.all(8),
    child: Row(
      children: <Widget>[
        Container(
          margin: const EdgeInsets.only(right: 10.0),
          child: Text(
            'Audi A4 A4 Sedan 2.0 TDI',
            style: TextStyle(color: Colors.white),
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.amber,
            boxShadow: [
              BoxShadow(color: Colors.amber, spreadRadius: 3),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(right: 10.0),
          child: Text(
            '2006',
            style: TextStyle(color: Colors.white),
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.amber,
            boxShadow: [
              BoxShadow(color: Colors.amber, spreadRadius: 3),
            ],
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Container(
                child: Image.asset("assets/arabam.png", fit: BoxFit.fill),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget ilanmodel = Container(
  margin: const EdgeInsets.only(top: 8.0, left: 8.0),
  child: Row(
    children: <Widget>[
      // Container(
      //   padding: const EdgeInsets.all(8),
      //   child: Text(
      //     'HATASIZ BOYASIZ 2016 A4 2.0..',
      //     style: TextStyle(
      //       fontSize: 14,
      //       fontWeight: FontWeight.bold,
      //     ),
      //   ),
      // ),
      Flexible(
        flex: 2,
        child: RichText(
          overflow: TextOverflow.ellipsis,
          strutStyle: StrutStyle(fontSize: 14.0),
          text: TextSpan(
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              text:
                  "HATASIZ BOYASIZ 2016 A4 2.0 TDI DESİGN SUNROOF LED ZENON 190HP"),
        ),
      ),

      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Row(
              children: <Widget>[
                new IconTheme(
                  data: new IconThemeData(color: Colors.grey[300]),
                  child: new Icon(Icons.location_on),
                ),
                Container(
                  padding: const EdgeInsets.only(right: 8, top: 8, bottom: 8),
                  child: Text(
                    "Niğde Bor",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    ],
  ),
);
