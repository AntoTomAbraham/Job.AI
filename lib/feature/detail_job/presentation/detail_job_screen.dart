import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_job_seeking/Models/message_model.dart';
import 'package:flutter_job_seeking/Repository/ApplicationRepo.dart';
import 'package:flutter_job_seeking/Repository/ChatRepo.dart';
import 'package:flutter_job_seeking/Repository/JobRepo.dart';
import 'package:flutter_job_seeking/Repository/ProfileRepo.dart';
import 'package:flutter_job_seeking/core/theme/app_color.dart';
import 'package:flutter_job_seeking/feature/Chat/Conversation.dart';
import 'package:flutter_job_seeking/feature/Job/Viewapplicants.dart';
import 'package:flutter_job_seeking/feature/home/model/job.dart';
import 'package:google_fonts/google_fonts.dart';

enum _Tab {
  requirement,
  about,
}

class DetailJobScreen extends StatefulWidget {
  String jobID;
  DetailJobScreen({required this.jobID});
  //const DetailJobScreen({super.key});

  @override
  State<DetailJobScreen> createState() => _DetailJobScreenState();
}

class _DetailJobScreenState extends State<DetailJobScreen> {
  final selectedTab = ValueNotifier(_Tab.requirement);
  String jobPosition="";
  String desc="";
  String company="";
  String jobLocation="";
  String salary="";
  String workPlaceType="";
  List<dynamic> req=[];
  String uid="";
  String data="";
  Future getJobData() async {
    print("jobData called");
    await FirebaseFirestore.instance.collection('Job').doc(widget.jobID)
    .get().then((value) async {
    print(value);
    print(value.exists);
    if(value.exists){
      setState(() {
        jobPosition=value.data()!['Jobtitle'];
        desc=value.data()!['JobDesc'];
        company=value.data()!['company'];
        jobLocation=value.data()!['jobLocation'];
        salary=value.data()!['salary'];
        workPlaceType=value.data()!['workPlaceType'];
        req=value.data()!['requirements'];
        uid=value.data()!['uid'];
      });
      print(desc);
      print("this is re"+ jobPosition);
    }
 });
 final docUser=await FirebaseFirestore.instance.collection('users').doc(uid).get().then((val){return val.data()!['name'];});
 setState(() {
  data=docUser;
    print(data);
 });
  }
 
 
 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getJobData();
  }

  @override
  Widget build(BuildContext context) {
    //Job job = ModalRoute.of(context)?.settings.arguments as Job;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          splashRadius: 24,
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        title: Text(
          "Details",
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            splashRadius: 24,
            icon: const Icon(
              Icons.bookmark_border_rounded,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    margin: const EdgeInsets.symmetric(vertical: 16),
                      width: 96,
                      height: 96,
                      child: company.isNotEmpty ? FadeInImage(
                        placeholder: NetworkImage('https://logo.clearbit.com/$company'), 
                        image:   NetworkImage('https://logo.clearbit.com/$company'),
                        imageErrorBuilder:(context, error, stackTrace) {
                          return  Image.network('https://media.istockphoto.com/vectors/broken-file-line-icon-vector-id1146597753?k=6&m=1146597753&s=612x612&w=0&h=OM5uYm7mpD3dW3S3nSHDwIwy5kbIQcIEW9i46HKTahM='); 
                        },):Container()
                      
                  ),
                  Text(
                    jobPosition,
                    style: Theme.of(context).textTheme.headlineSmall,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    company.toString().toUpperCase().split('.')[0],
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  InkWell(
                    onTap: () {
                    List<String> users=[uid,FirebaseAuth.instance.currentUser!.uid];
                    String chatRoomID=getChatRoomID(uid, FirebaseAuth.instance.currentUser!.uid);
                    Map<String,dynamic> chatRoomMap={
                      "users":users,
                      "chatRoomID":chatRoomID
                    };
                    ChatRepo.createConversation(chatRoomID, chatRoomMap);
                     final Message chat = chats[0];
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>Conversation(chatRoomID: chatRoomID,chatWith: uid)));
                    //create chat room = send user to conversation screen =
                  },
                  child: Chip(deleteIcon: Icon(Icons.person,color: AppColor.primaryColor,),onDeleted: (){},label: Text(data,style: GoogleFonts.poppins(color: AppColor.primaryColor)),backgroundColor: AppColor.primarySwatch.shade50)),
                  const SizedBox(height: 32),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: AppColor.primaryColor.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(
                              Icons.place_outlined,
                              color: AppColor.primaryColor,
                              size: 28,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            jobLocation,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(color: Colors.grey),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: AppColor.primaryColor.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(
                              Icons.attach_money_rounded,
                              color: AppColor.primaryColor,
                              size: 28,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "\₹${salary} / annum",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(color: Colors.grey),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: AppColor.primaryColor.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(
                              Icons.card_travel_rounded,
                              color: AppColor.primaryColor,
                              size: 28,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            workPlaceType,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(color: Colors.grey),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  ValueListenableBuilder(
                    valueListenable: selectedTab,
                    builder: (context, value, child) {
                      return Container(
                        height: 40,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: AppColor.primaryColor.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Stack(
                          children: [
                            AnimatedPositioned(
                              left: value == _Tab.requirement
                                  ? 0
                                  : (MediaQuery.of(context).size.width - 48) /
                                      2,
                              duration: const Duration(milliseconds: 300),
                              child: Container(
                                height: 40,
                                width:
                                    (MediaQuery.of(context).size.width - 48) /
                                        2,
                                decoration: BoxDecoration(
                                  color: AppColor.primaryColor,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          selectedTab.value = _Tab.requirement;
                                        });
                                      },
                                      child: Container(
                                        height: 40,
                                        color: Colors.transparent,
                                        alignment: Alignment.center,
                                        child: Text(
                                          "Requirement",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium
                                              ?.copyWith(color: Colors.white),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          selectedTab.value = _Tab.about;
                                        });
                                      },
                                      child: Container(
                                        height: 40,
                                        color: Colors.transparent,
                                        alignment: Alignment.center,
                                        child: Text(
                                          "About",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium
                                              ?.copyWith(color: Colors.white),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  ValueListenableBuilder(
                    valueListenable: selectedTab,
                    builder: (context, value, child) {
                      return value == _Tab.requirement
                          ? Container(height: 200,
                            child: ListView(children: req.map((e){
                              return Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                          Text(
                                        "- ",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge
                                            ?.copyWith(height: 1.4),
                                      ),
                                      Expanded(
                                        child: Text(
                                          e.toString(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge
                                              ?.copyWith(height: 1.4),
                                        ),
                                      )
                              ],);
                            }).toList(),),
                          )
                          // ListView.separated(
                          //     shrinkWrap: true,
                          //     physics: const NeverScrollableScrollPhysics(),
                          //     itemCount: job.requirements.length,
                          //     separatorBuilder: (_, __) {
                          //       return const SizedBox(height: 10);
                          //     },
                          //     itemBuilder: (context, index) {
                          //       return Row(
                          //         crossAxisAlignment: CrossAxisAlignment.start,
                          //         children: [
                                    // Text(
                                    //   "- ",
                                    //   style: Theme.of(context)
                                    //       .textTheme
                                    //       .bodyLarge
                                    //       ?.copyWith(height: 1.4),
                                    // ),
                                    // Expanded(
                                    //   child: Text(
                                    //     job.requirements[index],
                                    //     style: Theme.of(context)
                                    //         .textTheme
                                    //         .bodyLarge
                                    //         ?.copyWith(height: 1.4),
                                    //   ),
                                    // )
                          //         ],
                          //       );
                          //     },
                          //   )
                          : Text(
                              desc,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(height: 1.4),
                            );
                    },
                  ),
                ],
              ),
            ),
          uid==FirebaseAuth.instance.currentUser!.uid ?  
          SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 56,
              child: ElevatedButton(
                onPressed: () {
                   Navigator.push(  
                  context,  
                  MaterialPageRoute(builder: (context) => Viewapplicants(jobID: widget.jobID)
                  ));
                },
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                )),
                child: Text(
                  "View Applicants",
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(color: Colors.white),
                ),
              ),
            ):
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 56,
              child: ElevatedButton(
                onPressed: () {
                  ApplicationRepo.apply(jobID: widget.jobID , coverLetter: "sklkfj");
                },
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                )),
                child: Text(
                  "Apply Now",
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(color: Colors.white),
                ),
              ),
            )
          ],
        ),
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
