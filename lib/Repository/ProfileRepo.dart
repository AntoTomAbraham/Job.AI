import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_job_seeking/Helper/DialogHelper.dart';
import 'package:flutter_job_seeking/Models/UserModel.dart';

class ProfileRepo{
  Future CreateProfile({required String pos,required String name,required String qualification,required String college,required String experience,required List<dynamic> skills,required String image}) async {
    final docUser=FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid);
    final json= {
      'name':name,
      'qualification': qualification,
      'college': college,
      'experience': experience,
      'skills':skills,
      'profile': image,
      'position':pos,
      'isAvailable':true,
      'id':FirebaseAuth.instance.currentUser!.uid,
    };
    await docUser.set(json);
  }

Future uploadResume({required String resume}) async {
    final docUser=FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid);
    final json= {
      'resume':resume,
    };
    await docUser.update(json);
  }

  Future updateStatus({required bool status}) async {
    final docUser=FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid);
    final json= {
      'isAvailable':status,
    };
    await docUser.update(json);
    }

    // static Future<String> getUserByUID({required String uid})async{
      
    //   // print("DocUser");
    //   // print(docUser);
    //   // return docUser.toString();
    // }
    
}