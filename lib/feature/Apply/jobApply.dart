import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_job_seeking/Repository/ApplicationRepo.dart';
import 'package:flutter_job_seeking/Repository/ToastRepo.dart';
import 'package:flutter_job_seeking/feature/home/presentation/home_screen.dart';
import 'package:flutter_job_seeking/feature/home_page.dart';

class JobApply extends StatelessWidget {
  String jobID;
  JobApply({required this.jobID});
  //const JobApply({super.key});
  TextEditingController nameController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      title: Text("Apply now"),
      backgroundColor: Colors.white,
      elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left:21.0,right: 21.0),
        child: SingleChildScrollView(
          child: Container(
          child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text("Enter you Cover letter here"),
              TextField(
                controller: nameController,
                maxLines: 15,
            ),
            SizedBox(height: 20),
              ElevatedButton(
              onPressed: ()async {
                 ApplicationRepo.apply(jobID: jobID , coverLetter: nameController.text).whenComplete((){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> HomePage()));
                  ToastRepo.sendSuccessToast("Job Applied Successfully");
                    //ApplicationRepo.apply(jobID: widget.jobID , coverLetter: "sklkfj");
                 });
              },
            
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  "Apply Now!!",
                  style: TextStyle(fontSize: 20),
                ),
              ),
              style: ElevatedButton.styleFrom(
                shape: StadiumBorder(),
                padding: EdgeInsets.symmetric(vertical: 16),
              ),
            ),
            ],
          ),
            ),
        ),
      ),);
  }
}