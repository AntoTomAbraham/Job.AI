import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class DialogHelper{
  static void showDialog(String text,bool isSuccess){
    Get.dialog(
              Dialog(
                child: Container(
                  height: Get.height*.2,
                  width: Get.width*.4,
                    child: Column(
                      children: [
                        SizedBox(height:10),
                        Text(isSuccess?"Success":"Failure",style: GoogleFonts.poppins(fontSize: 18),),
                        SizedBox(height:10),
                        isSuccess? Image.network(
                          "https://img.icons8.com/color/512/double-tick.png",
                          height: 68,
                          width: 150,
                          ):Image.network("https://img.icons8.com/color/512/cloud-cross.png",
                           height: 68,
                          width: 150,),
                         SizedBox(height:10),
                        Text(text,style: GoogleFonts.poppins(fontSize: 14,fontWeight: FontWeight.w700,color: isSuccess? Colors.green:Colors.red))
                      ],
                    )
                    )
              ,)
  );
  }

  static void showLoadingDialog(){
    Get.dialog(
              Dialog(
                child: Container(
                  height: Get.height*.2,
                  width: Get.width*.4,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator()
                      ],
                    )
                    )
              ,)
  );
  }

  static void hideDialog(){
    if(Get.isDialogOpen==true){
      Get.back();
    }
  }
}