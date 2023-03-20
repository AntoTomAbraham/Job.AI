//import 'package:firebase_auth/firebase_auth.dart';
import 'dart:math';
//import 'package:flutter_string_encryption/flutter_string_encryption.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_job_seeking/Models/Messages.dart';
import 'package:flutter_job_seeking/Models/message_model.dart';
import 'package:flutter_job_seeking/Models/user_model.dart';
import 'package:flutter_job_seeking/Repository/ChatRepo.dart';
import 'package:flutter_job_seeking/Repository/Myencryption.dart';
import 'package:flutter_job_seeking/feature/VideoCall/VideoCall.dart';
import 'package:get/get.dart';

class Conversation extends StatefulWidget {
  //final User user;
  final String chatWith;
  final String chatRoomID;

  Conversation({required this.chatWith,required this.chatRoomID});

  @override
  _ConversationState createState() => _ConversationState();
}

class _ConversationState extends State<Conversation> {

  final TextEditingController controller=TextEditingController();
  //final cryptor = new PlatformStringCryptor();
 

  sendMessage() async {
    print("inside func 1");
    print(controller.text);
    // final String salt = await cryptor.generateSalt();
    // final String key = await cryptor.generateKeyFromPassword("JOBAI", salt);
    // final String encrypted = await cryptor.encrypt(controller.text, key);
    if(controller.text.isNotEmpty){
      String mess=MyEncryptionDecryption.encryptAES(controller.text);
      print("is not empty");
    Map<String,dynamic> messageMap ={
      "message":controller.text,
      "sendby":FirebaseAuth.instance.currentUser!.uid,
      "time":DateTime.now().millisecondsSinceEpoch
    };
    await ChatRepo.sendmessages(widget.chatRoomID, messageMap);
    }
  }
  ScrollController scrollcontroller = ScrollController();
  
  @override
  void initState() {
  //   final position = scrollcontroller.position.maxScrollExtent;
  //  scrollcontroller.jumpTo(position);
    ChatRepo.getMessages(widget.chatRoomID).then((val){
      //chatMessageStream=val;
      setState(() {});
    });
    // TODO: implement initState
    super.initState();
   
  }
  

  _chatBubble(String message, bool isMe,bool isSameUser) {
    if (isMe) {
      return Padding(
        padding: const EdgeInsets.only(right:14.0),
        child: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.topRight,
              child: Container(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.80,
                ),
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                    ),
                  ],
                ),
                child: SelectableText(
                  message,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            !isSameUser
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        " ",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.black45,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 5,
                            ),
                          ],
                        ),
                        child: CircleAvatar(
                          radius: 15,
                          backgroundImage: NetworkImage('https://th.bing.com/th/id/OIP.qP3TMGjdzOhWY3U370U_XAHaJR?w=149&h=186&c=7&r=0&o=5&dpr=1.5&pid=1.7'),
                        ),
                      ),
                    ],
                  )
                : Container(
                    child: null,
                  ),
          ],
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.only(left:14.0),
        child: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.topLeft,
              child: Container(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.80,
                ),
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                    ),
                  ],
                ),
                child: SelectableText(
                  message,
                  style: TextStyle(
                    color: Colors.black54,
                  ),
                ),
              ),
            ),
            !isSameUser
                ? Row(
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 5,
                            ),
                          ],
                        ),
                        child: CircleAvatar(
                          radius: 15,
                          backgroundImage: NetworkImage('https://th.bing.com/th/id/OIP.qP3TMGjdzOhWY3U370U_XAHaJR?w=149&h=186&c=7&r=0&o=5&dpr=1.5&pid=1.7'),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        " ",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.black45,
                        ),
                      ),
                    ],
                  )
                : Container(
                    child: null,
                  ),
          ],
        ),
      );
    }
  }

  _sendMessageArea() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8),
      height: 70,
      color: Colors.white,
      child: Row(
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.photo),
            iconSize: 25,
            color: Theme.of(context).primaryColor,
            onPressed: () {},
          ),
          Expanded(
            child: TextField(
              controller: controller,
              // onChanged: (value) {
              //   setState(() {
              //     message=value;
              //   });
              // },
              decoration: InputDecoration.collapsed(
                hintText: 'Send a message..',
              ),
              textCapitalization: TextCapitalization.sentences,
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            iconSize: 25,
            color: Theme.of(context).primaryColor,
            onPressed: () {
              FocusScope.of(context).unfocus();
              print("send");
              sendMessage();
              //message.trim().isEmpty?null: ChatRepo.sendMessage(message: message,sentUser: '7PMgKkLTfVMGulh7KuHQcYIcXpE2');
              controller.clear();
              //message="";
            },
          ),
        ],
      ),
    );
  }
  String message="";
  @override
  Widget build(BuildContext context) {
    int prevUserId=0;
    return Scaffold(
      backgroundColor: Color(0xFFF6F6F6),
      appBar: AppBar(
        actions: [
          GestureDetector(onTap: (){
            Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => VideoCall(chatRoomID: widget.chatRoomID,)
                      ),
                    );
          },
          child: Icon(Icons.video_camera_front_rounded,color: Colors.white,)),
          SizedBox(width: 21)
          ],
        brightness: Brightness.dark,
        centerTitle: true,
        title: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            children: [
              TextSpan(
                  text: widget.chatWith,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  )),
              TextSpan(text: '\n'),
              true ?
              TextSpan(
                text: 'Online',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w400,
                ),
              )
              :
              TextSpan(
                text: 'Offline',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w400,
                ),
              )
            ],
          ),
        ),
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            color: Colors.white,
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance.collection('ChatRoom')
              .doc(widget.chatRoomID).collection('Chats')
              .orderBy('time',descending: false)
              .snapshots(),
            builder: (context, snapshot) {
              if(snapshot.hasData) {
               return SingleChildScrollView(
                reverse: false,
                 child: Container(
                  height: Get.height*.77,
                  //padding: EdgeInsets.only(left:16,right: 16),
                   child: ListView.builder(
                    reverse: false,
                  
                    controller: scrollcontroller,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index)  {
                      String textmessage=snapshot.data!.docs[index].data()['message'];
                      String send=snapshot.data!.docs[index].data()['sendby'];
                      // final String key =cryptor.generateKeyFromPassword("JOBAI", salt);
                      // String decrypt=async cryptor.decrypt(textmessage,key);
                      return _chatBubble(textmessage.toString(), send==FirebaseAuth.instance.currentUser!.uid,true);
                    },
                   ),
                 ),
               );
               }else{
                return Container();
               }
              },
            ),
            // child:StreamBuilder<List<Messages>>(builder: (context, snapshot){
            //   final message=snapshot.data;
            //   return message==null? Text("Nothing"): 
            //   ListView.builder(
            //     itemCount: message.length,
            //     physics: BouncingScrollPhysics(),
            //     itemBuilder: (context, index) {
            //     },);
            // } )
            // child: ListView.builder(
            //   reverse: true,
            //   padding: EdgeInsets.all(20),
            //   itemCount: messages.length,
            //   itemBuilder: (BuildContext context, int index) {
            //     final Message message = messages[index];
            //     final bool isMe = message.sender.id == currentUser.id;
            //     final bool isSameUser = prevUserId == message.sender.id;
            //     prevUserId = message.sender.id;
            //     return _chatBubble(message, isMe, isSameUser);
            //   },
            // ),
          ),
          _sendMessageArea(),
        ],
      ),
    );
  }
}