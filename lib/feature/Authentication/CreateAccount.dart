import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chip_tags/flutter_chip_tags.dart';
import 'package:flutter_job_seeking/Repository/ProfileRepo.dart';
import 'package:flutter_job_seeking/feature/home_page.dart';
import 'package:image_picker/image_picker.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({super.key});

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  String _currentSelectedValue="Software Engineer";
  String _qua="BCA";
  String _exp="0-1";
  TextEditingController nameController=TextEditingController();
  TextEditingController collegeController=TextEditingController();
  var _pos=["Software Engineer","Backend Developer","Designer","DBA","Data Scientist"];
  var Qua=["BCA","BTECH","Self Taught","Arts","Commerce"];
  var Exp=["0-1","1+","2+","4+","6+"];
  List<String> _myListCustom=[];
  XFile? _image;    
  String _uploadedFileURL="";   

  Future chooseFile() async {    
   _image= (await ImagePicker().pickImage(source: ImageSource.gallery))!; 
   setState(() {});   
 }
 String imageUrl="";
 Future _upload() async {
  print("upload");
  print(_image!.path);
  if(_image!=null){
    print("uploading image");
    Reference referenece=FirebaseStorage.instance.ref();
    Reference referenceDirImage=referenece.child('images');
    Reference referenceUpload=referenceDirImage.child(_image!.path);
    await referenceUpload.putFile(File(_image!.path));
    _uploadedFileURL=await referenceUpload.getDownloadURL();
    print(_uploadedFileURL);
   }
 } 

 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.white,elevation: 0,
        leading: GestureDetector
      (onTap: () {
        Navigator.pop(context);
      },child: Icon(Icons.arrow_back))),
      body: 
    SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left:8.0,right:8),
        child: Container(
          height: MediaQuery.of(context).size.height*1,
          child: Padding(
          padding: const EdgeInsets.only(left:8.0,right:8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              //SizedBox(height: 40),
               Text(
              "Register your Account",
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
              SizedBox(height: 10),
                    TextField(
              controller:nameController,
              decoration: InputDecoration(
                helperText: "Enter your name",
                hintText: "Name",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                    borderSide: BorderSide.none),
                fillColor: Theme.of(context).primaryColor.withOpacity(0.1),
                filled: true,
                prefixIcon: Icon(Icons.person),
              ),
              
            ),
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
              isEmpty: _currentSelectedValue == "",
              child: DropdownButtonHideUnderline(
                child: DropdownButton(
                  value: _currentSelectedValue,
                  isDense: true,
                  onChanged: (newValue) {
                    setState(() {
                      _currentSelectedValue = newValue.toString();
                      state.didChange(newValue);
                    });
                  },
                  items: _pos.map((String value) {
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
           FormField<String>(
          builder: (FormFieldState<String> state) {
            return InputDecorator(
              decoration: InputDecoration(
                helperText: "Enter your qualification",
                fillColor: Theme.of(context).primaryColor.withOpacity(0.1),
                filled: true,
                  //labelStyle: textStyle,
                  errorStyle: TextStyle(color: Colors.redAccent, fontSize: 16.0),
                  hintText: 'Qualification',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                    borderSide: BorderSide.none
                  )),
              isEmpty: _qua == "",
              child: DropdownButtonHideUnderline(
                child: DropdownButton(
                  value: _qua,
                  isDense: true,
                  onChanged: (newValue) {
                    setState(() {
                      _qua = newValue.toString();
                      state.didChange(newValue);
                    });
                  },
                  items: Qua.map((String value) {
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
            FormField<String>(
          builder: (FormFieldState<String> state) {
            return InputDecorator(
              decoration: InputDecoration(
                helperText: "Enter your job experience",
                fillColor: Theme.of(context).primaryColor.withOpacity(0.1),
                filled: true,
                  //labelStyle: textStyle,
                  errorStyle: TextStyle(color: Colors.redAccent, fontSize: 16.0),
                  hintText: 'Experience',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                    borderSide: BorderSide.none
                  )),
              isEmpty: _exp == "",
              child: DropdownButtonHideUnderline(
                child: DropdownButton(
                  value: _exp,
                  isDense: true,
                  onChanged: (newValue) {
                    setState(() {
                      _currentSelectedValue = newValue.toString();
                      state.didChange(newValue);
                    });
                  },
                  items: Exp.map((String value) {
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
            TextField(
              controller: collegeController,
              decoration: InputDecoration(
                helperText: "Enter your college name",
                hintText: "College",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                    borderSide: BorderSide.none),
                fillColor: Theme.of(context).primaryColor.withOpacity(0.1),
                filled: true,
                prefixIcon: Icon(Icons.person),
              ),
              obscureText: true,
            ),
             ChipTags(
  list: _myListCustom,
  chipColor: Colors.black,
  iconColor: Colors.white,
  textColor: Colors.white,
  chipPosition: ChipPosition.below,
  decoration: InputDecoration(
    hintText: "Skills",
    helperText: "Enter your skills",
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
 TextButton(child: Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
  Icon(Icons.camera),Text(" Upload your Profile image")
 ],),onPressed: (() async {
   await chooseFile();     
 await _upload(); 
 }),),
            TextButton(
              onPressed: () {}, child: GestureDetector(
              onTap:(() {
                ProfileRepo().CreateProfile(pos:_currentSelectedValue,name: nameController.text, qualification: _qua, college: collegeController.text, experience: _exp,image: _uploadedFileURL,skills: _myListCustom);
              Navigator.push(  
                  context,  
                  MaterialPageRoute(builder: (context) => 
                  HomePage())); 
              } 
                ),child: Text("Save")))
          ],),
        ),),
      ),
    ),);
  }
}