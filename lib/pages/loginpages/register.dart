import 'package:flutter/material.dart';
import 'package:newflutter/model/user.dart';
import 'package:newflutter/utils/const.dart';
import 'package:newflutter/viewmodel/usermodel.dart';
import 'package:provider/provider.dart';

import 'login_page.dart';

class KayitOl extends StatefulWidget {
  @override
  KayitOlState createState() => KayitOlState();
}

class KayitOlState extends State<KayitOl> {
  final TextEditingController _namesurnameControl = new TextEditingController();
  final TextEditingController _emailControl = new TextEditingController();
  final TextEditingController _passwordControl = new TextEditingController();


  void _emailVeSifreIleKayitOl(String email,String password) async{
    final _usermodel=Provider.of<UserModel>(context,listen: false);
    User _user=await _usermodel.createUserWithEmailAndPassword(email, password,_namesurnameControl.text.toString());
    if(_user !=null)
      print("Oturum açan user id:" + _user.userID.toString());
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
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(10.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(color: Constants.white,),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Constants.black,),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  hintText: "Ad Soyad Giriniz",
                  prefixIcon: Icon(
                    Icons.perm_identity,
                    color: Constants.black,
                  ),
                  hintStyle: TextStyle(
                    fontSize: 15.0,
                    color: Constants.black,
                  ),
                ),
                maxLines: 1,
                controller: _namesurnameControl,
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
                color: Colors.white,
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
                  hintText: "Şifre Giriniz",
                  prefixIcon: Icon(
                    Icons.lock_outline,
                    color:Constants.black,
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


          SizedBox(height: 40.0),

          Container(
            height: 50.0,
            child: RaisedButton(
              child: Text(
                "Kayıt Ol".toUpperCase(),
                style: TextStyle(
                  color: Constants.white,
                ),
              ),
              onPressed: () => _emailVeSifreIleKayitOl(_emailControl.text, _passwordControl.text),
              color: Theme.of(context).accentColor,
            ),
          ),

          SizedBox(height: 10.0),
          Divider(color: Theme.of(context).accentColor,),
          SizedBox(height: 10.0),



          SizedBox(height: 20.0),


        ],
      ),
    );
  }
}