import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_job_seeking/feature/Applied/ApplicantPDF.dart';
import 'package:flutter_job_seeking/feature/Job/GetSimilarity.dart';
import 'package:get/get.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';

class ApplicantProfile extends StatefulWidget {
  String applicantID;
  ApplicantProfile({required this.applicantID});

  @override
  State<ApplicantProfile> createState() => _ApplicantProfileState();
}

class _ApplicantProfileState extends State<ApplicantProfile> {
  String name="";
String pos="";
bool online=true;
String image="https://th.bing.com/th/id/OIP.ZT-Tw8tYy38htqch69vsGQAAAA?pid=ImgDet&rs=1";
String res="";
  Future getUserData() async {
 await FirebaseFirestore.instance.collection('users').doc(widget.applicantID)
 .get().then((value) async {
    if(value.exists){
      setState(() {
        name=value.data()!['name'];
        pos=value.data()!['position'];
        image=value.data()!['profile'];
        res=value.data()!['resume'];
        online=value.data()!['isAvailable'];
      });
      print("this is re"+ res);
    }
 });
}
  @override
  void initState() {
    getUserData();
    // TODO: implement initState
    super.initState();
  }
  //const ApplicantProfile({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("User Profile"),),
      body: Container(
        height: Get.height*1,
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 30,),
              CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(
                    image,
                  ),
                ),
                 SizedBox(height: 10,),
                Text(name),
                 SizedBox(height: 10,),
                Text(pos),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(onPressed: (){
                         Navigator.push(context, MaterialPageRoute(builder: (context)=> GetSimilarity(resume: res,desc: "Flutter Dev",)));
                    }, 
                    style: ElevatedButton.styleFrom(
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10)),
                                  ),
                                  child: Text("View Similarity"),),
                                  GestureDetector(
                                    onTap: () {
                                      downloadFile(res);
                                    },
                                    child: Icon(Icons.download))
                  ],
                )
    ],),
        ),),);
  }
  Future downloadFile(String url)async{
    final tempDir=await getTemporaryDirectory();
    final path='${tempDir.path}/url';
    await Dio().download(url,path);
    final File file = File(path);
    await OpenFilex.open(file.path);
    //url;
    // String tom="Tom";
    // final dir=await getApplicationDocumentsDirectory();
    // final file=File('${dir.path}/${DateTime.now()}');
    // await ref.writeToFile(file);
  }
}