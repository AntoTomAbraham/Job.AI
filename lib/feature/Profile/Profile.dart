import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_job_seeking/Helper/DialogHelper.dart';
import 'package:flutter_job_seeking/Repository/ProfileRepo.dart';
import 'package:flutter_job_seeking/feature/Authentication/CreateAccount.dart';
import 'package:flutter_job_seeking/feature/Authentication/LoginPage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

String name="";
String pos="";
String image="https://th.bing.com/th/id/OIP.ZT-Tw8tYy38htqch69vsGQAAAA?pid=ImgDet&rs=1";
String res="";
Future getUserData() async {
 await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid)
 .get().then((value) async {
    if(value.exists){
      setState(() {
        name=value.data()!['name'];
        pos=value.data()!['position'];
        image=value.data()!['profile'];
        res=value.data()!['resume'];
      });
      print("this is re"+ res);
    }
 });
}

  File? _image;    
  String _uploadedFileURL="";   

  Future chooseFile() async {    
   FilePickerResult? result = await FilePicker.platform.pickFiles();

if (result != null) {
  _image = File(result.files.single.path as String);
} else {
  // User canceled the picker
}
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
  void initState() {
    //getUserData();
    // TODO: implement initState
    super.initState();
    getUserData();
    print(res);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(onTap: (){
          DialogHelper.hideDialog();
        },child: Icon(Icons.menu)),
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        title: const Text("PROFILE"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              //DialogHelper.showLoadingDialog();
              //DialogHelper.showDialog("Image Uploaded Successfully", false);
              },
            icon: const Icon(Icons.settings_rounded),
          )
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(10),
        children: [
          // COLUMN THAT WILL CONTAIN THE PROFILE
          Column(
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(
                  image,
                ),
              ),
              SizedBox(height: 10),
              Text(
                name,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(pos)
            ],
          ),
          const SizedBox(height: 25),
          const SizedBox(height: 10),
          SizedBox(
            height: 180,
            child: ListView.separated(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final card = profileCompletionCards[index];
                return SizedBox(
                  width: 160,
                  child: Card(
                    shadowColor: Colors.black12,
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () async {
                              try {
                                 if (await canLaunchUrl(Uri.parse(res))) {
                                await launchUrl(Uri.parse(res));
                              }                          
                              } catch (e) {
                               print(e); 
                              }
                                    // Navigator.pushReplacement(
                              //       context, MaterialPageRoute(builder: (BuildContext context) => Web(url: res)));
                            },
                            child: Icon(
                              card.icon,
                              size: 30,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            card.title == "Set Your Profile Details" && name!="" ?"Edit Your Profile Details":card.title,
                            textAlign: TextAlign.center,
                          ),
                          const Spacer(),
                          ElevatedButton(
                            onPressed: () async{
                              if(card.icon==CupertinoIcons.person_circle){
                                  Navigator.pushReplacement(
                                    context, MaterialPageRoute(builder: (BuildContext context) => CreateAccount()));
                              }else if(card.icon==CupertinoIcons.doc){
                                await chooseFile();
                                await _upload();
                                await ProfileRepo().uploadResume(resume: _uploadedFileURL);
                                DialogHelper.showDialog("Resume Updated", true);
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                            child: Text(card.buttonText),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) =>
                  const Padding(padding: EdgeInsets.only(right: 5)),
              itemCount: profileCompletionCards.length,
            ),
          ),
          const SizedBox(height: 35),
          ...List.generate(
            customListTiles.length,
            (index) {
              final tile = customListTiles[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: Card(
                  elevation: 4,
                  shadowColor: Colors.black12,
                  child: ListTile(
                    onTap: () {
                      if(tile.icon==CupertinoIcons.arrow_right_arrow_left){
                        print("working");
                        FirebaseAuth.instance.signOut();
                        
                    Navigator.pushReplacement(
                        context, MaterialPageRoute(builder: (BuildContext context) => LoginPage()));
                        //Material
                      }
                    },
                    leading: Icon(tile.icon),
                    title: Text(tile.title),
                    trailing: const Icon(Icons.chevron_right),
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}

class ProfileCompletionCard {
  final String title;
  final String buttonText;
  final IconData icon;
  ProfileCompletionCard({
    required this.title,
    required this.buttonText,
    required this.icon,
  });
}

List<ProfileCompletionCard> profileCompletionCards = [
  ProfileCompletionCard(
    title: "Set Your Profile Details",
    icon: CupertinoIcons.person_circle,
    buttonText: "Continue",
  ),
  ProfileCompletionCard(
    title: "Upload your resume",
    icon: CupertinoIcons.doc,
    buttonText: "Upload",
  ),
  // ProfileCompletionCard(
  //   title: "Add your skills",
  //   icon: CupertinoIcons.square_list,
  //   buttonText: "Add",
  // ),
];

class CustomListTile {
  final IconData icon;
  final String title;
  CustomListTile({
    required this.icon,
    required this.title,
  });
}

List<CustomListTile> customListTiles = [
  CustomListTile(
    icon: Icons.insights,
    title: "Activity",
  ),
  CustomListTile(
    icon: Icons.location_on_outlined,
    title: "Location",
  ),
  CustomListTile(
    title: "Notifications",
    icon: CupertinoIcons.bell,
  ),
  CustomListTile(
    title: "Logout",
    icon: CupertinoIcons.arrow_right_arrow_left,
  ),
];