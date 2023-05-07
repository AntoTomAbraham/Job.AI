import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:pdf_text/pdf_text.dart';
//import 'package:pdf_viewer_plugin/pdf_viewer_plugin.dart';
import 'package:webview_flutter/webview_flutter.dart';


class ApplicantPDF extends StatefulWidget {
  String pdfURL;
  ApplicantPDF({required this.pdfURL});

  @override
  State<ApplicantPDF> createState() => _ApplicantPDFState();
}

class _ApplicantPDFState extends State<ApplicantPDF> {
  //const ApplicantPDF({super.key});
  late WebViewController webview;
  String docText="";
  viewPDF() async{
    PDFDoc doc = await PDFDoc.fromURL(widget.pdfURL);
    docText = await doc.text;
    print(docText);
    setState(() {});
  }
  @override
  void initState() {
    viewPDF();
    // PDFDoc doc = await PDFDoc.fromURL(resume);
    // String docText = await doc.text;
    // print(docText);
  //   webview = WebViewController()
  // ..setJavaScriptMode(JavaScriptMode.unrestricted)
  // ..setBackgroundColor(const Color(0x00000000))
  // ..setNavigationDelegate(
  //   NavigationDelegate(
  //     onProgress: (int progress) {
  //       // Update loading bar.
  //     },
  //     onPageStarted: (String url) {},
  //     onPageFinished: (String url) {},
  //     onWebResourceError: (WebResourceError error) {},
  //     onNavigationRequest: (NavigationRequest request) {
  //       if (request.url.startsWith('https://www.youtube.com/')) {
  //         return NavigationDecision.prevent;
  //       }
  //       return NavigationDecision.navigate;
  //     },
  //   ),
  // )
  // ..loadRequest(Uri.parse(widget.pdfURL));
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Container(
      child: Container(
        child: Container() 
        //PDFViewer()
        //child: Text(docText),
        )
      //SfPdfViewer.network('https://firebasestorage.googleapis.com/v0/b/jobai-a1c15.appspot.com/o/images%2Fdata%2Fuser%2F0%2Fcom.example.flutter_job_seeking%2Fcache%2FAnto_Tom_Abraham_CV.pdf?alt=media&token=086b56b0-45a4-4efa-8a03-61b24c0f9736')
      //WebViewWidget(controller: webview),
    ),);
  }
}