import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ApplicationRepo{
 static Future apply({required String jobID,required String coverLetter }) async {
    DateTime today = DateTime.now();
    String dateStr = "${today.day}-${today.month}-${today.year}";
    var quantityref =await FirebaseFirestore.instance.collection("Apply").doc();
    var json={
      'aID':quantityref.id,
      'Date':DateTime.now(),
      'jobID':jobID,
      'uid':FirebaseAuth.instance.currentUser!.uid,
      'coverLetter': coverLetter,
    };   
    quantityref.set(json);
  } 
}