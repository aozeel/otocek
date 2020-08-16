import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:newflutter/model/user.dart';
import 'package:newflutter/pages/homepages.dart';
import 'package:newflutter/utils/const.dart';
import 'package:newflutter/viewmodel/usermodel.dart';
import 'package:provider/provider.dart';
import 'package:rich_alert/rich_alert.dart';

class GirisYap extends StatefulWidget {

  void _googleIleGiris(BuildContext context) async{
    final _usermodel=Provider.of<UserModel>(context,listen: false);
    User _user=await _usermodel.SignInWithGoogle();
//    if(_user !=null)
//    print("Oturum açan user id:" + _user.userID.toString());
  }
  void _facebookIleGiris(BuildContext context) async{
    final _usermodel=Provider.of<UserModel>(context,listen: false);
    User _user=await _usermodel.sigInWithFacebook();
//    if(_user !=null)
//      print("Oturum açan user id:" + _user.userID.toString());
  }

  @override
  GirisYapState createState() => GirisYapState();
}

class GirisYapState extends State<GirisYap> {

  final TextEditingController _emailControl = new TextEditingController();
  final TextEditingController _passwordControl = new TextEditingController();

  void _emailVeSifreIleGiris(String email,String password) async{
    final _usermodel=Provider.of<UserModel>(context,listen: false);
    User _user=await _usermodel.sigInWithEmailAndPassword(email, password);
//    if(_user !=null)
//      print("Oturum açan user id:" + _user.userID.toString());

    }
  void sifremiunuttum(String email) async{
    final _usermodel=Provider.of<UserModel>(context,listen: false);
    bool sonuc=await _usermodel.forgotMyPassword(email);
    if(sonuc==true){
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return RichAlertDialog(
              //uses the custom alert dialog
              alertTitle: richTitle("Başarılı."),
              alertSubtitle: richSubtitle("Email Adresinize Mail Gönderildi."),
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
  @override
  Widget build(BuildContext context) {
    final _usermodel=Provider.of<UserModel>(context,listen: false);
    return Padding(
      padding: EdgeInsets.fromLTRB(20.0,0,20,0),
      child: ListView(
        shrinkWrap: true,
        children: <Widget>[
          SizedBox(height: 100.0),
          Card(
            elevation: 3.0,
            child: Container(
              decoration: BoxDecoration(
                color: Constants.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(5.0),
                ),
              ),
              child: TextField(
                style: TextStyle(
                  fontSize: 15.0,
                  color: Constants.black,
                ),
                decoration: InputDecoration(
                  errorText: _usermodel.emailHataMesaji !=null ? _usermodel.emailHataMesaji:null,
                  contentPadding: EdgeInsets.all(10.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(color: Constants.white,),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Constants.white,),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  hintText: "E-posta Adresi Giriniz",
                  prefixIcon: Icon(
                    Icons.mail_outline,
                    color: Constants.black,
                  ),
                  hintStyle: TextStyle(
                    fontSize: 15.0,
                    color: Constants.black,
                  ),
                ),
                maxLines: 1,
                controller: _emailControl,

              ),
            ),
          ),

          SizedBox(height: 10.0),

          Card(
            elevation: 3.0,
            child: Container(
              decoration: BoxDecoration(
                color: Constants.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(5.0),
                ),
              ),
              child: TextField(
                style: TextStyle(
                  fontSize: 15.0,
                  color: Constants.black,
                ),
                decoration: InputDecoration(
                  errorText: _usermodel.sifreHataMEsaji !=null ? _usermodel.sifreHataMEsaji:null,
                  contentPadding: EdgeInsets.all(10.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(color: Constants.white,),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Constants.white,),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  hintText: "Şifre giriniz",
                  prefixIcon: Icon(
                    Icons.lock_outline,
                    color: Constants.black,
                  ),
                  hintStyle: TextStyle(
                    fontSize: 15.0,
                    color: Constants.black,
                  ),
                ),
                obscureText: true,
                maxLines: 1,
                controller: _passwordControl,
              ),
            ),
          ),

          SizedBox(height: 10.0),

          Container(
            alignment: Alignment.centerRight,
            child: FlatButton(
              child: Text(
                "Şifremi Unuttum",
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).accentColor,
                ),
              ),
              onPressed: (){
                emailbilgisial(context);
              },
            ),
          ),

          SizedBox(height: 30.0),

          Container(
            height: 50.0,
            child: RaisedButton(
              child: Text(
                "Giriş Yap".toUpperCase(),
                style: TextStyle(
                  color: Constants.white,
                ),
              ),
              onPressed: () => _emailVeSifreIleGiris(_emailControl.text, _passwordControl.text),
              color: Theme.of(context).accentColor,
            ),
          ),

          SizedBox(height: 10.0),
          Divider(color: Theme.of(context).accentColor,),
          SizedBox(height: 10.0),


          Center(
            child: Container(
              width: MediaQuery.of(context).size.width/2,
              child: Row(
                children: <Widget>[
                  RawMaterialButton(
                    onPressed: () => widget._facebookIleGiris(context),
                    fillColor: Constants.blue800,
                    shape: CircleBorder(),
                    elevation: 4.0,
                    child: Padding(
                      padding: EdgeInsets.all(15),
                      child: Icon(
                        FontAwesomeIcons.facebookF,
                        color: Constants.white,
//              size: 24.0,
                      ),
                    ),
                  ),

                  RawMaterialButton(
                    onPressed: () => widget._googleIleGiris(context),
                    fillColor: Constants.white,
                    shape: CircleBorder(),
                    elevation: 4.0,
                    child: Padding(
                      padding: EdgeInsets.all(15),
                      child: Icon(
                        FontAwesomeIcons.google,
                        color: Constants.blue800,
//              size: 24.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: 20.0),
        ],
      ),
    );
  }

  void emailbilgisial(BuildContext context) {
    final TextEditingController _emailreset = new TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Alert Dialog title"),
          content: new   TextFormField(
            keyboardType: TextInputType.emailAddress,
            controller: _emailreset,
            decoration: InputDecoration(
                hintText: "Email adresinizi Giriniz"
            ),
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Gönder"),
              onPressed: () {
                sifremiunuttum(_emailreset.text);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}