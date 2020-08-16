import 'package:firebase_auth/firebase_auth.dart';
import 'package:newflutter/model/user.dart';

abstract class AutBase{

  Future<User> currentUser();
  Future<User> singInAnonymously();
  Future<bool> singOut();
  Future<User> SignInWithGoogle();
  Future<User> sigInWithFacebook();
  Future<bool> forgotMyPassword(String email);
  Future<User> sigInWithEmailAndPassword(String email,String password);
  Future<User> createUserWithEmailAndPassword(String email,String password,String adsoyad);

}