// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:get/get.dart';
// class CreateResume extends StatelessWidget {
//   const CreateResume({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(body: Container(
//       height: Get.height*1,
//       child: Column(children: [
//     ],),),);
//   }
//   PdfDocument generateResumePdf() {
//   final document = PdfDocument();
//   final page = pw.Page(
//     pageFormat: PdfPageFormat.a4,
//     build: (pw.Context context) {
//       return pw.Column(
//         children: <pw.Widget>[
//          pw.Container(
//           child: pw.Header(
//             level: 0,
//             child: pw.Text('FriendlyUser Resume'),
//           ),
//           // width 100%
//           // width: double.infinity,
//           alignment: pw.Alignment.center,
//         ),
//         // hr rule
//         // address information
//         pw.Container(
//             alignment: pw.Alignment.center,
//             child: pw.Column(children: [
//               pw.Text('John Smith 123 Main St USA 12345'),
//               pw.Text('(234) 345-4567'),
//               pw.Text('jogn_smith@kage.com'),
//             ])),
//         // hr rule
//         pw.Divider(),
//         pw.Container(
//   child: pw.Header(
//     level: 1,
//     child: pw.Text('Professional Experience'),
//   ),
//   alignment: pw.Alignment.center,
// ),
// // to left job title and company to the right
// pw.Row(
//   mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//   // max width
//   mainAxisSize: pw.MainAxisSize.max,
//   children: [
//     pw.Column(
//       // left align

//       crossAxisAlignment: pw.CrossAxisAlignment.start,
//       children: [
//         pw.Text('Dli invest'),
//         pw.Text('Software Engineer'),
//       ],
//     ),
//     pw.Column(
//       // right align
//       crossAxisAlignment: pw.CrossAxisAlignment.end,
//       children: [
//         pw.Text('Canada, Remote'),
//         pw.Text('August 2020 - Current'),
//       ],
//     ),
//   ],
// ),
// pw.SizedBox(height: 10),
// pw.Column(children: [
//   pw.Bullet(text: 'Developed code in python and golang.'),
//   pw.Bullet(text: 'Built out cutting edge software.'),
//   pw.Bullet(text: 'Backtesting trades.'),
// ]),
// pw.Row(
//   mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//   // max width
//   mainAxisSize: pw.MainAxisSize.max,
//   children: [
//     pw.Column(
//       // left align

//       crossAxisAlignment: pw.CrossAxisAlignment.start,
//       children: [
//         pw.Text('University of Victoria'),
//         pw.Text('Bachelor of Computer Engineering (with distinction)'),
//       ],
//     ),
//     pw.Column(
//       // right align
//       crossAxisAlignment: pw.CrossAxisAlignment.end,
//       children: [
//         pw.Text("GPA: 6.9/9.0"),
//         pw.Text('August 2000 - 2006'),
//       ],
//     ),
//   ],
// ),
// pw.Wrap(
//   children: [
//   pw.SizedBox(width: 10),
//   pw.ClipOval(
//     // curved edges
//     child: pw.Padding(
//       padding: pw.EdgeInsets.all(10),
//       child: Text('Java',
//         style: pw.TextStyle(
//             color: PdfColors.cyan,
//             background: BoxDecoration(
//               color: PdfColors.purple900,
//               border: Border.all(
//                 color: PdfColors.brown50,
//                 width: 50,
//               ),
//             )
//           )
//         )
//       ),
//   ),
//   pw.SizedBox(width: 10),
//   pw.ClipOval(
//     // curved edges
//     child: pw.Padding(
//       padding: pw.EdgeInsets.all(10),
//       child: Text('C++',
//         style: pw.TextStyle(
//             // padding
//             color: PdfColors.pink,
//             background: BoxDecoration(
//               color: PdfColors.red900,
//               border: Border.all(
//                 color: PdfColors.black,
//                 width: 50,
//               ),
//             )
//           )
//         )
//       ),
//     ),
//   ]
// )
//         ],
//       );
//     },
//   );
//   document.addPage(page);
//   return document;
// }

// }