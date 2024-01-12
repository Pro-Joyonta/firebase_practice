import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_project_one/twoProject/views/login.dart';
import 'package:firebase_project_one/twoProject/views/post_screen.dart';
import 'package:flutter/material.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}



class _FirstScreenState extends State<FirstScreen> {

  @override
  void initState() {
    super.initState();
    final auth = FirebaseAuth.instance;
    final user= auth.currentUser;
   if(user!=null){
     Timer(Duration(seconds: 2), () {
       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => PostScreen(),));

     });
   }else{
     Timer(Duration(seconds: 1), () {
       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login(),));

     });
   }


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          alignment: Alignment.center,
          child:
          CircularProgressIndicator(),),
      ) ,
    );
  }
}
