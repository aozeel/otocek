import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:newflutter/utils/const.dart';
import 'package:newflutter/viewmodel/usermodel.dart';
import 'package:provider/provider.dart';
import 'package:rich_alert/rich_alert.dart';

  class SettingsPageStateFul extends StatefulWidget{
  @override
  SettingsPageState createState() => SettingsPageState();
  }
  class SettingsPageState extends State<SettingsPageStateFul>{
  bool adsoyad=true;
  bool adsoyadduzenle=false;
  bool eposta=true;
  bool epostaduzenle=false;
  bool ceptelefonu=true;
  bool ceptelefonuduzenle=false;
  bool sifre=true;
  bool sifreduzenle=false;
  bool kaydeticon=false;
  final TextEditingController _emailControl = new TextEditingController();
  final TextEditingController _namesurname = new TextEditingController();
  final TextEditingController _phonenumber = new TextEditingController();
  final TextEditingController _password = new TextEditingController();

  File _profilFoto;
  String profilFoto;
  @override
  void initState() {

    // TODO: implement initState
    super.initState();
    UserModel usermodel=Provider.of<UserModel>(context,listen: false);
    setState(() {
    });

  }
@override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
   _emailControl.dispose();
   _namesurname.dispose();
   _phonenumber.dispose();
   _password.dispose();
  }
  void _kameradanFotoCek() async {
    var _yeniResim = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      _profilFoto = _yeniResim;
      Navigator.of(context).pop();
      kaydeticon=true;
    });
  }

  void _galeridenResimSec() async {
    var _yeniResim = await ImagePicker.pickImage(source: ImageSource.gallery);
    print('Yeni resim $_yeniResim');
    setState(() {
      _profilFoto = _yeniResim;
      Navigator.of(context).pop();
      kaydeticon=true;
    });
  }
  void _profilFotoGuncelle(BuildContext context) async{
    final _usermodel=Provider.of<UserModel>(context,listen: false);
    if(_profilFoto!=null){
      var url= await _usermodel.uploadFile(_usermodel.user.userID,"profil_foto",_profilFoto);
      print('Indirilen url $url');

      if(url !=null){
        _usermodel.user.profilurl=url;
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return RichAlertDialog( //uses the custom alert dialog
                alertTitle: richTitle("Başarılı."),
                alertSubtitle: richSubtitle("Profil Fotoğrafınız Güncellendi."),
                alertType: RichAlertType.SUCCESS,
                actions: <Widget>[
                  FlatButton(
                    child: Text("Tamam",style: TextStyle(color: Constants.white,),),
                    color: Constants.primaryColor,
                    onPressed: (){Navigator.pop(context);},
                  )
                ],
              );
            }
        );
      }
    }
    Navigator.of(context).pop();
  }
  void _namesurnameGuncelle(BuildContext context) async{
    final UserModel usermodel=Provider.of<UserModel>(context,listen: false);
    if(usermodel.user.namesurname!=_namesurname.text){
      var updateResult= await usermodel.updateNameSurname(usermodel.user.userID,_namesurname.text);
      if(updateResult== true){
        usermodel.user.namesurname=_namesurname.text;
        usermodel.user.email=_emailControl.text;
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return RichAlertDialog( //uses the custom alert dialog
                alertTitle: richTitle("Başarılı."),
                alertSubtitle: richSubtitle("Ad Soyad Güncellendi."),
                alertType: RichAlertType.SUCCESS,
                actions: <Widget>[
                  FlatButton(
                    child: Text("Tamam",style: TextStyle(color: Constants.white,),),
                    color: Constants.primaryColor,
                    onPressed: (){Navigator.pop(context);},
                  )
                ],
              );
            }
        );
      }else{
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return RichAlertDialog( //uses the custom alert dialog
                alertTitle: richTitle("Başarısız."),
                alertSubtitle: richSubtitle("Ad Soyad Güncellenmedi"),
                alertType: RichAlertType.ERROR,
                actions: <Widget>[
                  FlatButton(
                    child: Text("Tamam",style: TextStyle(color: Constants.white,),),
                    color: Constants.primaryColor,
                    onPressed: (){Navigator.pop(context);},
                  )
                ],
              );
            }
        );
      }
    }

  }
  void _emailGuncelle(BuildContext context) async{
    final UserModel usermodel=Provider.of<UserModel>(context,listen: false);
    if(usermodel.user.email!=_emailControl.text){
      var updateResult= await usermodel.updateEmail(usermodel.user.userID,_emailControl.text);
      if(updateResult== true){
        usermodel.user.email=_emailControl.text;
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return RichAlertDialog( //uses the custom alert dialog
                alertTitle: richTitle("Başarılı."),
                alertSubtitle: richSubtitle("E-mail Güncellendi."),
                alertType: RichAlertType.SUCCESS,
                actions: <Widget>[
                  FlatButton(
                    child: Text("Tamam",style: TextStyle(color: Constants.white,),),
                    color: Constants.primaryColor,
                    onPressed: (){Navigator.pop(context);},
                  )
                ],
              );
            }
        );
      }else{
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return RichAlertDialog( //uses the custom alert dialog
                alertTitle: richTitle("Başarısız."),
                alertSubtitle: richSubtitle("Email Güncellenmedi"),
                alertType: RichAlertType.ERROR,
                actions: <Widget>[
                  FlatButton(
                    child: Text("Tamam",style: TextStyle(color: Constants.white,),),
                    color: Constants.primaryColor,
                    onPressed: (){Navigator.pop(context);},
                  )
                ],
              );
            }
        );
      }
    }

  }
  void _telefonGuncelle(BuildContext context) async{
    final UserModel usermodel=Provider.of<UserModel>(context,listen: false);
    if(usermodel.user.phonenumber!=_phonenumber.text){
      var updateResult= await usermodel.updatePhoneNumber(usermodel.user.userID,_phonenumber.text);
      if(updateResult== true){
        usermodel.user.phonenumber=_phonenumber.text;
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return RichAlertDialog( //uses the custom alert dialog
                alertTitle: richTitle("Başarılı."),
                alertSubtitle: richSubtitle("Telefon Numarınız Güncellendi."),
                alertType: RichAlertType.SUCCESS,
                actions: <Widget>[
                  FlatButton(
                    child: Text("Tamam",style: TextStyle(color: Constants.white,),),
                    color: Constants.primaryColor,
                    onPressed: (){Navigator.pop(context);},
                  )
                ],
              );
            }
        );
      }else{
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return RichAlertDialog( //uses the custom alert dialog
                alertTitle: richTitle("Başarısız"),
                alertSubtitle: richSubtitle("Telefon Numarınız Güncellenmedi."),
                alertType: RichAlertType.ERROR,
                actions: <Widget>[
                  FlatButton(
                    child: Text("Tamam",style: TextStyle(color: Constants.white,),),
                    color: Constants.primaryColor,
                    onPressed: (){Navigator.pop(context);},
                  )
                ],
              );
            }
        );
      }
    }

  }

  @override
  Widget build(BuildContext context) {

    UserModel usermodel=Provider.of<UserModel>(context,listen: false);
     profilFoto=usermodel.user.profilurl;
    _namesurname.text=usermodel.user.namesurname;
    _emailControl.text=usermodel.user.email;
    _phonenumber.text=usermodel.user.phonenumber;
     return Scaffold(
      appBar: AppBar(
        title: Text("Ayarlar",style: TextStyle(color:Constants.white,),),
        actions: <Widget>[
          Visibility(
          child: IconButton(icon: Icon(Icons.save,color: Constants.white,),
          onPressed: (){
              setState(() {
                _profilFotoGuncelle(context);
                _namesurnameGuncelle(context);
                _emailGuncelle(context);
                _telefonGuncelle(context);
              });
          }
          ),
          visible: kaydeticon,
          ),
        ],
      ),
      body:  Padding(
        padding: EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 0),
        child: ListView(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 10.0, right: 10.0,top: 15.0,bottom: 10.0),
                  child: GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return Container(
                              height: 160,
                              child: Column(
                                children: <Widget>[
                                  ListTile(
                                    leading: Icon(Icons.camera),
                                    title: Text("Kameradan Çek"),
                                    onTap: () {
                                      _kameradanFotoCek();
                                    },
                                  ),
                                  ListTile(
                                    leading: Icon(Icons.image),
                                    title: Text("Galeriden Seç"),
                                    onTap: () {
                                      _galeridenResimSec();
                                    },
                                  ),
                                ],
                              ),
                            );
                          });
                    },
                    child: CircleAvatar(
                      radius: 75,
                      backgroundColor: Constants.white,
                      backgroundImage: _profilFoto == null
                          ? NetworkImage(profilFoto.toString())
                          : FileImage(_profilFoto),
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
                            usermodel.user.namesurname,
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
            ),
            Divider(),
            Container(height: 15.0),
            Padding(
              padding: EdgeInsets.all(5.0),
              child: Text(
                "Üyelik Bilgileri".toUpperCase(),
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            //Ad Soyad
            Visibility(
              child: ListTile(
                title: Text(
                  "Ad Soyad",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                subtitle: Text(
                  usermodel.user.namesurname,
                ),
                trailing: IconButton(
                  icon: Icon(
                    Icons.edit,
                    size: 20.0,
                  ),
                  onPressed: () {
                    setState(() {
                      adsoyad=false;
                      adsoyadduzenle=true;
                      kaydeticon=true;
                    });
                  },
                  tooltip: "Edit",
                ),
              ),
              visible: adsoyad,
            ),
            Visibility(
              child: Container(
                width: 160.0,
                height: 40.0,
                margin: EdgeInsets.all(10.0),
                child: TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: _namesurname,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Ad Soyad Güncelle',
                  ),
                ),
              ),
              visible: adsoyadduzenle,
            ),

            //E-Posta
            Visibility(child: 
             ListTile(
              title: Text(
                "E-Posta",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                ),
              ),
              subtitle: Text(
                usermodel.user.email,
              ),
              trailing: IconButton(
                icon: Icon(
                  Icons.edit,
                  size: 20.0,
                ),
                onPressed: () {
                  setState(() {
                  eposta=false;
                  epostaduzenle=true;
                  kaydeticon=true;
                  });
                  
                },
                tooltip: "Edit",
              ),
            ),
            visible: eposta,
            ),
            Visibility(
              child: Container(
                width: 160.0,
                height: 40.0,
                margin: EdgeInsets.all(10.0),
                child: TextField(
                  controller: _emailControl,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'E-Posta Güncelle',
                  ),
                ),
              ),
              visible: epostaduzenle,
            ),
            //cep telefonu
            Visibility(child: ListTile(
              title: Text(
                "Cep Telefonu",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                ),
              ),
              subtitle: Text(
                usermodel.user.phonenumber,
              ),
              trailing: IconButton(
                icon: Icon(
                  Icons.edit,
                  size: 20.0,
                ),
                onPressed: () {
                  setState(() {
                  ceptelefonu=false;
                  ceptelefonuduzenle=true;
                  kaydeticon=true;
                  });
                 
                },
                tooltip: "Edit",
              ),
            ),
            visible: ceptelefonu,
            ),
            Visibility(
              child: Container(
                width: 160.0,
                height: 40.0,
                margin: EdgeInsets.all(10.0),
                child: TextField(
                  controller: _phonenumber,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Cep Telefonu Güncelle',
                  ),
                ),
              ),
              visible: ceptelefonuduzenle,
            ),


            //Şifre
//            Visibility(child:   ListTile(
//              title: Text(
//                "Şifre",
//                style: TextStyle(
//                  fontSize: 17,
//                  fontWeight: FontWeight.w700,
//                ),
//              ),
//              subtitle: Text(
//                "**********",
//              ),
//              trailing: IconButton(
//                icon: Icon(
//                  Icons.edit,
//                  size: 20.0,
//                ),
//                onPressed: () {
//                  setState(() {
//                  sifre=false;
//                  sifreduzenle=true;
//                  kaydeticon=true;
//                  });
//                },
//                tooltip: "Edit",
//              ),
//            ),
//            visible: sifre,
//            ),
//            Visibility(
//              child: Container(
//                width: 160.0,
//                height: 40.0,
//                margin: EdgeInsets.all(10.0),
//                child: TextField(
//                  controller: _password,
//                  keyboardType: TextInputType.number,
//                  decoration: InputDecoration(
//                    border: OutlineInputBorder(),
//                    labelText: 'Şifre Güncelle',
//                  ),
//                ),
//              ),
//              visible: sifreduzenle,
//            ),

          ],
        ),
      ),
       
     );
      
}





  }    
      

