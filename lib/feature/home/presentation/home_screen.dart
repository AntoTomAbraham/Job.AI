import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_job_seeking/feature/Search/SearchResult.dart';
import 'package:flutter_job_seeking/feature/home/presentation/widget/category_widget.dart';
import 'package:flutter_job_seeking/feature/home/presentation/widget/headline_widget.dart';
import 'package:flutter_job_seeking/feature/home/presentation/widget/recent_job_widget.dart';
import 'package:flutter_job_seeking/feature/home/presentation/widget/tips_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String name="";
  getUserData() async {
    await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid)
 .get().then((value) async {
    if(value.exists){
      setState(() {
        name=value.data()!['name'];
      });
      print("this is re"+ name);
    }
 });
  }
  @override
  void initState() {
    getUserData();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        leading: IconButton(
          onPressed: () {},
          splashRadius: 24,
          icon: const Icon(
            Icons.menu_rounded,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        title: Text(
          "Hi, $name",
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            splashRadius: 24,
            icon: const Icon(
              Icons.notifications_none_rounded,
              color: Colors.black,
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(80),
          child: Container(
            margin: const EdgeInsets.symmetric(
              vertical: 16,
              horizontal: 24,
            ),
            child: Container(
              height: 56,
              width: MediaQuery.of(context).size.width - 48,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(16),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 24),
              alignment: Alignment.center,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                          context, MaterialPageRoute(builder: (BuildContext context) => SearchResult()));
                },
                child: Row(
                  children: [
                    const Icon(
                      Icons.search,
                      color: Colors.grey,
                    ),
                    const SizedBox(width: 16),
                    Text(
                      "Developer, google, etc",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: const [
            /// Tips Widget
            HeadlineWidget(title: "Tips for you"),
            SizedBox(height: 16),
            TipsWidget(),

            /// Category
            SizedBox(height: 24),
            HeadlineWidget(title: "Category"),
            SizedBox(height: 16),
            CategoryWidget(),

            /// Recent Job
            SizedBox(height: 24),
            HeadlineWidget(title: "Recent Jobs"),
            SizedBox(height: 16),
            RecentJobWidget(),
          ],
        ),
      ),
    );
  }
}
