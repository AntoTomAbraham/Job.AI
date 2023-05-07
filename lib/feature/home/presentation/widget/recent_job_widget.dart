import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_job_seeking/Models/message_model.dart';
import 'package:flutter_job_seeking/Repository/ChatRepo.dart';
import 'package:flutter_job_seeking/Repository/JobRepo.dart';
import 'package:flutter_job_seeking/core/route/app_route_name.dart';
import 'package:flutter_job_seeking/feature/Chat/Conversation.dart';
import 'package:flutter_job_seeking/feature/detail_job/presentation/detail_job_screen.dart';
import 'package:flutter_job_seeking/feature/home/model/job.dart';
import 'package:get/get.dart';

class RecentJobWidget extends StatelessWidget {
  const RecentJobWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height*.3,
      child: StreamBuilder(
         stream: FirebaseFirestore.instance.collection('Job').where('isOpen',isEqualTo: true).snapshots(),
    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
      if(snapshot.hasError){
        return Text("Some error occured");
      }else if(snapshot.connectionState==ConnectionState.waiting){
        return Center(child: CircularProgressIndicator());
      }else if(snapshot.hasData){
        return ListView(children: snapshot.data!.docs.map((e) {
         return InkWell(
          onTap: () {
            //JobRepo.addAnalytics(jobID: 'S4VyrnXYe8X9ywM2888b');
            JobRepo.addInsights(jobID: e['jobID']);
            JobRepo.incrementView(jobID: e['jobID']);
            Navigator.push(
                        context, MaterialPageRoute(builder: (BuildContext context) => DetailJobScreen(jobID: e['jobID']) ));
          },
          child: Container(
            height: 86,
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  child: e['company'].isNotEmpty ? FadeInImage(
                        placeholder: NetworkImage('https://logo.clearbit.com/${e['company']}'), 
                        image:   NetworkImage('https://logo.clearbit.com/${e['company']}'),
                        imageErrorBuilder:(context, error, stackTrace) {
                          return  Image.network('https://media.istockphoto.com/vectors/broken-file-line-icon-vector-id1146597753?k=6&m=1146597753&s=612x612&w=0&h=OM5uYm7mpD3dW3S3nSHDwIwy5kbIQcIEW9i46HKTahM='); 
                        },):Container(),
                  // child: Image(
                  //   image: AssetImage(
                  //     recentJobs[0].companyImage,
                  //   ),
                  //   width: 48,
                  //   height: 48,
                  // ),
                ),
                const SizedBox(width: 8),
                Container(
                  //width: 100,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        e['Jobtitle'],
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.place_outlined,
                            size: 20,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            e['jobLocation'],
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          const SizedBox(width: 16),
                          const Icon(
                            Icons.card_travel_rounded,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            e['jobType'],
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                         List<String> users=[e['uid'],FirebaseAuth.instance.currentUser!.uid];
                    String chatRoomID=getChatRoomID(e['uid'], FirebaseAuth.instance.currentUser!.uid);
                    Map<String,dynamic> chatRoomMap={
                      "users":users,
                      "chatRoomID":chatRoomID
                    };
                    ChatRepo.createConversation(chatRoomID, chatRoomMap);
                     final Message chat = chats[0];
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Conversation(chatRoomID: chatRoomID,chatWith: e['uid'])));
                      },
                      child: Icon(Icons.message)),
                    Text(
                      " ",
                      //e['jobID'],
                      style: Theme.of(context).textTheme.bodyMedium,
                    )
                  ],
                )
              ],
            ),
          ),
        );
        }).toList()); 
      }else{
        return CircularProgressIndicator();
      }
    }
      ),
    );
   }
   getChatRoomID(String a,String b){
    if(a.substring(0,1).codeUnitAt(0)>b.substring(0,1).codeUnitAt(0)){
      return "$a\_$b";
    }else{
      return "$b\_$a";
    }
  }
}
