import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_job_seeking/core/theme/app_color.dart';
import 'package:flutter_job_seeking/feature/Applied/Applied.dart';
import 'package:flutter_job_seeking/feature/Chat/ChatScreen.dart';
import 'package:flutter_job_seeking/feature/Profile/Profile.dart';
import 'package:flutter_job_seeking/feature/home/presentation/home_screen.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //const HomeScreen({super.key});
  List<Widget> items=[
    const HomeScreen(),
    ChatScreen(),
    const Applied(),
    const Profile()
  ];
int position=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: items[position],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        currentIndex: position,
        selectedItemColor: AppColor.primaryColor,
        unselectedItemColor: Colors.grey.shade400,
        unselectedLabelStyle: TextStyle(color: Colors.grey.shade400),
        onTap: (value) {
          //if(mounted) {
            setState(() {
            position=value;
          });
          //}
        },
        items: const [
        BottomNavigationBarItem(icon:Icon(Icons.home),label: "Home"),
        BottomNavigationBarItem(icon:Icon(Icons.chat),label: "Chat"),
        BottomNavigationBarItem(icon:Icon(Icons.file_open),label: "Applied"),
        BottomNavigationBarItem(icon:Icon(Icons.person),label: "Profile"),
      ]),
    );
  }
}