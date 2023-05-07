import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_job_seeking/Repository/AuthRepo.dart';
import 'package:flutter_job_seeking/Repository/ToastRepo.dart';
import 'package:flutter_job_seeking/feature/Authentication/CreateAccount.dart';
import 'package:flutter_job_seeking/feature/Authentication/LoginPage.dart';
import 'package:flutter_job_seeking/feature/home_page.dart';

class SignupPage extends StatelessWidget {
  TextEditingController email=new TextEditingController();
  TextEditingController pass=new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(height: 20),
                _header(context),
                SizedBox(height: 120),
                _inputField(context),
                _forgotPassword(context),
                _signup(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _header(context) {
    return Column(
      children: [
        Text(
          "Register! ",
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
        ),
        Text("Create an account"),
      ],
    );
  }

  _inputField(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          controller: email,
          decoration: InputDecoration(
              hintText: "Email",
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide.none),
              fillColor: Theme.of(context).primaryColor.withOpacity(0.1),
              filled: true,
              prefixIcon: Icon(Icons.person)),
        ),
        SizedBox(height: 10),
        TextField(
          controller: pass,
          decoration: InputDecoration(
            hintText: "Password",
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide.none),
            fillColor: Theme.of(context).primaryColor.withOpacity(0.1),
            filled: true,
            prefixIcon: Icon(Icons.person),
          ),
          obscureText: true,
        ),
        SizedBox(height: 10),
        ElevatedButton(
          onPressed: () async {
            if(pass.text.length<6){
              ToastRepo.sendToast("Password should contain atleast 6 characters");
            }else if(email.text!=null && pass.text!=null){
          bool user= await AuthRepo().emailSignup(email.text, pass.text);
          if(user==false){
            print("error");
          }else{
            Navigator.push(  
              context,  
              MaterialPageRoute(builder: (context) => CreateAccount()),  
            );
          }  
            }else{
              ToastRepo.sendToast("Please Enter all the fields");
            }
          },
          child: Text(
            "Signup",
            style: TextStyle(fontSize: 20),
          ),
          style: ElevatedButton.styleFrom(
            shape: StadiumBorder(),
            padding: EdgeInsets.symmetric(vertical: 16),
          ),
        ),
        SizedBox(height: 10),
          ElevatedButton(
          onPressed: () async {
          //  Future<bool> user=FirebaseAuth.instance.
          bool user=await AuthRepo().googleSignup();
          if(user==false){
            print("error");
          }else{
             Navigator.push(  
              context,  
              MaterialPageRoute(builder: (context) => CreateAccount()),  
            );
          }  
          },
          child: Center(
            child: Container(
              color: Colors.white,
              child: Row(mainAxisAlignment: MainAxisAlignment.center, 
                children: [
                  Image.network(height: 40,width:40,
              'http://pngimg.com/uploads/google/google_PNG19635.png',
              fit:BoxFit.cover
            ), const SizedBox(
        width: 5.0,
      ),
                  const Text(
                    "Google Signin",
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            shadowColor: Colors.white60,
            shape: StadiumBorder(),
            padding: EdgeInsets.symmetric(vertical: 16),
          ),
        )
        
      ],
    );
  }

  _forgotPassword(context) {
    return TextButton(onPressed: () {}, child: Text("Forgot password?"));
  }

  _signup(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Already have an account? "),
        TextButton(onPressed: () {}, child: GestureDetector(
          onTap:(() {
          Navigator.push(  
              context,  
              MaterialPageRoute(builder: (context) => LoginPage())); 
          } 
            ),child: Text("Sign In")))
      ],
    );
  }
}