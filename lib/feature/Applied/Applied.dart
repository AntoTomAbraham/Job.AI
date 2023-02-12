import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_job_seeking/feature/Job/PostJob.dart';
import 'package:flutter_job_seeking/feature/Job/ViewmyJob.dart';

class Applied extends StatelessWidget {
  const Applied({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.white,title: Text("You Applied"),elevation: 0,),
      body: Container(
        height: MediaQuery.of(context).size.height*1,
         width: MediaQuery.of(context).size.width*1,
        child: Padding(
          padding:  EdgeInsets.only(left:21.0,right: 21.0),
          child: Column(
            children: [
          SizedBox(height: 20),
            ListTile(leading: Icon(Icons.person),
                title: Text("View your Job"),
                onTap: () {
                  Navigator.push(  
                          context,  
                          MaterialPageRoute(builder: (context) => 
                          ViewmyJob())
                          ); 
                },
                ),
                   ListTile(leading: Icon(Icons.account_balance_wallet_rounded),
                title: Text("Post a Job"),
                onTap: () {
                  Navigator.push(  
                          context,  
                          MaterialPageRoute(builder: (context) => 
                          PostJob())); 
                },
                ),
      ],
      ),
        ),),);
  }
}