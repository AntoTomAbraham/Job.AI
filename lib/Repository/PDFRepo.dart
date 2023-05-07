import 'package:firebase_storage/firebase_storage.dart';

class PDFRepo{
  static void loadPDF(String url){
   final refPDF=FirebaseStorage.instance.ref().child(url);
   final bytes=refPDF.getData(); 
  }
}