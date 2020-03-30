import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:newflutter/model/user.dart';
import 'package:newflutter/pages/homepages.dart';
import 'package:newflutter/pages/loginpages/login_page.dart';
import 'package:newflutter/services/auth_base.dart';
import 'package:newflutter/services/firebase_auth_service.dart';
import 'package:newflutter/services/locator.dart';
import 'package:newflutter/viewmodel/usermodel.dart';
import 'package:provider/provider.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _usermodel=Provider.of<UserModel>(context);

    if(_usermodel.state == ViewState.Idle){

      if(_usermodel.user ==null){
        //giris yapmadı
        return GirisEkraniFul();
      }else{
        //giris yapıldı
        return HomePage(user: _usermodel.user,);
      }

    }else{
      return Scaffold(
        body:
        Center(
          child: CircularProgressIndicator(),
        ),
      );
    }


  }

}
