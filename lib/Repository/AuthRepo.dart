import 'dart:async';
import 'dart:convert';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

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
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      print('Running on ${androidInfo.model}'); 
      await sendMail(device: androidInfo.model,email: email,subject: "Thank you");
      return true;
    }
  }
  
  Future sendMail({String? email,String? device,String? subject}) async {
    final url=Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
    final res=await http.post(
      url,
      headers: {
        'Orgin':'http://localhost',
        'Content-Type':'application/json'
      },
    body: json.encode({
      'service_id':"service_imid6zv",
      'template_id':"template_ffimex4",
      'user_id':"MaZWEAIR43SvHj946",
      'template_params':{
        'from_name':"Anto",
        'date_time':DateTime.now().toString(),
        'to_name':email,
        'reply_to':email,
        'message':"YOu logged",
        'from_device':device
      }
    })
    );
    print(res.statusCode);
  }
  Future<void> sendPasswordResetEmail(String email) async {
    return FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }

}