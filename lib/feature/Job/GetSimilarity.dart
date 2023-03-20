import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:flutter_job_seeking/Repository/similarityRepo.dart';
import 'package:lottie/lottie.dart';
//import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class GetSimilarity extends StatefulWidget {
  String resume;
  String desc;
  GetSimilarity({required this.resume,required this.desc});

  @override
  State<GetSimilarity> createState() => _GetSimilarityState();
}

class _GetSimilarityState extends State<GetSimilarity> {
  //const ResumeViewer({super.key});
  String ratio="";
  getSimilarityData()async {
    // setState(() {
      ratio=await SimilarityRepo.fetchMatching(resume: widget.resume, desc: "Flutter Developer");
    //});
    print(ratio);
  }
  @override
  void initState() {
    getSimilarityData();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height:MediaQuery.of(context).size.height*1,
        child:ratio==""? Center(child: 
        Lottie.asset('assets/analyse.json',
         width: 200,
         height: 200,
         fit: BoxFit.fill,))
        :Center(child: Text(ratio)),       
          ),);
  }
}