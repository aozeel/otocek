import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'dart:convert';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:newflutter/model/user.dart';
import 'package:newflutter/services/auth_base.dart';
import 'package:http/http.dart' as http;
class FirebaseAuthService implements AutBase {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;


  User _userFromFirebase(FirebaseUser user,String namesurname) {
    if (user == null) {
      return null;
    } else {
      return User(userID: user.uid, email: user.email,namesurname: namesurname);
    }
  }

  User _userFromFirebaseGoogle(FirebaseUser user,GoogleSignInAccount googleSignInAccount) {
    if (user == null) {
      return null;
    } else {

      return User(userID: user.uid, email: googleSignInAccount.email,namesurname: googleSignInAccount.displayName);
    }
  }

  User _userFromFirebaseFacebook(FirebaseUser user,dynamic profil) {
    if (user == null) {
      return null;
    } else {

      return User(userID: user.uid, email: profil["email"],namesurname: profil["name"]);
    }
  }

  @override
  Future<User> SignInWithGoogle() async{
    GoogleSignIn _googleSignIn = GoogleSignIn();
    GoogleSignInAccount _googleUser = await _googleSignIn.signIn();

    if (_googleUser != null) {
      GoogleSignInAuthentication _googleAuth = await _googleUser.authentication;
      if (_googleAuth.idToken != null && _googleAuth.accessToken != null) {
        AuthResult sonuc = await _firebaseAuth.signInWithCredential(
            GoogleAuthProvider.getCredential(
                idToken: _googleAuth.idToken,
                accessToken: _googleAuth.accessToken));
        FirebaseUser _user = sonuc.user;
        return _userFromFirebaseGoogle(_user,_googleUser);
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  @override
  Future<User> createUserWithEmailAndPassword(String email, String password,String namesurname) async{
    AuthResult sonuc = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    return _userFromFirebase(sonuc.user,namesurname);
  }

  @override
  Future<User> currentUser() async {
    try {
      FirebaseUser user = await _firebaseAuth.currentUser();
      return _userFromFirebase(user,null);
    } catch (e) {
      print("HATA CURRENT USER" + e.toString());
      return null;
    }
  }

  @override
  Future<User> sigInWithEmailAndPassword(String email, String password) async{
    AuthResult sonuc = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    return _userFromFirebase(sonuc.user,null);
  }

  @override
  Future<User> sigInWithFacebook() async{
    final _facebookLogin = FacebookLogin();

    FacebookLoginResult _faceResult = await _facebookLogin
        .logIn(['public_profile', 'email']);

    switch (_faceResult.status) {
      case FacebookLoginStatus.loggedIn:
        if (_faceResult.accessToken != null && _faceResult.accessToken.isValid()) {
          AuthResult _firebaseResult = await _firebaseAuth.signInWithCredential(FacebookAuthProvider.getCredential(accessToken: _faceResult.accessToken.token));
          final graphResponse = await http.get('https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email&access_token=${_faceResult.accessToken.token}');
          dynamic profile = jsonDecode(graphResponse.body);
          FirebaseUser _user = _firebaseResult.user;
          return _userFromFirebaseFacebook(_user,profile);
        } else {
           print("access token valid :" +
              _faceResult.accessToken.isValid().toString());
        }

        break;

      case FacebookLoginStatus.cancelledByUser:
        print("kullanıcı facebook girişi iptal etti");
        break;

      case FacebookLoginStatus.error:
        print("Hata cıktı :" + _faceResult.errorMessage);
        break;
    }

    return null;
  }

  @override
  Future<User> singInAnonymously() async{
//    try {
//      AuthResult sonuc = await _firebaseAuth.signInAnonymously();
//      return _userFromFirebase(sonuc.user);
//    } catch (e) {
//      print("anonim giris hata:" + e.toString());
//      return null;
//    }
  }

  @override
  Future<bool> singOut() async{
    try {
      final _facebookLogin = FacebookLogin();
      await _facebookLogin.logOut();

      final _googleSignIn = GoogleSignIn();
      await _googleSignIn.signOut();

      await _firebaseAuth.signOut();
      return true;
    } catch (e) {
      print("sign out hata:" + e.toString());
      return false;
    }
  }

  @override
  Future<bool> forgotMyPassword(String email) async{
  await _firebaseAuth.sendPasswordResetEmail(email: email).then((v){
     print("Sıfırlama maili gönderildi");
     return true;
   }).catchError((hata){
     print("Sıfırlama mailinde hata $hata");
     return false;
   });
  }


}
