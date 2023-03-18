import 'package:chatapp/Screens/constants.dart';
import 'package:chatapp/similar/button.dart';
import 'package:chatapp/similar/button2.dart';
//import 'package:edge_alert/edge_alert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _auth = FirebaseAuth.instance;
  String email = '';
  String password = '';
  bool spinner =false;
  @override
  Widget build(BuildContext context) {
    dynamic width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: spinner,
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: width * 0.05),
            height: MediaQuery.of(context).size.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Hero(
                  tag: 'heroicon',
                  child: Icon(Icons.textsms, size: 100, color: primaryColor),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Hero(
                  tag: 'HeroTitle',
                  child: Text(
                    'Chatter',
                    style: TextStyle(
                        color: primaryColor,
                        //fontFamily: 'Poppins',
                        fontSize: 26,
                        fontWeight: FontWeight.w700),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  margin: EdgeInsets.only(top: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                  ),
                  child: TextField(
                    obscureText: false,
                    autofocus: false,
                    onChanged: (value) {
                      email = value;
                    },
                    onSubmitted: (value) {},
                    decoration: InputDecoration(
                      icon: Icon(
                        Icons.mail,
                        color: primaryColor,
                      ),
                      border: InputBorder.none,
                      hintText: 'Email',
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  margin: EdgeInsets.only(top: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                  ),
                  child: TextField(
                    obscureText: true,
                    autofocus: false,
                    onChanged: (value) {
                      password = value;
                    },
                    onSubmitted: (value) {},
                    decoration: InputDecoration(
                      icon: Icon(
                        Icons.lock,
                        color: primaryColor,
                      ),
                      border: InputBorder.none,
                      hintText: 'Password',
                    ),
                  ),
                ),
                SizedBox(
                  height: 32,
                ),
                Button2(
                    text: 'LOGIN',
                    press: () async {
                      if(email!=null && password!=null)
                      {
                         setState(() {
                        spinner=true;
                      });
                      }
                      try {
                        final user = await _auth.signInWithEmailAndPassword(
                            email: email, password: password);
                        if (user != null) {
                          Navigator.pushNamed(context, '/chat');
                          setState(() {
                            spinner=false;
                          });
                        }
                      } catch (e) {
                        print(e);
                         setState(() {
                        spinner=false;
                      });
                      }
                    }),
                SizedBox(
                  height: 5,
                ),
                GestureDetector(
                    onTap: () {
                      Navigator.pushReplacementNamed(context, '/signup');
                    },
                    child: Text(
                      'or create an account',
                      style: TextStyle(
                          // fontFamily: 'Poppins',
                          fontSize: 12,
                          color: Colors.deepPurple),
                    )),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
                Hero(
                  tag: 'footer',
                  child: Text(
                    'Made with ♥ by eya',
                    /*   style: TextStyle(fontFamily: 'Poppins'),*/
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
