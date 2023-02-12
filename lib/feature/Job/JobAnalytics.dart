import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:d_chart/d_chart.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';


class jobAnalytics extends StatefulWidget {
  String JobID;
  jobAnalytics({required this.JobID});

  @override
  State<jobAnalytics> createState() => _jobAnalyticsState();
}
class _jobAnalyticsState extends State<jobAnalytics> {
  List count=[];
  int len=0;
  Future getInsight() async {

   //Total views
   await FirebaseFirestore.instance.collection('Job').doc(widget.JobID)
    .get().then((value) async {
      if(value.exists){
        setState(() {
          len=value.data()!['view'];
          count=value.data()!['Analytics'];
        });
      }
    });

 }
  @override
  void initState() {
    getInsight();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.white,
      elevation: 0,
      title: Text("Full analytics"),
      ),
      body: Container(child: 
      Padding(
        padding: const EdgeInsets.only(left:21.0,right:21.0),
        child: Column(children: [
          SizedBox(height: 20),
          Container(
            height: Get.height*.1,
            child: Column(
              children: [
                Text(len.toString(),style: GoogleFonts.poppins(fontSize: 28),),
                Text('Total views',style: GoogleFonts.poppins(fontSize: 12),),
              ],
            ),
          ),

          StreamBuilder(
            stream: FirebaseFirestore.instance.collection('Job').doc(widget.JobID).collection('Insights').snapshots(),
            builder: (context,AsyncSnapshot<QuerySnapshot<Map<String,dynamic>>> snapshot) {
              if(snapshot.hasError){
                return Text("SOme error");
              }
              if(snapshot.connectionState==ConnectionState.waiting){
                return CircularProgressIndicator();
              }
              if(!snapshot.hasData){
                return Text("Null");
              }
              List list=snapshot.data!.docs.map((e){
                return {
                  'domain':e.data()['Date'],
                  'measure':e.data()['count'],
                };
              }).toList();
              print(list);
              return AspectRatio(
                aspectRatio: 16/3,
                child: DChartBar(
                    data:[{
                    'id':'Bar',
                    'data':list
                  }],
                  axisLineColor: Colors.green,
                  barColor: ((barData, index, id) => Colors.green),
                  showBarValue: true,
                ),
              );
          })
    ],),
      )),);
  }
}