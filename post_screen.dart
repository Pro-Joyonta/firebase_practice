import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_project_one/twoProject/models/utils.dart';
import 'package:firebase_project_one/twoProject/views/add_list.dart';
import 'package:firebase_project_one/twoProject/views/login.dart';
import 'package:flutter/material.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final auth = FirebaseAuth.instance;
  final ref = FirebaseDatabase.instance.ref('Post');
  final search = TextEditingController();
  final add = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              auth.signOut().then((value) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Login(),
                    ));
              }).onError((error, stackTrace) {
                Utils().toastSms(error.toString());
              });
            },
            icon: Icon(Icons.logout),
            color: Colors.white,
          )
        ],
        title: Text(
          'All Post',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.purple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextFormField(
              controller: search,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                  hintText: 'Search'),
              onChanged: (value) {
                setState(() {});
              },
            ),
            Expanded(
              child: FirebaseAnimatedList(
                query: ref,
                itemBuilder: (context, snapshot, animation, index) {
                  final title = snapshot.child('title').value.toString();
                  final id = snapshot.child('Id').value.toString();
                  if (search.text.isEmpty) {
                    return Card(
                      child: ListTile(
                        leading: Text('$index'),
                        title: Text(snapshot.child('title').value.toString()),
                        subtitle: Text(snapshot.child('Id').value.toString()),
                        trailing: PopupMenuButton(
                          icon: Icon(
                            Icons.more_vert,
                            color: Colors.black,
                          ),
                          itemBuilder: (context) => [
                            PopupMenuItem(
                                value: 1,
                                child: ListTile(
                                  onTap: () {
                                    myBox(title, id);
                                    Navigator.pop(context);
                                  },
                                  leading: Icon(Icons.edit),
                                  title: Text('Edit'),
                                )),
                            PopupMenuItem(
                                onTap: () {
                                  ref
                                      .child(
                                          snapshot.child('id').value.toString())
                                      .remove();
                                },
                                value: 1,
                                child: ListTile(
                                  leading: Icon(Icons.delete),
                                  title: Text('Delete'),
                                ))
                          ],
                        ),
                      ),
                    );
                  } else if (title
                      .toLowerCase()
                      .toUpperCase()
                      .contains(search.text.toUpperCase().toLowerCase())) {
                    return Card(
                      child: ListTile(
                        leading: Text('$index'),
                        title: Text(snapshot.child('title').value.toString()),
                        subtitle: Text(snapshot.child('Id').value.toString()),
                        trailing: PopupMenuButton(
                          icon: Icon(
                            Icons.more_vert,
                            color: Colors.black,
                          ),
                          itemBuilder: (context) => [
                            PopupMenuItem(
                                value: 1,
                                child: ListTile(
                                  onTap: () {
                                    myBox(title,
                                        snapshot.child('Id').value.toString());
                                    Navigator.pop(context);
                                  },
                                  leading: Icon(Icons.edit),
                                  title: Text('Edit'),
                                )),
                            PopupMenuItem(
                                onTap: () {
                                  ref
                                      .child(
                                          snapshot.child('id').value.toString())
                                      .remove();
                                },
                                value: 2,
                                child: ListTile(
                                  leading: Icon(Icons.delete),
                                  title: Text('Delete'),
                                ))
                          ],
                        ),
                      ),
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddList(),
              ));
        },
        child: Icon(Icons.add),
      ),
    );
  }

  // Future<void> myBox(String title, String Id)async{
  //   title= add.text.toLowerCase.toString();
  //   return showDialog(context: context, builder: (context) {
  //     return AlertDialog(
  //       content: Container(
  //         child: TextFormField(
  //           controller: add,
  //         ),
  //
  //       ),
  //       actions: [
  //         TextButton(onPressed: () {
  //           Navigator.pop(context);
  //           ref.child(Id).update({
  //             'title': add.text.toLowerCase()
  //           }).then((value) {
  //             Utils().toastSms('Post update');
  //           }).onError((error, stackTrace) {
  //             Utils().toastSms(error.toString());
  //           });
  //         }, child: Text('Update')),
  //
  //         TextButton(onPressed: () {
  //           Navigator.pop(context);
  //         }, child: Text('Cancel')),
  //       ],
  //     );
  //   },);
  // }

  Future<void> myBox(String title, String id) async {
    add.text =
        title; // Set the initial value of the TextEditingController to the existing title

    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Update'),
            content: Container(
              child: TextField(controller: add),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  // Navigator.pop(context);
                  ref.child(id).update({
                    'title': add.text.toLowerCase(),
                  }).then((value) {
                    Utils().toastSms('Post updated');
                  }).onError((error, stackTrace) {
                    Utils().toastSms(error.toString());
                  });
                },
                child: Text('Update'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Cancel'),
              ),
            ],
          );
        });
  }
}
