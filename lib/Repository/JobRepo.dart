import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class JobRepo{
  static Future CreateJOB({required String company,required String pos,required String jobtype,required String jobID,required String desc,required String workPlaceType,required String salary,required String jobLocation,required List<dynamic> requirements}) async {
    final docUser=FirebaseFirestore.instance.collection('Job').doc(company+jobID);
    final json= {
      'Jobtitle':pos,
      'jobLocation':jobLocation,
      'jobType':jobtype,
      'workPlaceType': workPlaceType,
      'isOpen':true,
      'company':company,
      'jobID':company+jobID,
      'JobDesc':desc,
      'requirements':requirements,
      'salary':salary,
      'Analytics':[],
      'uid':FirebaseAuth.instance.currentUser!.uid,
    };
    await docUser.set(json);
  }

  static Future updateStatus({required bool status}) async {
    final docUser=FirebaseFirestore.instance.collection('Job').doc(FirebaseAuth.instance.currentUser!.uid);
    final json= {
      'isOpen':status,
    };
    await docUser.update(json);
    }

  static Future incrementView({required String jobID})async{
    var quantityref = FirebaseFirestore.instance.collection("Job").doc(jobID);
    quantityref.update({
      "view" :FieldValue.increment(1)});
  }

  static Future addAnalytics({required String jobID})async{
    var quantityref =await FirebaseFirestore.instance.collection("Job").doc(jobID);
    quantityref.update({
      "Analytics" :FieldValue.arrayUnion([DateTime.now()])});
  }

  static Future addInsights({required String jobID }) async {
    DateTime today = DateTime.now();
    String dateStr = "${today.day}-${today.month}-${today.year}";
    var quantityref =await FirebaseFirestore.instance.collection("Job").doc(jobID).collection("Insights").doc(dateStr);
    var a = await FirebaseFirestore.instance.collection("Job").doc(jobID).collection("Insights").doc(dateStr).get();
    if(a.exists){
      quantityref.update({'count':FieldValue.increment(1)});
    }else{ 
    var json={
      'Date':dateStr,
      'count':1
    };   
    quantityref.set(json);
    }
  }

  static queryJob(String queryString) async{
    return FirebaseFirestore.instance.collection('Job').where('Jobtitle',isGreaterThanOrEqualTo: queryString).get();
  }

}