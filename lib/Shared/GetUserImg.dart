// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class GetUserImg extends StatefulWidget {
  const GetUserImg({
    super.key,
  });

  @override
  State<GetUserImg> createState() => _GetUserImgState();
}

class _GetUserImgState extends State<GetUserImg> {

  @override
  Widget build(BuildContext context) {
    final credential = FirebaseAuth.instance.currentUser;

    CollectionReference users = FirebaseFirestore.instance.collection('users');
 

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(credential!.uid).get(),
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
          return CircleAvatar(
            backgroundColor: Color.fromARGB(255, 225, 225, 225),
            radius: 71,
            // backgroundImage: AssetImage("assets/img/avatar.png"),
            backgroundImage: NetworkImage(data['ImgLink']),
          );
        }

        return const Text("loading");
      },
    );
  }
}
