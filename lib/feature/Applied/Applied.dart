import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_job_seeking/Repository/JobRepo.dart';
import 'package:flutter_job_seeking/feature/Job/PostJob.dart';
import 'package:flutter_job_seeking/feature/Job/ViewmyJob.dart';
import 'package:flutter_job_seeking/feature/detail_job/presentation/detail_job_screen.dart';
import 'package:get/get.dart';

class Applied extends StatefulWidget {
  const Applied({super.key});

  @override
  State<Applied> createState() => _AppliedState();
}

class _AppliedState extends State<Applied> {
  int totalJOb=0;
  int totalhire=0;
  Future findJobs() async {
  final query=await FirebaseFirestore.instance.collection('Job').where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid).get();
  totalJOb=query.size;

  final queryy=await FirebaseFirestore.instance.collection('Job')
  .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
  .get();
  totalhire=queryy.size;
  setState(() {});
  }
  @override
  void initState() {
    findJobs();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.white,title: Text("You Applied"),elevation: 0,),
      body: Container(
        height: MediaQuery.of(context).size.height*1,
         width: MediaQuery.of(context).size.width*1,
        child: Padding(
          padding:  EdgeInsets.only(left:21.0,right: 21.0),
          child: Column(
            children: [
          SizedBox(height: 20),
            ListTile(leading: Icon(Icons.person),
                title: Text("View your Job"),
                onTap: () {
                  Navigator.push(  
                          context,  
                          MaterialPageRoute(builder: (context) => 
                          ViewmyJob())
                          ); 
                },
                ),
                ListTile(leading: Icon(Icons.account_balance_wallet_rounded),
                title: Text("Post a Job"),
                onTap: () {
                  Navigator.push(  
                          context,  
                          MaterialPageRoute(builder: (context) => 
                          PostJob())); 
                },
                ),
                ListTile(title:Text(totalJOb.toString()),subtitle: Text("No of Jobs Posted"),),
                // ListTile(title:Text(totalhire.toString()),subtitle: Text("No of candidates hired"),),
                Container(height: 400-90+70,
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance.collection('Apply').where('uid',isEqualTo: FirebaseAuth.instance.currentUser!.uid).snapshots(),
                        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
                          if(!snapshot.hasData){
                            return Container();
                          }else if(snapshot.connectionState==ConnectionState.waiting){
                            return CircularProgressIndicator();
                          }
                          else{
                            return ListView(children: snapshot.data!.docs.map((e) {
          return InkWell(
          onTap: () {
            Navigator.push(
                        context, MaterialPageRoute(builder: (BuildContext context) => DetailJobScreen(jobID: 'S4VyrnXYe8X9ywM2888b') ));
          },
          child: StreamBuilder(
            stream: FirebaseFirestore.instance.collection('Job')
            .where('jobID',isEqualTo:e['jobID'] )
            .where('isOpen',isEqualTo: true)
            .snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
            if(snapshot.connectionState==ConnectionState.waiting){
              return Container();
            }else if(!snapshot.hasData){
              return  Container();
            }else{
              return ListTile(
                //enabled: snapshot.data!.docs.single.get('isOpen'),
                leading: snapshot.data!.docs.single.get('company').isNotEmpty ? FadeInImage(
                        placeholder: NetworkImage('https://logo.clearbit.com/${snapshot.data!.docs.single.get('company')}'), 
                        image:   NetworkImage('https://logo.clearbit.com/${snapshot.data!.docs.single.get('company')}'),
                        imageErrorBuilder:(context, error, stackTrace) {
                          return  Image.network('https://media.istockphoto.com/vectors/broken-file-line-icon-vector-id1146597753?k=6&m=1146597753&s=612x612&w=0&h=OM5uYm7mpD3dW3S3nSHDwIwy5kbIQcIEW9i46HKTahM='); 
                        },):Container(),
                title: Text(snapshot.data!.docs.single.get('Jobtitle')),
                subtitle: Text(snapshot.data!.docs.single.get('company').toString().toUpperCase().split('.')[0]),
                );
            }
          })
        );
        }).toList());
                          }
                        }
  ),
                ),
      ],
      ),
        ),),);
  }
}