import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GetUserName extends StatelessWidget {
  final String documentId;

  GetUserName(this.documentId);

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder<DocumentSnapshot>(
          future: users.doc(documentId).get(),
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        
            if (snapshot.hasError) {
              return Text("Something went wrong");
            }
        
            if (snapshot.hasData && !snapshot.data!.exists) {
              return Text("Document does not exist");
            }
        
            if (snapshot.connectionState == ConnectionState.done) {
              Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
              return Text("Full Name: ${data['full_name']} ${data['company']}");
            }
        
            return Text("loading");
          },
        ),
      ),
    );
  }
}