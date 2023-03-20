import 'dart:convert';

import 'package:pdf_text/pdf_text.dart';
import 'package:http/http.dart' as http;

class SimilarityRepo{
  static Future<dynamic> findSimilarity({String? resumeLink,String? desc}) async {
    PDFDoc doc = await PDFDoc.fromURL(resumeLink as String);
    String docText = await doc.text;
    String ip="192.168.0.165";
    print(docText);
    final http.Response response = await http.post(Uri.parse('http://${ip}/findMatching'),
    body: {
    "resume": docText,
    "desc": desc
    },
  );
  print(response.body);
  }

  static Future<dynamic> fetchMatching({required String resume,required String desc}) async {
    //Extracting Data
    PDFDoc doc = await PDFDoc.fromURL(resume);
    String docText = await doc.text;
    print(docText);

    //Finding Similarity
    String ip="192.168.0.165";
    String ipA="10.0.2.2";
    String baseURl="https://0693-2406-7400-51-daa2-7553-9d0e-98df-6348.in.ngrok.io";
    final http.Response response = await http.get(Uri.parse('$baseURl/findSimilarity?resume=$docText&desc=$desc'));
    print(response.body);
    return response.body;   
  }
}