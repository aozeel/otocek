import 'package:newflutter/model/user.dart';
import 'package:newflutter/services/auth_base.dart';

class FakeAuthenticationService implements AutBase{

  String userId="12315613323553";
  @override
  Future<User> currentUser() async{
      return await Future.value(User(userID: userId,email: 'fakeuser@fake.com'));
  }

  @override
  Future<User> singInAnonymously() async{
    return await Future.delayed(Duration(seconds: 2), () => User(userID: userId,email: 'fakeuser@fake.com'));
  }

  @override
  Future<bool> singOut() {
    return Future.value(true);
  }

  @override
  Future<User> SignInWithGoogle() {
   return null;
  }

  @override
  Future<User> sigInWithFacebook() {
    // TODO: implement sigInWithFacebook
    throw UnimplementedError();
  }

  @override
  Future<User> createUserWithEmailAndPassword(String email, String password,String adsoyad) {
    // TODO: implement createUserWithEmailAndPassword
    throw UnimplementedError();
  }

  @override
  Future<User> sigInWithEmailAndPassword(String email, String password) {
    // TODO: implement sigInWithEmailAndPassword
    throw UnimplementedError();
  }

  @override
  Future<bool> forgotMyPassword(String mail) {
    // TODO: implement forgotMyPassword
    throw UnimplementedError();
  }

}