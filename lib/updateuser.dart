import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

class UpdateUser extends StatefulWidget {
  final String documentId;

  UpdateUser(this.documentId);

  @override
  _UpdateUserState createState() => _UpdateUserState();
}

class _UpdateUserState extends State<UpdateUser> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _companyController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();

  CollectionReference users = FirebaseFirestore.instance.collection('users');

  Future<void> fetchUserData() async {
    DocumentSnapshot doc = await users.doc(widget.documentId).get();
    Map<String, dynamic> data = doc.data()! as Map<String, dynamic>;
    _fullNameController.text = data['full_name'];
    _companyController.text = data['company'];
    _ageController.text = data['age'].toString();
  }

  Future<void> updateUser(String fullName, String company, int age) {
    return users
        .doc(widget.documentId)
        .update({'full_name': fullName, 'company': company, 'age': age})
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _companyController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update User'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _fullNameController,
                decoration: InputDecoration(labelText: 'Full Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter full name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _companyController,
                decoration: InputDecoration(labelText: 'Company'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a company name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _ageController,
                decoration: InputDecoration(labelText: 'Age'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter age';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    updateUser(
                      _fullNameController.text,
                      _companyController.text,
                      int.parse(_ageController.text),
                    ).then((_) {
                      Navigator.pop(context);
                    });
                  }
                },
                child: Text("Update User"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
