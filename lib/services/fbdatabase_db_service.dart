import 'package:firebase_database/firebase_database.dart';
import 'package:newflutter/model/user.dart';
import 'package:newflutter/services/database_base.dart';

class FirebaseDatabaseService implements DBase{
  var _firebaseDatabse=FirebaseDatabase.instance.reference();
  @override
  Future<bool> saveUser(User user) async{
  await  _firebaseDatabse.child('users').child(user.userID).set(user.toMap());

  return true;
  }

  @override
  Future<User> readUser(String userid) async{
    User user;
    await _firebaseDatabse.child("users").child(userid).once().then((DataSnapshot data){
      Map<String, dynamic> gelenveri = Map.from( data.value );
      user=User.fromMap(gelenveri);
//      print('Okunan user ${user.toString()}');

    });
    print(user.userID);
    print(user.namesurname);
    print(user.profilurl);
    print(user.email);
    return user;
  }

 Future<bool> updateProfilFoto(String profilFotoUrl,String userId) async{
    await _firebaseDatabse.child("users").child(userId).update({"profilurl": profilFotoUrl});

    return true;
 }

  @override
  Future<bool> updateNameSurname(String userId, String yeninamesurname) async{
   await _firebaseDatabse.child("users").child(userId).update({"namesurname" :yeninamesurname});
   return true;
  }

  @override
  Future<bool> updateEmail(String userId, String yeniemail) async{
    await _firebaseDatabse.child("users").child(userId).update({"email" :yeniemail});
    return true;
  }

  @override
  Future<bool> updatePhoneNumber(String userId, String phonenumber) async{
    await _firebaseDatabse.child("users").child(userId).update({"phonenumber" :phonenumber});
    return true;
  }

}