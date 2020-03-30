import 'package:newflutter/model/user.dart';

abstract class DBase{

  Future<bool> saveUser(User user);
  Future<User> readUser(String userid);
  Future<bool> updateNameSurname(String userId,String yeninamesurname);
  Future<bool> updateEmail(String userId,String yeniemail);
  Future<bool> updatePhoneNumber(String userId,String phonenumber);
}