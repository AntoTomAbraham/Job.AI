//18e5ccfe5bb947f5bb7673dfb8289b88
//https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=18e5ccfe5bb947f5bb7673dfb8289b88
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class JobNews extends StatefulWidget {
  @override
  State<JobNews> createState() => _JobNewsState();
}

class _JobNewsState extends State<JobNews> {
  List data=[];
  //paste your api key here
  string apiKey="";
  Future<dynamic> _getData() async{
    final res=await http.get(Uri.parse('https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=${apiKey}'));
    Map result=jsonDecode(res.body);
    print("fetched");
    print(res.statusCode);
    print(result);
    if (mounted){
    setState(() {
      data=result['articles'];
    });
    }
    return result['articles'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height:MediaQuery.of(context).size.height*1,
         child: Column(
           children: [
            SizedBox(height: 20),
             Container(
              height: Get.height*.9,
               child: FutureBuilder(
                future: _getData(),
                builder: (BuildContext context, AsyncSnapshot snapshot){
                  if(snapshot.data==null){
                    print("its waiting");
                    return Center(child: CircularProgressIndicator());
                  }else if(snapshot.data==null){
                    print("its null");
                    return Center(child: CircularProgressIndicator());
                  }else if(snapshot.hasData){
                  return ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (BuildContext context, int index){
                      return ListTile(
                        //leading:data[index]['urlToImage']!=null? Image.network(data[index]['urlToImage']):SizedBox(width: 0,),
                        title:Text(data[index]['title']),
                        subtitle:Text(data[index]['author']),
                      );
                    });
                    }else{
                      return CircularProgressIndicator();
                    }
                }),
             ),
           ],
         ),
          ),);
  }
}
