import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csv/csv.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:flutter_job_seeking/Repository/ChatRepo.dart';
import 'package:flutter_job_seeking/Repository/JobRepo.dart';
import 'package:flutter_job_seeking/core/theme/app_color.dart';
import 'package:flutter_job_seeking/feature/Chat/Conversation.dart';
import 'package:flutter_job_seeking/feature/Job/GetSimilarity.dart';
import 'package:flutter_job_seeking/feature/Job/JobAnalytics.dart';
import 'package:flutter_job_seeking/feature/detail_job/presentation/detail_job_screen.dart';

class Viewapplicants extends StatefulWidget {
  String jobID;
  Viewapplicants({super.key, required this.jobID});

  @override
  State<Viewapplicants> createState() => _ViewapplicantsState();
}

class _ViewapplicantsState extends State<Viewapplicants> {
  List<List<String>> items=[];

  @override
  void initState() {
    items=[<String>["ID","Candidate","Position","Resume"]];
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(child: Icon(Icons.file_download),onPressed: (){getCSV();}),
      appBar: 
    AppBar(backgroundColor: Colors.white,elevation: 0,title: Text("View Applicants"),),
      body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Container(
            height: MediaQuery.of(context).size.height*1,
           child:StreamBuilder(
             stream: FirebaseFirestore.instance.collection('Apply').where('jobID',isEqualTo: widget.jobID).snapshots(),
    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
          if(snapshot.hasError){
            return Text("Some error occured");
          }else if(snapshot.connectionState==ConnectionState.waiting){
            return Center(child: CircularProgressIndicator());
          }else if(snapshot.hasData){
            return ListView(children: snapshot.data!.docs.map((e) {
              return InkWell(
              onTap: () {},
              child: Card(
                child: StreamBuilder(
            stream: FirebaseFirestore.instance.collection('users').where('id',isEqualTo:e['uid'] ).snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
            if(snapshot.connectionState==ConnectionState.waiting){
              return Container();
            }else if(!snapshot.hasData){
              return  Container();
            }else{
              items.add([
                snapshot.data!.docs.single.get('id'),
                snapshot.data!.docs.single.get('name'),
                snapshot.data!.docs.single.get('position'),
                snapshot.data!.docs.single.get('resume')]);
              return ListTile(
                onTap: () {
                   List<String> users=[e['uid'],FirebaseAuth.instance.currentUser!.uid];
                    String chatRoomID=getChatRoomID(e['uid'], FirebaseAuth.instance.currentUser!.uid);
                    Map<String,dynamic> chatRoomMap={
                      "users":users,
                      "chatRoomID":chatRoomID
                    };
                    ChatRepo.createConversation(chatRoomID, chatRoomMap);
                     //final Message chat = chats[0];
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>Conversation(chatRoomID: chatRoomID,chatWith: snapshot.data!.docs.single.get('name'))));
                },
               leading: Image.network(snapshot.data!.docs.single.get('profile')),
               title: Text(snapshot.data!.docs.single.get('name')),
               subtitle: Text(snapshot.data!.docs.single.get('position')),
               trailing: GestureDetector(onTap: (() {
                 Navigator.push(
                  context, MaterialPageRoute(builder: (BuildContext context) => GetSimilarity(resume:snapshot.data!.docs.single.get('resume'),desc: snapshot.data!.docs.single.get('position'),)));
               }),child: Icon(Icons.file_present_sharp,color: AppColor.primaryColor,)),
                );
            }
          }),)
            );
            }).toList()); 
          }else{
            return CircularProgressIndicator();
          }
    }
          ),
          ),
        ),
      ),
    ),);
  }

  getChatRoomID(String a,String b){
    if(a.substring(0,1).codeUnitAt(0)>b.substring(0,1).codeUnitAt(0)){
      return "$a\_$b";
    }else{
      return "$b\_$a";
    }
  }

  getCSV() async {
    String csvData=const ListToCsvConverter().convert(items);
    print(csvData);
    // Directory generalDownloadDir=Directory('storage/emulated/0/Download');
    // final File file=await (File('${generalDownloadDir.path}/item_export${DateTime.now()}.csv').create());
    // await file.writeAsString(csvData);

    // final directory = (await getExternalStorageDirectories(type: StorageDirectory.downloads))!.first;
    // final File file2 = await File("${directory.path}/${DateTime.now()}.csv").create();
    // print(file2);
    // print("Saving");
    // await file2.writeAsString(csvData);
    try {
    final String directory = (await getApplicationSupportDirectory()).path;
    final String path = "$directory/JOBai-${DateTime.now()}.csv";
    final File file = File(path);
    await file.writeAsString(csvData);
    return path;
     } catch (e) {
      print(e);
    }

  }
}