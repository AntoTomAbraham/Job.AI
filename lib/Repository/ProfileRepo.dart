import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_job_seeking/Models/UserModel.dart';

class ProfileRepo{
  Future CreateProfile({required String name,required String qualification,required String college,required int experience,}) async {
    final docUser=FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid);
    final json= {
      'name':name,
      'qualification': qualification,
      'college': college,
      'experience': experience,
      'id':FirebaseAuth.instance.currentUser!.uid,
    };
    await docUser.set(json);
  }

  // UserModel myUser=UserModel();
  // Future<dynamic> getProfile(){
  //   FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).snapshots().listen(((event) {
      
  //   }));
  //   return userData;
  // }
}