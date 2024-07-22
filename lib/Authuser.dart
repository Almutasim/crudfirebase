import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AuthExample(),
    );
  }
}

class AuthExample extends StatefulWidget {
  @override
  _AuthExampleState createState() => _AuthExampleState();
}

class _AuthExampleState extends State<AuthExample> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _signIn() async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      print("Signed in: ${userCredential.user?.email}");
    } catch (e) {
      print("Error: $e");
    }
  }

   void _forgetpass() async{

    try{
       await _auth.sendPasswordResetEmail(
      email: _emailController.text
      );
    }
    catch(e){
           print("rest link sent ");
    }
  }

  void _signUp() async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      print("Signed up: ${userCredential.user?.email}");
    } catch (e) {
      print("Error: $e");
    }
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Firebase Auth Example')),
      body: Center(
        child: Column(
          children: [
            TextField(controller: _emailController, decoration: InputDecoration(labelText: 'Email')),
            TextField(controller: _passwordController, decoration: InputDecoration(labelText: 'Password')),
            ElevatedButton(onPressed: _signIn, child: Text('Sign In')),
            ElevatedButton(onPressed: _signUp, child: Text('Sign Up')),
            ElevatedButton(onPressed: _forgetpass, child: Text('Reset'))
          ],
        ),
      ),
    );
  }
}
