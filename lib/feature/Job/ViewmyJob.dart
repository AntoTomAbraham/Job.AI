import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_job_seeking/Repository/JobRepo.dart';
import 'package:flutter_job_seeking/feature/Job/JobAnalytics.dart';
import 'package:flutter_job_seeking/feature/detail_job/presentation/detail_job_screen.dart';
import 'package:http/http.dart' as http;

class ViewmyJob extends StatefulWidget {
  const ViewmyJob({super.key});

  @override
  State<ViewmyJob> createState() => _ViewmyJobState();
}

class _ViewmyJobState extends State<ViewmyJob> {

  bool isOpen=false;
  Future<String> getLogo(String logo) async {
    var headers = {
    'X-RapidAPI-Host': 'logo4.p.rapidapi.com',
    'X-RapidAPI-Key': '60597071afmsh7cc3bf813bb89dcp1e3160jsnc34d8244f3e0',
  };
  var url = Uri.parse('https://logo4.p.rapidapi.com/logo/${logo}');
  var res = await http.get(url, headers: headers);
  //if (res.statusCode != 200) throw Exception('http.get error: statusCode= ${res.statusCode}');
  print("output");
  print(res.body);
  return res.body;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(backgroundColor: Colors.white,elevation: 0,title: Text("Your Jobs"),),
      body: SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height*1,
       child: StreamBuilder(
    stream: FirebaseFirestore.instance.collection('Job').where('uid',isEqualTo: FirebaseAuth.instance.currentUser!.uid).snapshots(),
    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
      if(!snapshot.hasData){
        return Center(
          child: CircularProgressIndicator(),
        );
      }
      return ListView(
        children: snapshot.data!.docs.map((document)  {
          // getLogo('amazon.com');
          // Future<String> logo= getLogo('amazon.com');
          //bool isJOb=document['isOpen'];
          return Center(
            child: Container(
              width: MediaQuery.of(context).size.width / 1.2,
              height: MediaQuery.of(context).size.height / 6,
              child:ListTile(
                onTap: () {
                   Navigator.push(  
                  context,  
                  MaterialPageRoute(builder: (context) => 
                  DetailJobScreen(jobID: document['jobID'],)));
                },
                //leading: Image.network(logo.toString()),
                title:Text(document['Jobtitle']),
                isThreeLine: true,
                onLongPress: () {
                  showDialog(
  context: context,
  builder: (BuildContext context) {
    return AlertDialog(
      title: Text('Are you sure you want to stop hiring ?'),
      //content: Text('Dialog Message'),
      actions: [
        TextButton(
          onPressed: ()async {
            final documentReference = FirebaseFirestore.instance.collection('Job').doc(document['jobID']);
            await documentReference.update({'isOpen': false});
            // Perform action when "Cancel" button is pressed
            Navigator.of(context).pop();
          },
          child: Text('YES'),
        ),
        TextButton(
          onPressed: () {
            // Perform action when "OK" button is pressed
            Navigator.of(context).pop();
          },
          child: Text('NO'),
        ),
      ],
    );
  },
);

                },
                subtitle: Text('JOBID: '+document['jobID']),
                trailing: Container(
                  width: 83,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector
                      (onTap: (){
                           Navigator.push(  
                  context,  
                  MaterialPageRoute(builder: (context) => 
                  jobAnalytics(JobID: document['jobID'],)));
                      },
                        child: Icon(Icons.analytics)),
                          //  CupertinoSwitch(value: isJOb, onChanged: (val){
                          //   JobRepo.updateStatus(status: val);
                          //   setState(() {
                          //      isJOb=val;
                          //   });
                          //   JobRepo.updateStatus(status: isJOb);
                     //}),
                    ],
                  ),
                ),
                // trailing: Row(
                //   children: [
                    // CupertinoSwitch(value: isOpen, onChanged: (val){
                    //   isOpen=val;
                //     }),
                //     Icon(Icons.analytics),
                //   ],
                // ),
                ),
              //child: Text("Title: " + document['Jobtitle']),
            ),
          );
        }).toList(),
      );
    }
  ),
      ),
    ),);
  }
}