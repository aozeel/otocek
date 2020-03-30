import 'package:flutter/material.dart';

class User{
  final String userID;
  String email;
  String namesurname;
  String profilurl;
  String phonenumber;


  User({@required this.userID,@required this.email,this.namesurname,this.phonenumber});

  //FirebaseDatabase e yazma
  Map<String,dynamic> toMap(){
    return{
      'userId':userID,
      'email':email,
      'namesurname':namesurname,
      'profilurl':profilurl ?? 'https://emrealtunbilek.com/wp-content/uploads/2016/10/apple-icon-72x72.png',//profilurl boş ise kullan degilse '' kullan
      'phonenumber':phonenumber ?? '+90 536 536 36 36',
    };
}

  //FirebaseDatabase okuma
  User.fromMap(Map<String,dynamic> map):
      userID=map['userId'],
      email=map['email'],
      namesurname=map['namesurname'],
      profilurl=map['profilurl'],
      phonenumber=map['phonenumber'];

  @override
  String toString() {
    return 'User{userID: $userID, email: $email, namesurname: $namesurname, profilurl: $profilurl}';
  }


}