import 'package:flutter/material.dart';
import 'package:newflutter/pages/profilenavpages/settings_page.dart';
import 'package:newflutter/pages/profilenavpages/support_page.dart';
import 'package:newflutter/pages/profilenavpages/aboutus_page.dart';
import 'package:newflutter/pages/profilenavpages/deviceinfo_page.dart';



class FifthPage extends StatelessWidget {
  const FifthPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //final foos = 'Genel';
    final title = 'Profil';

    return MaterialApp(
        title: title,
        home: Scaffold(
          appBar: AppBar(
            title: Text(title),
            backgroundColor: Colors.amber,
          ),
          body: profileCard(context),
        ));
  }

  Widget profileCard(BuildContext context) {
    
    return new Container(
      width: MediaQuery.of(context).size.width,
      height:MediaQuery.of(context).size.height *0.9 ,
      //padding: EdgeInsets.fromLTRB(10.0,15.0,10.0,0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        color: Colors.white,
        elevation: 10,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            profileInfos(context),
            
            Divider(color: Colors.black,),
            ListTile(
            leading:Text('') ,
            title: Text('Genel',style: TextStyle(fontSize: 18),),
            ),
            Divider(color: Colors.black,),

            ListTile(
            leading: Icon(Icons.settings),
            title: Text('Ayarlar'),
            onTap:(){
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => SettingsPage(),
                  ),
          );}),
          ListTile(
            leading: Icon(Icons.help),
            title: Text('Destek Al'),
            onTap:(){
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => SupportPage(),
                  ),
          );}
          ),
          ListTile(
            leading: Icon(Icons.description),
            title: Text('Hakkımızda'),
            onTap:(){
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AboutusPage(),
                  ),
          );}
          ),
          ListTile(
            leading: Icon(Icons.info),
            title: Text('Cihaz Bilgisi'),
            onTap:(){
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DeviceinfoPage(),
                  ),
          );}
          ),
          ListTile(
            leading: Icon(
              Icons.power_settings_new,
              color: Colors.red,
            ),
            title: Text('Çıkış Yap'),
            
          ),
          
          ],
        ),
      ),
    );
  }

  Widget profileInfos(BuildContext context){
    
      return  Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 10.0, right: 10.0,top: 15.0,bottom: 10.0),
                  child: Image.asset(
                    "assets/cm4.jpeg",
                    fit: BoxFit.cover,
                    width: 100.0,
                    height: 100.0,
                  ),
                  
                ),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "Jane Doe",
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 5.0),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "jane@alganostest.com",
                            style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 20.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          InkWell(
                            onTap: (){
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (BuildContext context){
                                    return new Container();//SplashScreen();
                                  },
                                ),
                              );
                            },
                            child: Text("Gold Paket",
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w400,
                                color: Theme.of(context).accentColor,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),

                    ],
                  ),
                  flex: 3,
                ),
              ],
            );
  }

}
//değişiklik yaptım
