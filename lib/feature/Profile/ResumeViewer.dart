import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
//import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class ResumeViewer extends StatelessWidget {
  String resume;
  ResumeViewer({required this.resume});
  //const ResumeViewer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height:MediaQuery.of(context).size.height*1,
          //child: SfPdfViewer.network(resume)
          ),);
  }
}