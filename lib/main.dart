import 'package:chatapp/Screens/chat_screen.dart';
import 'package:chatapp/Screens/signin.dart';
import 'package:chatapp/Screens/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'Screens/home.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final _auth=FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ChatApp',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: _auth.currentUser!=null?'/chat':'/',
      routes :{
        '/': (context) => Home(),
        '/login': (context) => SignIn(),
        '/signup': (context) => SignUp(),
        '/chat': (context) => ChatScreen()
      },
    );
  }
}
