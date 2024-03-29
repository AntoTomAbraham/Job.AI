import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_job_seeking/core/theme/app_color.dart';
import 'package:flutter_job_seeking/feature/home/model/job.dart';

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
  Future getJobData() async {
    print("jobData called");
    await FirebaseFirestore.instance.collection('Job').doc(widget.jobID)
    .get().then((value) async {
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
      print("this is re"+ jobPosition);
    }
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
                    child: Image(
                      image: AssetImage(
                        "assets/ic_twitter.png",
                      ),
                      width: 96,
                      height: 96,
                    ),
                  ),
                  Text(
                    jobPosition,
                    style: Theme.of(context).textTheme.headlineSmall,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    company,
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
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
                onPressed: () {},
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
                onPressed: () {},
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
}
