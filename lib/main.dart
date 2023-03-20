import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_job_seeking/Repository/similarityRepo.dart';
import 'package:get/get.dart';
import 'core/route/app_route.dart';
import 'core/route/app_route_name.dart';
import 'core/theme/app_theme.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

const AndroidNotificationChannel channel= AndroidNotificationChannel(
  'high_importance_channel',
  'High',
  importance:Importance.high,
  playSound:true,
);

final FlutterLocalNotificationsPlugin notif=FlutterLocalNotificationsPlugin();
Future<void> _firebaseMessage(RemoteMessage message) async{
  await Firebase.initializeApp();

  print(message.senderId);
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // final fcmToken = await FirebaseMessaging.instance.getToken();
  // print(fcmToken);
  // FirebaseMessaging.onBackgroundMessage(_firebaseMessage);
  // await notif.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
  // ?.createNotificationChannel(channel);
  // await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(alert: true,badge: true,sound: true);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // void initState(){
  //   super.initState();
  //   FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  //     RemoteNotification? notification = message.notification;
  //     AndroidNotification? android = message.notification?.android;
  //     if (notification != null && android != null) {
  //       notif.show(
  //           notification.hashCode,
  //           notification.title,
  //           notification.body,
  //           NotificationDetails(
  //             android: AndroidNotificationDetails(
  //               channel.id,
  //               channel.name,
  //               channelDescription: channel.description,
  //               color: Colors.blue,
  //               playSound: true,
  //               //icon: '@mipmap/ic_launcher',
  //             ),
  //           ));
  //     }
      
  //   });
  // }

  

  @override
  Widget build(BuildContext context) {
    //SimilarityRepo.fetchMatching(resume: "Software Engineer", desc: "Mobile Engineer");
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Job Seeking",
      theme: AppTheme.light,
      themeMode: ThemeMode.light,
      initialRoute:AppRouteName.homeScreen,
      onGenerateRoute: AppRoute.generate,
    );
  }
}
