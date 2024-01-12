import 'dart:html';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_project_one/twoProject/models/model_one.dart';
import 'package:firebase_project_one/twoProject/models/utils.dart';
import 'package:flutter/material.dart';

class AddList extends StatefulWidget {
  const AddList({super.key});

  @override
  State<AddList> createState() => _AddListState();
}

class _AddListState extends State<AddList> {
  final title= TextEditingController();
  final Description= TextEditingController();
  bool loading= false;
  final databaseref= FirebaseDatabase.instance.ref('Post');

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: Text('Add Post', style: TextStyle(color:Colors.white ),), centerTitle: true,backgroundColor: Colors.purple,),
    body: Padding(
      padding: const EdgeInsets.only(left: 30, right: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 10,),
          TextFormField(
            controller: title,
            decoration: InputDecoration(
                label: Text('Title'),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12))),
          ),
          SizedBox(height: 10,),
          TextFormField(
            controller: Description,
            minLines: 5,
            maxLines: 8,
            decoration: InputDecoration(

                label: Text('Description'),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12))),
          ),
          SizedBox(height: 30,),

          AllClass(
            loading: loading,
            title: 'Submit', ontap: () {
              setState(() {
                loading=true;
              });
var id= DateTime.now().microsecondsSinceEpoch.toString();
            databaseref.child(id).set({
              'Id':id,
              'title': title.text.toString(),
              'Description': Description.text.toString(),
            }).then((value) {
              setState(() {
                loading=false;
              });

              Utils().toastSms('Sucess');
            }).onError((error, stackTrace){
              setState(() {
                loading=false;
              });

              Utils().toastSms(error.toString());
            });
          },),



        ],
      ),
    ),

    );
  }
}
