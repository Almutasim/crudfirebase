import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crudtest/Model/userModel.dart';
import 'package:flutter/material.dart';

class GetUserName extends StatelessWidget {
  final String documentId;

  GetUserName(this.documentId);

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(documentId).get(),
      builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;

          User user = User.fromJson(data);
          return Scaffold(
            appBar: AppBar(title: Text("user"),),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: 20,
                    child: Text("Full Name : ${user.fullNametext}"),
                  ),
                  Container(
                     height: 20,
                    child: Text("Company : ${user.company}"),
                  ),
                  Container(
                     height: 20,
                    child: Text("Age: ${user.age}"),
                  ),
              
                ],
              ),
            ),
          );
          //  Text("Full Name: ${user.fullNametext}, Company: ${user.company}, Age: ${user.age}");
        }

        return Text("Loading");
      },
    );
  }
}
