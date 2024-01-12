import 'package:firebase_project_one/twoProject/models/model_one.dart';
import 'package:firebase_project_one/twoProject/models/utils.dart';
import 'package:firebase_project_one/twoProject/views/login.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
 final _formKey= GlobalKey <FormState>();
  bool loading= false;

  TextEditingController emailC= TextEditingController();
  TextEditingController passC= TextEditingController();
  FirebaseAuth aauth= FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text(
          'SignUp',
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
                  child:
              Column(children: [
                SizedBox(height: 20,),
                TextFormField(
                  validator: (value) {
                    if(value!.isEmpty){
                      return 'Enter Email';
                    } return null;

                  },
                  controller: emailC,
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
                  obscureText: true,
                  controller:passC ,
                  decoration: InputDecoration(
                      label: Text('Enter Password'),
                      prefixIcon: Icon(Icons.password_sharp),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12))),
                ),

                SizedBox(height: 30,),
              ],)
              ),


              AllClass(
                title: 'SignUp',
                loading: loading,
                ontap: () {
if(_formKey.currentState!.validate()){
setState(() {
  loading=true;
});
aauth.createUserWithEmailAndPassword(email: emailC.text,
    password: passC.text).then((value) {
      Utils().toastSms('Create Success');
  setState(() {
    loading=false;
  });
}).onError((error, stackTrace) {
  setState(() {
    loading=false;
  });
  Utils().toastSms(error.toString());
});




}





                },
              ),
              SizedBox(height: 50,),
              Text('Do you have alreday account?'),
              SizedBox(height: 10,),
              InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Login(),) );
                },
                child: Text('login',style: TextStyle(color:Colors.greenAccent.shade700),),),

            ]),
      ),

    );
  }
}
