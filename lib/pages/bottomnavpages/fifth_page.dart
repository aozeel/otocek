import 'dart:io';
import 'package:flutter/material.dart';
import 'package:newflutter/model/user.dart';
import 'package:newflutter/pages/profilenavpages/settings_page.dart';
import 'package:newflutter/pages/profilenavpages/support_page.dart';
import 'package:newflutter/pages/profilenavpages/aboutus_page.dart';
import 'package:newflutter/pages/profilenavpages/deviceinfo_page.dart';
import 'package:newflutter/services/auth_base.dart';
import 'package:newflutter/utils/const.dart';
import 'package:newflutter/viewmodel/usermodel.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
class FifthPage extends StatefulWidget{
  final AutBase authService;
  final Function onSignOut;
  const FifthPage({Key key,this.authService,@required this.onSignOut}) : super(key: key);
  @override
  FifthPageState createState() => FifthPageState();
}

class FifthPageState extends State<FifthPage> {

  UserModel usermodel;
  String profilphoto;


  @override
  Widget build(BuildContext context) {
   usermodel=Provider.of<UserModel>(context,listen: false);
   profilphoto=usermodel.user.profilurl;
    final title = Constants.profil;
    return Scaffold(
      
          body:SafeArea(
            child: Container(
                width: MediaQuery.of(context).size.width,
                height:MediaQuery.of(context).size.height,
                //padding: EdgeInsets.fromLTRB(10.0,15.0,10.0,0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child:
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(left: 10.0, right: 10.0,top: 15.0,bottom: 10.0),
                              child: GestureDetector(
                                onTap: () {
                                },
                                child: CircleAvatar(
                                  radius: 75,
                                  backgroundColor: Constants.white,
                                  backgroundImage: NetworkImage(profilphoto.toString())

                                ),
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
                                        usermodel.user.namesurname.toString(),
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
                                        usermodel.user.email,
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
                                        child: Text("Gol Paket",
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
                        ),

                        Divider(color: Constants.black,),
                        ListTile(
                          leading:Text('') ,
                          title: Text('Genel',style: TextStyle(fontSize: 18),),
                        ),
                        Divider(color: Constants.black,),

                        ListTile(
                            leading: Icon(Icons.settings),
                            title: Text(Constants.settings),
                            onTap:(){
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  fullscreenDialog: true,
                                  builder: (context) => SettingsPageStateFul(),
                                ),
                              );}),
                        ListTile(
                            leading: Icon(Icons.help),
                            title: Text(Constants.getsupport),
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
                            title: Text(Constants.aboutus),
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
                            title: Text(Constants.deviceinfo),
                            onTap:(){
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DeviceInfoPage(),
                                ),
                              );}
                        ),
                          ListTile(
                            leading: Icon(
                              Icons.power_settings_new,
                              color: Constants.iconcolorred,
                            ),
                            title: Text(Constants.exit),
                            onTap: () => _cikisyap(context),
                          ),
                      ],
                    ),

                ),
              ),
          ),

        )
    ;
  }


  Future<bool> _cikisyap(BuildContext context) async{
    final _usermodel=Provider.of<UserModel>(context,listen: false);
    bool sonuc=await _usermodel.singOut();
    return sonuc;
  }


}

