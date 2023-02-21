import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_job_seeking/Models/Messages.dart';

class ChatRepo{ 
  static Future<void> createConversation(String chatRoomID,chatRoomMap) async {
    FirebaseFirestore.instance.collection('ChatRoom').doc(chatRoomID).set(chatRoomMap)
    .catchError((e)=>print(e));
  }

  static Future<dynamic> sendmessages(String chatRoomID,messageMap) async {
    print("ins send message func");
    await FirebaseFirestore.instance.collection('ChatRoom').doc(chatRoomID).collection('Chats').add(messageMap)
    .catchError((e)=>print(e));
  }

  static Future<dynamic> getMessages(String chatRoomID) async {
    return await FirebaseFirestore.instance.collection('ChatRoom').doc(chatRoomID).collection('Chats').snapshots();
  }
}