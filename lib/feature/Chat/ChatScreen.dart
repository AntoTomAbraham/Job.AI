import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_job_seeking/Models/message_model.dart';
import 'package:flutter_job_seeking/Models/user_model.dart';
import 'package:flutter_job_seeking/feature/Chat/Conversation.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        brightness: Brightness.dark,
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.menu),
          color: Colors.black,
          onPressed: () {},
        ),
        title: Text(
          'Inbox',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            color: Colors.black,
            onPressed: () {},
          ),
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('ChatRoom')
        .where('users',arrayContains: FirebaseAuth.instance.currentUser!.uid).snapshots(),
        builder: (context, snapshot) {
          if(!snapshot.hasData){
            return Container();
          }else if(snapshot.connectionState==ConnectionState.waiting){
            return CircularProgressIndicator();
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (BuildContext context, int index) {
              final uid=snapshot.data!.docs[index].data()['users'][0]==FirebaseAuth.instance.currentUser!.uid ? 
                          snapshot.data!.docs[index].data()['users'][1]
                          :snapshot.data!.docs[index].data()['users'][0];
              print(uid);
              final Message chat = chats[index];
              return StreamBuilder(
                 stream: FirebaseFirestore.instance.collection('users')
                 .where('id',isEqualTo: uid).snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> asnapshot) {
                  if(!asnapshot.hasData){
                      return Container();
                  }else if(asnapshot.connectionState==ConnectionState.waiting){
                      return CircularProgressIndicator();
                  }else{
                  return GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => Conversation(
                         chatRoomID:snapshot.data!.docs[index].data()['chatRoomID'],
                         chatWith: asnapshot.data!.docs.single.get('name'),
                          // chatWith: snapshot.data!.docs[index].data()['users'][0]==FirebaseAuth.instance.currentUser!.uid ? 
                          // snapshot.data!.docs[index].data()['users'][1]
                          // :snapshot.data!.docs[index].data()['users'][0],
                        ),
                      ),
                    ),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 15,
                      ),
                      child: Row(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(2),
                            decoration: true
                                ? BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(40)),
                                    border: Border.all(
                                      width: 2,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                    // shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 2,
                                        blurRadius: 5,
                                      ),
                                    ],
                                  )
                                : BoxDecoration(
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
                              radius: 35,
                              backgroundImage:asnapshot.data?.docs.single.get('profile')!=null? NetworkImage(asnapshot.data!.docs.single.get('profile'),):const NetworkImage("https://media.istockphoto.com/vectors/broken-file-line-icon-vector-id1146597753?k=6&m=1146597753&s=612x612&w=0&h=OM5uYm7mpD3dW3S3nSHDwIwy5kbIQcIEW9i46HKTahM="),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.65,
                            padding: EdgeInsets.only(
                              left: 20,
                            ),
                            child: Column(
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Text(
                                           asnapshot.data!.docs.single.get('name'),
                          //                 snapshot.data!.docs[index].data()['users'][0]==FirebaseAuth.instance.currentUser!.uid ? 
                          // snapshot.data!.docs[index].data()['users'][1]
                          // :snapshot.data!.docs[index].data()['users'][0],
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        true
                                            ? Container(
                                                margin: const EdgeInsets.only(left: 5),
                                                width: 7,
                                                height: 7,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Theme.of(context).primaryColor,
                                                ),
                                              )
                                            : Container(
                                                child: null,
                                              ),
                                      ],
                                    ),
                                    Text(
                                      " ",
                                      style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w300,
                                        color: Colors.black54,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    " ",
                                    //chat.text,
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.black54,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                                 }               }
              );
            },
          );
        }
      ),
    );
  }
}