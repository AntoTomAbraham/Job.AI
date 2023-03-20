import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:d_chart/d_chart.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_job_seeking/core/theme/app_color.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';


class jobAnalytics extends StatefulWidget {
  String JobID;
  jobAnalytics({required this.JobID});

  @override
  State<jobAnalytics> createState() => _jobAnalyticsState();
}
class _jobAnalyticsState extends State<jobAnalytics> {
  //List count=[];
  int len=0;
  int totalApp=0;
  int applLen=0;
  Future getInsight() async {
    print("Getting Insights");
    //Total Views
   await FirebaseFirestore.instance.collection('Job').doc(widget.JobID)
    .get().then((value) async {
      if(value.exists){
        setState(() {
          len=value.data()!['view'];
        });
      }
    });

  //Total Application
  await FirebaseFirestore.instance.collection('Apply').doc().get().then((value) async {
      print("Getting job appp");
      if(value.exists && value.data()!['jobID']==widget.JobID){
        print('Found');
        totalApp+=1;
        setState(() {});
      }
    });
    }

  @override
  void initState() {
    getInsight();
    // TODO: implement initState
    super.initState();
  }
  List month=["January","February","March","April","May","June","July","August","September","October","November","December"];
  @override
  Widget build(BuildContext context) {
    //print(dat.length);
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Text(len.toString(),style: GoogleFonts.poppins(fontSize: 28),),
                    Text('Total views',style: GoogleFonts.poppins(fontSize: 12),),
                  ],
                ),
                Column(
                  children: [
                    Text(totalApp.toString(),style: GoogleFonts.poppins(fontSize: 28),),
                    Text('Total application',style: GoogleFonts.poppins(fontSize: 12),),
                  ],
                ),
              ],
            ),
          ),
          Container(
            height: Get.height*.33,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 1,
                shadowColor: Colors.white60,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left:8.0),
                      child: Row(
                        children: [
                          Text("${month[DateTime.now().month-1]} view Analytics ",style: GoogleFonts.poppins(fontSize: 12),),
                          Icon(Icons.analytics_outlined)
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
                          print(DateTime.now().toString().split('-')[1]);
                          return {
                            'domain':e.data()['Date'].toString().split('-')[0],
                            'measure':e.data()['count'],
                          };
                        }).toList();
                        print(list);
                        return 
                        //AspectRatio(
                          //aspectRatio: 16/3,
                          Container(
                            height: Get.height*.25,
                            width: Get.width*.8,
                          child: DChartBar(
                              data:[{
                              'id':'Bar',
                              'data':list
                            }],
                            axisLineColor: AppColor.primaryColor,
                           animate: true,
                            barColor: ((barData, index, id) => AppColor.primaryColor),
                            showBarValue: true,
                          ),
                        );
                    }),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height:40), 
         Card(
          elevation: 1,
          shadowColor: Colors.white60,
           child: Column(
             children: [
              Padding(
                      padding: const EdgeInsets.only(left:8.0),
                      child: Row(
                        children: [
                          Text(" Views v/s Application",style: GoogleFonts.poppins(fontSize: 12),),
                          Icon(Icons.data_exploration_outlined)
                        ],
                      ),
                    ),
               Container(
                height: Get.height*.17,
                 child: DChartPie(
                 data: [
                     {'domain': 'Applied', 'measure': applLen},
                     {'domain': 'Views', 'measure': len},
                 ],
                 fillColor: (pieData, index) => AppColor.primaryColor,
                 labelLineColor: Colors.black,
                 labelPosition: PieLabelPosition.outside,
                 pieLabel: (pieData, index) {
                   return "${pieData['domain'] +" - "+ pieData['measure'].toString()}";
                 },
                //  donutWidth: 30,
                //  labelColor: Colors.white,
                 animate: true,
                showLabelLine: true,
         ),
               ),
             ],
           ),
         ),
    ],),
      )),);
  }
}