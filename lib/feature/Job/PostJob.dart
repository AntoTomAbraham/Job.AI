import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chip_tags/flutter_chip_tags.dart';
import 'package:flutter_job_seeking/Repository/JobRepo.dart';
import 'package:flutter_job_seeking/Repository/ToastRepo.dart';
import 'package:flutter_job_seeking/feature/home_page.dart';

class PostJob extends StatefulWidget {
  @override
  State<PostJob> createState() => _PostJobState();
}

class _PostJobState extends State<PostJob> {

  TextEditingController nameController=TextEditingController();
  TextEditingController salaryController=TextEditingController();
  TextEditingController companyName=TextEditingController();
  TextEditingController desc=TextEditingController();
  TextEditingController jobID=TextEditingController();
  TextEditingController loc=TextEditingController();
  String _workPlace="Remote";
  String comp="";
  var _work=["Remote","Hybrid","On-Site"];
  String _jobType="Full-time";
  var _job=["Full-time","Part-time","Contract","Temporary","Other","Volunteer"];
  List<String>  _myListCustom=[];
  Future<void> getCompany() async {
     await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid)
 .get().then((value) async {
    if(value.exists){
      setState(() {
        companyName.text=value.data()!['company'];
        comp=value.data()!['company'];
       
      });
      print("this is re"+ companyName.text);
    }
 });
  }

  @override
  void initState() {
    getCompany();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.white,elevation: 0,title: Text("Post a Job"),),
      body: SingleChildScrollView(
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(21.0),
          child: Column(children: [
            SizedBox(height: 20),
             TextField(
                controller:nameController,
                decoration: InputDecoration(
                  helperText: "Enter Job title",
                  hintText: "Job title",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: BorderSide.none),
                  fillColor: Theme.of(context).primaryColor.withOpacity(0.1),
                  filled: true,
                  prefixIcon: Icon(Icons.person),
                ),             
              ),
              SizedBox(height: 10),
              TextField(
                controller:desc,
                minLines: 2,
                maxLines: 10,
                decoration: InputDecoration(
                  helperText: "Enter Job Description",
                  hintText: "Job Description",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: BorderSide.none),
                  fillColor: Theme.of(context).primaryColor.withOpacity(0.1),
                  filled: true,
                  prefixIcon: Icon(Icons.person),
                ),             
              ),
               SizedBox(height: 10),
              TextField(
                controller:jobID,
                decoration: InputDecoration(
                  helperText: "Enter Job ID",
                  hintText: "Job ID",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: BorderSide.none),
                  fillColor: Theme.of(context).primaryColor.withOpacity(0.1),
                  filled: true,
                  prefixIcon: Icon(Icons.person),
                ),             
              ),
               SizedBox(height: 10),
              TextField(
                controller:salaryController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  helperText: "Enter salary per annum in ₹",
                  hintText: "Salary",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: BorderSide.none),
                  fillColor: Theme.of(context).primaryColor.withOpacity(0.1),
                  filled: true,
                  prefixIcon: Icon(Icons.person),
                ),             
              ),
               SizedBox(height: 10),
              TextField(
                controller:loc,
                decoration: InputDecoration(
                  helperText: "Enter Job Location",
                  hintText: "Job Location",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: BorderSide.none),
                  fillColor: Theme.of(context).primaryColor.withOpacity(0.1),
                  filled: true,
                  prefixIcon: Icon(Icons.person),
                ),             
              ),
               SizedBox(height: 10),
              TextField(
                enabled: false,
                controller:companyName,
                decoration: InputDecoration(
                  helperText: "Enter Company name",
                  hintText: "Company",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: BorderSide.none),
                  fillColor: Theme.of(context).primaryColor.withOpacity(0.1),
                  filled: true,
                  prefixIcon: Icon(Icons.person),
                ),             
              ),
               SizedBox(height: 10),
              FormField<String>(
            builder: (FormFieldState<String> state) {
              return InputDecorator(
                decoration: InputDecoration(
                  helperText: "Enter your Job Position",
                  fillColor: Theme.of(context).primaryColor.withOpacity(0.1),
                  filled: true,
                    //labelStyle: textStyle,
                    errorStyle: TextStyle(color: Colors.redAccent, fontSize: 16.0),
                    hintText: 'Job Position',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: BorderSide.none
                    )),
                isEmpty: _workPlace == "",
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                    value: _workPlace,
                    isDense: true,
                    onChanged: (newValue) {
                      setState(() {
                       _workPlace = newValue.toString();
                        state.didChange(newValue);
                      });
                    },
                    items: _work.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              );
            },
          ),
           SizedBox(height: 10),
          FormField<String>(
            builder: (FormFieldState<String> state) {
              return InputDecorator(
                decoration: InputDecoration(
                  helperText: "Enter your Job Position",
                  fillColor: Theme.of(context).primaryColor.withOpacity(0.1),
                  filled: true,
                    //labelStyle: textStyle,
                    errorStyle: TextStyle(color: Colors.redAccent, fontSize: 16.0),
                    hintText: 'Job Position',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: BorderSide.none
                    )),
                isEmpty: _jobType == "",
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                    value: _jobType,
                    isDense: true,
                    onChanged: (newValue) {
                      setState(() {
                       _jobType = newValue.toString();
                        state.didChange(newValue);
                      });
                    },
                    items: _job.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              );
            },
          ),
           SizedBox(height: 10),
          ChipTags(
            separator: ",",
  list: _myListCustom,
  chipColor: Colors.black,
  iconColor: Colors.white,
  textColor: Colors.white,
  chipPosition: ChipPosition.below,
  decoration: InputDecoration(
    hintText: "Requirements",
    helperText: "Enter your job requirements",
                  fillColor: Theme.of(context).primaryColor.withOpacity(0.1),
                  filled: true,
                    errorStyle: TextStyle(color: Colors.redAccent, fontSize: 16.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: BorderSide.none
                    )
                    
    ),
  keyboardType: TextInputType.text,
),
 SizedBox(height: 10),
TextButton(onPressed: (){
  if(companyName.text!=null&&nameController.text!=null&&_jobType!=null&&jobID.text!=null&&desc.text!=null&&_workPlace!=null&&salaryController.text!=null&&loc.text!=null&&_myListCustom.length!=0){
  JobRepo.CreateJOB(company: companyName.text,pos: nameController.text,jobtype: _jobType,jobID: jobID.text, desc: desc.text, workPlaceType: _workPlace, salary: salaryController.text, jobLocation: loc.text,requirements: _myListCustom);
  Navigator.push(  
                  context,  
                  MaterialPageRoute(builder: (context) => 
                  HomePage()));
  }else{
    ToastRepo.sendToast("Please Enter all the fields");
  }}, child: Text("Submit"))
          ],),
        ),
      ),
    ),);
  }
}