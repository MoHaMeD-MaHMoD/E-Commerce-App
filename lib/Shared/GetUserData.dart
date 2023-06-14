import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class GetUserData extends StatefulWidget {
  final String documentId;

  const GetUserData({super.key, required this.documentId});

  @override
  State<GetUserData> createState() => _GetUserDataState();
}

class _GetUserDataState extends State<GetUserData> {
  final editDialog = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final credential = FirebaseAuth.instance.currentUser;

    CollectionReference users = FirebaseFirestore.instance.collection('users');
    myDialog(Map data, String keyValue) {
      return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(11)),
            child: Container(
              padding: EdgeInsets.all(22),
              height: 200,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                      controller: editDialog,
                      maxLength: 20,
                      decoration:
                          InputDecoration(hintText: "${data[keyValue]}")),
                  const SizedBox(
                    height: 22,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextButton(
                        onPressed: () {
                          users
                              .doc(credential!.uid)
                              .update({keyValue: editDialog.text});
                          setState(() {
                            Navigator.pop(context);
                            editDialog.clear();
                          });
                        },
                        child: const Text(
                          "Update",
                          style: TextStyle(fontSize: 22),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          //// addnewtask();
                          Navigator.pop(context);
                        },
                        child: const Text(
                          "Cancel",
                          style: TextStyle(fontSize: 22),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        },
      );
    }

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(widget.documentId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return const Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "User Name: ${data['UserName']}",
                    style: const TextStyle(fontSize: 20),
                  ),
                  IconButton(
                    onPressed: () {
                      myDialog(data, 'UserName');
                    },
                    icon: const Icon(Icons.edit),
                  )
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Title: ${data['Title']}",
                    style: const TextStyle(fontSize: 20),
                  ),
                  IconButton(
                    onPressed: () {
                      myDialog(data, 'Title');
                    },
                    icon: const Icon(Icons.edit),
                  )
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Phone: ${data['Phone']}",
                    style: const TextStyle(fontSize: 20),
                  ),
                  IconButton(
                    onPressed: () {
                      myDialog(data, 'Phone');
                    },
                    icon: Icon(Icons.edit),
                  )
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Age: ${data['Age']}",
                    style: const TextStyle(fontSize: 20),
                  ),
                  IconButton(
                    onPressed: () {
                      myDialog(data, 'Age');
                    },
                    icon: const Icon(Icons.edit),
                  )
                ],
              ),
            ],
          );
        }

        return const Text("loading");
      },
    );
  }
}
