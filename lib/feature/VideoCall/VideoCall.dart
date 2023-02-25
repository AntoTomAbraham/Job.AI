import 'package:flutter/material.dart';
import 'package:flutter_job_seeking/core/theme/app_color.dart';
import 'package:flutter_job_seeking/feature/VideoCall/Signaling.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:get/get.dart';

class VideoCall extends StatefulWidget {
  String chatRoomID;
  VideoCall({required this.chatRoomID});
  //const VideoCall({super.key, required String chatRoomID});

  @override
  State<VideoCall> createState() => _VideoCallState();
}
  
class _VideoCallState extends State<VideoCall> {
  Signaling signaling= Signaling();
  RTCVideoRenderer _localRenderer=RTCVideoRenderer();
  RTCVideoRenderer _remoteRenderer=RTCVideoRenderer();
  String? roomId;
  TextEditingController textEditingController=TextEditingController();

  @override
  void initState() {
    _localRenderer.initialize();
    _remoteRenderer.initialize();
    signaling.onAddRemoteStream=((stream) {
      _remoteRenderer.srcObject=stream;
      setState(() {});
    });
    // TODO: implement initState
    super.initState();
  }
  @override
  void dispose() {
    _localRenderer.dispose();
    _remoteRenderer.dispose();
    // TODO: implement dispose
    super.dispose();
  }
  //RTCVideoRenderer _remo
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: Get.height*1,
          child: Padding(
            padding: const EdgeInsets.only(left:21.0,right: 21),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(height: 30),
                Card(
                  elevation: 1,
                  shadowColor: Colors.white60,
                  child: Container(
                    height: Get.height*.3,
                    child: RTCVideoView(_localRenderer, mirror: true),),
                ),
                 Card(
                  elevation: 1,
                  shadowColor: Colors.white60,
                  child: Container(
                    height: Get.height*.3,
                    child: RTCVideoView(_remoteRenderer),),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                  ElevatedButton(  
                    onPressed: () async {
                      roomId = await signaling.createRoom(_remoteRenderer,widget.chatRoomID);
                      textEditingController.text = roomId!;
                      setState(() {});
                    },
                    child: Icon(
                      Icons.create_new_folder_sharp,
                      size: 28.0,
                    ),
                    style: ElevatedButton.styleFrom(
        shape: CircleBorder(),
        padding: EdgeInsets.all(20),
        primary: AppColor.primaryColor,
        onPrimary: Colors.white,
      ),
                    ),
                    ElevatedButton(
                    onPressed: () async {
                      signaling.openUserMedia(_localRenderer, _remoteRenderer);
                    },
                    style: ElevatedButton.styleFrom(
        shape: CircleBorder(),
        padding: EdgeInsets.all(20),
        primary: AppColor.primaryColor,
        onPrimary: Colors.white,
      ),
                    child: Icon(
                      Icons.camera,
                      size: 28.0,
                    ),
                    
                    ),
                    ElevatedButton(
                    onPressed: () async {
                      signaling.joinRoom(
                        textEditingController.text,
                        _remoteRenderer,
                      );
                    },
                   style: ElevatedButton.styleFrom(
        shape: CircleBorder(),
        padding: EdgeInsets.all(20),
        primary: AppColor.primaryColor,
        onPrimary: Colors.white,
      ),
                    child: Icon(
                      Icons.join_full,
                      size: 28.0,
                    ),
                    // padding: EdgeInsets.all(12.0),
                    // shape: CircleBorder(),
                    ),
                    ElevatedButton(
                    onPressed: ()async {
                      signaling.hangUp(_localRenderer);
                    },
                   style: ElevatedButton.styleFrom(
        shape: CircleBorder(),
        padding: EdgeInsets.all(20),
        primary: AppColor.primaryColor,
        onPrimary: Colors.white,
      ),
                    child: Icon(
                      Icons.call_end,
                      size: 28,
                    ),
                    // padding: EdgeInsets.all(12.0),
                    // shape: CircleBorder(),
                    )
                ],),
                 Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Room ID : "),
                  Flexible(
                    child: TextFormField(
                      controller: textEditingController,
                    ),
                  )
                ],
              ),
            ),
            //     SizedBox(height: 30),
            //     TextButton(onPressed: () async {
            //       roomId = await signaling.createRoom(_remoteRenderer);
            //           textEditingController.text = roomId!;
            //           setState(() {});
            //     }, child: Text("Create Meeting")),
            //     TextButton(onPressed: (){
            //       signaling.openUserMedia(_localRenderer, _remoteRenderer);
            //     }, child: Text("Open Camera")),
            //     TextButton(onPressed: () async {
            //        signaling.joinRoom(
            //             textEditingController.text,
            //             _remoteRenderer,
            //           );
            //     }, child: Text("Join Room")),
            //     TextButton(onPressed: (){
            //        signaling.hangUp(_localRenderer);
            //     }, child: Text("Hangout")),
            //     Expanded(
            //   child: Padding(
            //     padding: const EdgeInsets.all(8.0),
            //     child: Column(
            //       mainAxisAlignment: MainAxisAlignment.center,
            //       children: [
            //         Expanded(child: RTCVideoView(_localRenderer, mirror: true)),
            //         Expanded(child: RTCVideoView(_remoteRenderer)),
            //       ],
            //     ),
            //   ),
            // ),
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: [
            //       Text("Join the following Room: "),
            //       Flexible(
            //         child: TextFormField(
            //           controller: textEditingController,
            //         ),
            //       )
            //     ],
            //   ),
            // ),
            // SizedBox(height: 8)
    ],
    ),
          ),
        ),),);
  }
}