//import 'package:firebase_auth/firebase_auth.dart';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_job_seeking/Models/Messages.dart';
import 'package:flutter_job_seeking/Models/message_model.dart';
import 'package:flutter_job_seeking/Models/user_model.dart';
import 'package:flutter_job_seeking/Repository/ChatRepo.dart';

class Conversation extends StatefulWidget {
  final User user;
  final String chatWith;

  Conversation({required this.user,required this.chatWith});

  @override
  _ConversationState createState() => _ConversationState();
}

class _ConversationState extends State<Conversation> {

  final TextEditingController controller=TextEditingController();
  String ChatroomID="",messageID="";

  getINFO(){
    ChatroomID=getChatID(widget.chatWith, "sdkflf");
  }

  getChatID(String a,String b){
    if(a.substring(0,1).codeUnitAt(0)>b.substring(0,1).codeUnitAt(0)){
      return "$b\_$a";
    }else{
      return "$a\_$b";
    }
  }

  dothisOnLaunch() async {
    await getINFO();
    getAndsetMessage();
  }

  addMessage(bool sentClick) async{
    if(controller.text.isNotEmpty){
      String message=controller.text;
      var lastMessageTimeStamp=DateTime.now();
      Map<String,dynamic> messageInfoMap={
        "Message":message,
        "sendBY":"",
        "ts":lastMessageTimeStamp,
      };
      if(messageID==""){
        messageID=Random().nextInt(12).toString();
      }
      ChatRepo().addMessage(ChatroomID, messageID, messageInfoMap).then((value) {

      });
      controller.clear();
    }
  }

  getAndsetMessage() async{

  }

  @override
  void initState() {
    //dothisOnLaunch();
    // TODO: implement initState
    super.initState();
   
  }

  _chatBubble(Message message, bool isMe, bool isSameUser) {
    if (isMe) {
      return Column(
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
              child: Text(
                message.text,
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
                      message.time,
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
      );
    } else {
      return Column(
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
              child: Text(
                message.text,
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
                      message.time,
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
              onChanged: (value) {
                setState(() {
                  message=value;
                });
              },
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
              //message.trim().isEmpty?null: ChatRepo.sendMessage(message: message,sentUser: '7PMgKkLTfVMGulh7KuHQcYIcXpE2');
              controller.clear();
              message="";
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
        brightness: Brightness.dark,
        centerTitle: true,
        title: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            children: [
              TextSpan(
                  text: widget.user.name,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  )),
              TextSpan(text: '\n'),
              widget.user.isOnline ?
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
            // child:StreamBuilder<List<Messages>>(builder: (context, snapshot){
            //   final message=snapshot.data;
            //   return message==null? Text("Nothing"): 
            //   ListView.builder(
            //     itemCount: message.length,
            //     physics: BouncingScrollPhysics(),
            //     itemBuilder: (context, index) {
            //     },);
            // } )
            child: ListView.builder(
              reverse: true,
              padding: EdgeInsets.all(20),
              itemCount: messages.length,
              itemBuilder: (BuildContext context, int index) {
                final Message message = messages[index];
                final bool isMe = message.sender.id == currentUser.id;
                final bool isSameUser = prevUserId == message.sender.id;
                prevUserId = message.sender.id;
                return _chatBubble(message, isMe, isSameUser);
              },
            ),
          ),
          _sendMessageArea(),
        ],
      ),
    );
  }
}