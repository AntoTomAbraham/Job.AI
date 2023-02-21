import 'package:flutter/material.dart';
import 'package:flutter_job_seeking/core/theme/app_color.dart';
import 'package:get/get.dart';
import 'package:timeline_tile/timeline_tile.dart';

class AppliedStatus extends StatefulWidget {
  const AppliedStatus({super.key});

  @override
  State<AppliedStatus> createState() => _AppliedStatusState();
}

class _AppliedStatusState extends State<AppliedStatus> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: 
    SingleChildScrollView(
      child: Container(
        height: Get.height*.1,
        child: Column(children: [
          TimelineTile(
            indicatorStyle: IndicatorStyle(
              color: AppColor.primaryColor,
              height: 30,
              width: 30,
              ),
              isFirst: true,
              endChild: Container(height: 50,width: 50),
              
          )
        ],)
      ),
    ),);
  }
}