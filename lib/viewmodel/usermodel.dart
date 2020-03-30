
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:newflutter/model/user.dart';
import 'package:newflutter/repository/user_repository.dart';
import 'package:newflutter/services/auth_base.dart';
import 'package:newflutter/services/locator.dart';

enum ViewState{Idle,Busy} //enum user durumlarını belirtir

class UserModel with ChangeNotifier implements AutBase{

  ViewState _state=ViewState.Idle;
  UserRepository _userRepository=locator<UserRepository>();
  User _user;
  String emailHataMesaji;
  String sifreHataMEsaji;

  User get user => _user;

  set user(User value) {
    _user = value;
  }

  ViewState get state => _state;

  set state(ViewState value) {
    _state = value;
    notifyListeners();
  }

  UserModel(){
    currentUser();
  }

  @override
  Future<User> currentUser() async{
   try{
    state=ViewState.Busy;
    _user=await _userRepository.currentUser();
    return _user;
   }catch(e){
    debugPrint("View Modeldeki current Userda hata "+e.toString());
    return null;
   }finally{
     state=ViewState.Idle;
   }
  }

  @override
  Future<bool> singOut() async{
    try{
      state=ViewState.Busy;
      bool sonuc= await _userRepository.singOut();
      _user=null;
      return sonuc;
    }catch(e){
      debugPrint("View Modeldeki current Userda hata "+e.toString());
      return false;
    }finally{
      state=ViewState.Idle;
    }
  }

  @override
  Future<User> singInAnonymously() async{
//    try{
//      state=ViewState.Busy;
//      _user= await _userRepository.singInAnonymously();
//      print('Giriş yapan user id ${_user.userID.toString()}');
//      return _user;
//    }catch(e){
//      debugPrint("View Modeldeki current Userda hata "+e.toString());
//      return null;
//    }finally{
//      state=ViewState.Idle;
//    }
  }

  @override
  Future<User> SignInWithGoogle() async{
    try{
      state=ViewState.Busy;
      _user= await _userRepository.SignInWithGoogle();
      print('Giriş yapan user id ${_user.userID.toString()}');
      return _user;
    }catch(e){
      debugPrint("View Modeldeki current Userda hata "+e.toString());
      return null;
    }finally{
      state=ViewState.Idle;
    }
  }

  @override
  Future<User> sigInWithFacebook() async{
    try{
      state=ViewState.Busy;
      _user= await _userRepository.sigInWithFacebook();
      print('Giriş yapan user id ${_user.userID.toString()}');
      return _user;
    }catch(e){
      debugPrint("View Modeldeki current Userda hata "+e.toString());
      return null;
    }finally{
      state=ViewState.Idle;
    }
  }

  @override
  Future<User> createUserWithEmailAndPassword(String email, String password,String adsoyad) async{
    try{
      if(_emailSifreKontrol(email, password)) {
        state = ViewState.Busy;
        _user = await _userRepository.createUserWithEmailAndPassword(email, password,adsoyad);
        return _user;
      }else return null;
    }catch(e){
      debugPrint("View Modeldeki Create Email hata"+e.toString());
      return null;
    }finally{
      state=ViewState.Idle;
    }
  }

  @override
  Future<User> sigInWithEmailAndPassword(String email, String password) async{
    try{
      if(_emailSifreKontrol(email, password) ){
        state=ViewState.Busy;
        _user= await _userRepository.sigInWithEmailAndPassword(email, password);
        return _user;
      }else{
        return null;
      }
    }catch(e){
      debugPrint("View Modeldeki current Userda hata "+e.toString());
      return null;
    }finally{
      state=ViewState.Idle;
    }
  }

  bool _emailSifreKontrol(String email,String password){

    var sonuc=true;

    if(password.length<6){
      sifreHataMEsaji="En az 6 karakter olmalı";
      sonuc=false;
    }else sifreHataMEsaji=null;
    if(!email.contains(('@'))){
      emailHataMesaji="Gerçersiz email adresi";
      sonuc=false;
    }else emailHataMesaji=null;

    return sonuc;
  }

 Future<String> uploadFile(String userID, String fileType, File profilFoto) async{
    var indirmeLinki=await _userRepository.uploadFile(userID,fileType,profilFoto);
    return indirmeLinki;
 }

  Future<bool> updateNameSurname(String userId,String yeniusername) async{
    state=ViewState.Busy;
    var sonuc= await _userRepository.updateNameSurname(userId,yeniusername);
    state=ViewState.Idle;
    return sonuc;
  }

  Future<bool> updateEmail(String userId,String yeniusername) async{
    state=ViewState.Busy;
    var sonuc= await _userRepository.updateEmail(userId,yeniusername);
    state=ViewState.Idle;
    return sonuc;
  }

  Future<bool> updatePhoneNumber(String userId,String phonenumber) async{
    state=ViewState.Busy;
    var sonuc= await _userRepository.updatePhoneNumber(userId,phonenumber);
    state=ViewState.Idle;
    return sonuc;
  }

  @override
  Future<bool> forgotMyPassword(String email) async{
    bool sonuc=await _userRepository.forgotMyPassword(email);
    return sonuc;
  }


}