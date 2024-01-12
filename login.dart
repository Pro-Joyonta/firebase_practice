import 'package:firebase_project_one/twoProject/models/model_one.dart';
import 'package:firebase_project_one/twoProject/views/post_screen.dart';
import 'package:firebase_project_one/twoProject/views/signup.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/utils.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {



   bool loading=false;
  final _formKey= GlobalKey <FormState>();
  TextEditingController email= TextEditingController();
  TextEditingController password= TextEditingController();
  FirebaseAuth aauth= FirebaseAuth.instance;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    email.dispose();
    password.dispose();
  }


  void login(){
    if(_formKey.currentState!.validate()){
      setState(() {
        loading=true;
      });
      aauth.signInWithEmailAndPassword(email: email.text,
          password: password.text).then((value) {
        Utils().toastSms(value.user!.email.toString());
        Navigator.push(context, MaterialPageRoute(builder: (context) => PostScreen(),));


        setState(() {
 loading=false;
        });
      }).onError((error, stackTrace) {
        debugPrint(error.toString());
        setState(() {
     loading=false;
        });
        Utils().toastSms(error.toString());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Login',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.purple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              Form(
                key: _formKey,

                  child:Column(
                    children: [
                      SizedBox(height: 20,),
                      TextFormField(

                     //validate form
                      validator: (value) {
                        if(value!.isEmpty){
                          return 'Enter Email';
                        } return null;
                      },
                        controller: email,
                        decoration: InputDecoration(
                            label: Text('Enter Email'),
                            prefixIcon: Icon(Icons.email_outlined),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12))),
                      ),
                      SizedBox(height: 20,),

                      TextFormField(
                        validator: (value) {
                          if(value!.isEmpty){
                            return 'Enter Password';
                          } return null;
                        },

                        controller:password ,
                        decoration: InputDecoration(
                            label: Text('Enter Password'),
                            prefixIcon: Icon(Icons.password_sharp),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12))),
                      ),

                      SizedBox(height: 30,),

                    ],
                  ) ),


              AllClass(
                title: 'login',
                loading: loading,
                ontap: () {
                 login();

                },
              ),
              SizedBox(height: 50,),
              Text('Dont have any account?'),
            SizedBox(height: 10,),
              InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp(),) );
                  },
                  child: Text('Register',style: TextStyle(color:Colors.greenAccent.shade700),),),

            ]),
      ),
    );
  }
}
