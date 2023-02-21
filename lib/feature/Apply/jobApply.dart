import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class JobApply extends StatelessWidget {
  const JobApply({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      title: Text("Apply now"),
      backgroundColor: Colors.white,
      elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left:21.0,right: 21.0),
        child: Container(
        child: TextField(),
    ),
      ),);
  }
}