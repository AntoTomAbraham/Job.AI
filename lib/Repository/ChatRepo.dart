import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_job_seeking/Models/Messages.dart';

class ChatRepo{ 
  Future<Stream<QuerySnapshot>> getUserByemail(String email) async { 
    return FirebaseFirestore.instance.collection('users').where('email',isEqualTo: email).snapshots();
  }

  Future addMessage(String chatroomID,String messageID,Map<String,dynamic> messageINFO){
    return FirebaseFirestore.instance.collection('chatRooms').doc(chatroomID).collection('chats').doc(messageID).set(messageINFO);
  }
}