import 'package:flutter/material.dart';
import 'package:newflutter/model/city.dart';

class FirstPage extends StatelessWidget {
   FirstPage({Key key}) : super(key: key);
  final List<City> _allCities = City.allCities();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: new AppBar(

          title: new Text(
            "ArabaCek",
            style: new TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.black87),
          ),
        ),
        body: new Padding(
            padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
            child: getHomePageBody(context)),
            
         );
  }
  getHomePageBody(BuildContext context) {
    return ListView.builder(
      itemCount: _allCities.length,
      itemBuilder: _getItemUI,
      padding: EdgeInsets.all(0.0),
    );
  }

  Widget _getItemUI(BuildContext context, int index) {
    return new Container(
          margin:EdgeInsets.all(8.0),
          child: Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8.0))),
            child: InkWell(
              onTap: () => print("ciao"),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,  // add this
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8.0),
                      topRight: Radius.circular(8.0),
                    ),
                    child: Image.asset(
                        "assets/" + _allCities[index].image,
                       // width: 300,
                        height: 200,
                        fit:BoxFit.fill

                    ),
                  ),
                  ListTile(
                    
                    title: Text(_allCities[index].name),
                    subtitle: Text(_allCities[index].population),
                  ),
                  Row(
                   // mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,

                    children: [
                      Text(_allCities[index].country),
                      Text("2005"),
                              ],
                              
  
)

                ],
              ),
            ),
          ),
        );
  }
}