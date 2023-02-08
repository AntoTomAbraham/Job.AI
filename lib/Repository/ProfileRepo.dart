import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_job_seeking/Helper/DialogHelper.dart';
import 'package:flutter_job_seeking/Models/UserModel.dart';

class ProfileRepo{
  Future CreateProfile({required String pos,required String name,required String qualification,required String college,required String experience,required List<dynamic> skills,required String image}) async {
    //DialogHelper.showLoadingDialog();
    final docUser=FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid);
    final json= {
      'name':name,
      'qualification': qualification,
      'college': college,
      'experience': experience,
      'skills':skills,
      'profile': image,
      'position':pos,
      'id':FirebaseAuth.instance.currentUser!.uid,
    };
    await docUser.set(json);
    //DialogHelper.hideDialog();
    //DialogHelper.showDialog("Account Created Successfully", true);
  }

Future uploadResume({required String resume}) async {
    //DialogHelper.showLoadingDialog();
    final docUser=FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid);
    final json= {
      'resume':resume,
    };
    await docUser.update(json);
    //DialogHelper.hideDialog();
    //DialogHelper.showDialog("Account Created Successfully", true);
  }
  
}