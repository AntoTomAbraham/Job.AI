
import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRepo{
  Future<bool> emailSignup(String email,String password) async {
    final user=await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password).then((value) => {});
    if(user==null){
    return false;
    }else{
      return true;
    }
  }

  Future<bool> googleSignup() async {
    //try {
    final GoogleSignInAccount? google=await GoogleSignIn().signIn();
    if(google!=null){ 
      final GoogleSignInAuthentication goo=await google.authentication;
      final authCred=GoogleAuthProvider.credential(accessToken: goo.accessToken,idToken: goo.idToken);
      final data=await FirebaseAuth.instance.signInWithCredential(authCred);
      if(data.credential==null){
        return false;
      }else{
        return true;
      }
    }
    // } catch (e) {
    //  print(e); 
    //  return false;
    // }
    return false;
  }

  Future<bool> emailSignin(String email,String password) async {
    final user=await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password).then((value) => {});
    if(user==null){
    return false;
    }else{
      return true;
    }
  }

  Future<void> sendPasswordResetEmail(String email) async {
    return FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }

}