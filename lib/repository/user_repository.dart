
import 'dart:io';

import 'package:newflutter/model/user.dart';
import 'package:newflutter/services/auth_base.dart';
import 'package:newflutter/services/fake_auth_service.dart';
import 'package:newflutter/services/fbdatabase_db_service.dart';
import 'package:newflutter/services/firebase_auth_service.dart';
import 'package:newflutter/services/firebase_storage_service.dart';
import 'package:newflutter/services/locator.dart';

enum AppMode{DEBUG,REALEASE}

class UserRepository implements AutBase{
  //FirebaseAuthService firebaseden veri cekildiyse
  //FakeAuthenticationService veriler lokal girilmisse
  FirebaseAuthService _firebaseAuthService=locator<FirebaseAuthService>();
  FakeAuthenticationService _fakeAuthenticationService=locator<FakeAuthenticationService>();
  FirebaseDatabaseService _firebaseDatabaseService=locator<FirebaseDatabaseService>();
  FirebaseStorageService _firebaseStorageService=locator<FirebaseStorageService>();

  AppMode appMode=AppMode.REALEASE;
  @override
  Future<User> currentUser() async{
    if(appMode==AppMode.DEBUG){
      return await _fakeAuthenticationService.currentUser();
    }else{
      User user= await _firebaseAuthService.currentUser();
      return await _firebaseDatabaseService.readUser(user.userID);
    }
  }

  @override
  Future<User> singInAnonymously() async{
//    if(appMode==AppMode.DEBUG){
//      return await _fakeAuthenticationService.singInAnonymously();
//    }else{
//      return await _firebaseAuthService.singInAnonymously();
//    }
  }

  @override
  Future<bool> singOut() async{
    if(appMode==AppMode.DEBUG){
      return await _fakeAuthenticationService.singOut();
    }else{
      return await _firebaseAuthService.singOut();
    }
  }

  @override
  Future<User> SignInWithGoogle() async{
    if(appMode==AppMode.DEBUG){
      return await _fakeAuthenticationService.SignInWithGoogle();
    }else{
      User _user= await _firebaseAuthService.SignInWithGoogle();
      bool sonuc=await _firebaseDatabaseService.saveUser(_user);
      if(sonuc==true) return await _firebaseDatabaseService.readUser(_user.userID); else null;
      return _user;
    }
  }

  @override
  Future<User> sigInWithFacebook() async{
    if(appMode==AppMode.DEBUG){
      return await _fakeAuthenticationService.sigInWithFacebook();
    }else{
      User _user= await _firebaseAuthService.sigInWithFacebook();
      bool sonuc=await _firebaseDatabaseService.saveUser(_user);
      if(sonuc==true)  return await _firebaseDatabaseService.readUser(_user.userID); else null;
      return _user;
    }
  }

  @override
  Future<User> createUserWithEmailAndPassword(String email, String password,String adsoyad) async{
    if(appMode==AppMode.DEBUG){
      return await _fakeAuthenticationService.createUserWithEmailAndPassword(email, password,adsoyad);
    }else{
      User _user= await _firebaseAuthService.createUserWithEmailAndPassword(email, password,adsoyad);
     bool sonuc=await _firebaseDatabaseService.saveUser(_user);
     if(sonuc==true)
       return await _firebaseDatabaseService.readUser(_user.userID);
     else null;
    }
  }

  @override
  Future<User> sigInWithEmailAndPassword(String email, String password) async{
    if(appMode==AppMode.DEBUG){
      return await _fakeAuthenticationService.sigInWithEmailAndPassword(email, password);
    }else{
      User user= await _firebaseAuthService.sigInWithEmailAndPassword(email, password);
      return await _firebaseDatabaseService.readUser(user.userID);
    }
  }

 Future<String> uploadFile(String userID, String fileType, File profilFoto) async{
   if(appMode==AppMode.DEBUG){
     return "dosya indirme linki";
   }else{
     var _profilFotoUrl=await _firebaseStorageService.uploadFile(userID, fileType,profilFoto);
     await _firebaseDatabaseService.updateProfilFoto(_profilFotoUrl,userID);
    return _profilFotoUrl;
   }
 }

  Future<bool>  updateNameSurname(String userId, String yeniusername) async{
    if(appMode==AppMode.DEBUG){
      return false;
    }else{
      return await _firebaseDatabaseService.updateNameSurname(userId, yeniusername);
    }
  }
  Future<bool>  updateEmail(String userId, String yeniemail) async{
    if(appMode==AppMode.DEBUG){
      return false;
    }else{
      return await _firebaseDatabaseService.updateEmail(userId, yeniemail);
    }
  }

  Future<bool>  updatePhoneNumber(String userId, String phonenumber) async{
    if(appMode==AppMode.DEBUG){
      return false;
    }else{
      return await _firebaseDatabaseService.updatePhoneNumber(userId, phonenumber);
    }
  }

  @override
  Future<bool> forgotMyPassword(String email) async{
   bool sonuc=await _firebaseAuthService.forgotMyPassword(email);
   return sonuc;
  }

}