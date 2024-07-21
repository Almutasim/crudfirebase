import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crudtest/adduser.dart';
import 'package:crudtest/firebase_options.dart';
import 'package:crudtest/getallusers.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  runApp( MaterialApp(
      title: 'FireStore Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: AddUser(),
    ));
}

