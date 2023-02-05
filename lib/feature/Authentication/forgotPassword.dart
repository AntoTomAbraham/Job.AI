import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_job_seeking/Repository/AuthRepo.dart';

class ForgotPassword extends StatelessWidget {
  //const ForgotPassword({super.key});
  TextEditingController emailController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Container(child: 
    Padding(
      padding: const EdgeInsets.all(21.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
                controller:emailController,
                decoration: InputDecoration(
                  helperText: "Enter your registered email",
                  hintText: "Email",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: BorderSide.none),
                  fillColor: Theme.of(context).primaryColor.withOpacity(0.1),
                  filled: true,
                  prefixIcon: Icon(Icons.person),
                ),
                //obscureText: true,
              ),
              SizedBox(height: 20),
              ElevatedButton(
            onPressed: ()async {
              AuthRepo().sendPasswordResetEmail(emailController.text);        
            },
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(
                "  Reset Password  ",
                style: TextStyle(fontSize: 20),
              ),
            ),
            style: ElevatedButton.styleFrom(
              shape: StadiumBorder(),
              padding: EdgeInsets.symmetric(vertical: 16),
            ),
          ),
      ],),
    )),);
  }
}