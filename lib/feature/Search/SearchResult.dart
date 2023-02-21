import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_job_seeking/Repository/JobRepo.dart';
import 'package:get/get.dart';

class SearchResult extends StatefulWidget {
  @override
  State<SearchResult> createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
  //const SearchResult({super.key});
  TextEditingController searchController=TextEditingController();
  String search="";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
          
        },child: Icon(Icons.search)),
        backgroundColor: Colors.transparent,
        elevation: 0,title:  Padding(
          padding: const EdgeInsets.only(top:16.0),
          child: TextField(
            onChanged: (val){
              setState(() {
                search=val;
              });
            },
                    controller: searchController,
                    //keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      helperText: "JOBS",
                      hintText: "Search for jobs",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: BorderSide.none),
                      fillColor: Theme.of(context).dialogBackgroundColor,
                      filled: true,
                      //prefixIcon: Icon(Icons.search),
                    ),             
                  ),
        ),),
      body: SingleChildScrollView(
        child: Padding(
        padding: const EdgeInsets.only(left:21.0,right: 21.0),
        child: Container(
          child: Column(children: [
            SizedBox(height: 40,),
           search.isNotEmpty ? FutureBuilder(
              future: FirebaseFirestore.instance.collection('Job').where('Jobtitle',isGreaterThanOrEqualTo: search).get(),
              builder: (context, snapshot) {
                if(!snapshot.hasData){
                  return Container();
                }else if(snapshot.connectionState==ConnectionState.waiting){
                  return CircularProgressIndicator();
                }else{
                  return Container(
                    height: Get.height*.5,
                    child: ListView(children: snapshot.data!.docs.map((e) {
                      return ListTile(title:Text(e['Jobtitle']),subtitle: Text(e['company']),);
                    }).toList()),
                  );
                }
            })
            :Container(),
        ],),),
          ),
      ),);
  }
}