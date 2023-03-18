//import 'package:edge_alert/edge_alert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../similar/button.dart';
import '../similar/button2.dart';
import 'constants.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _auth = FirebaseAuth.instance;
 String email='';
 String password='';
String name='';
 bool spinner = false;
  @override
  Widget build(BuildContext context) {
    dynamic width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
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
           name=value;
          },
          onSubmitted: (value) {},
          decoration: InputDecoration(
            icon: Icon(
              Icons.text_format,
              color: primaryColor,
            ),
            border: InputBorder.none,
            hintText:'Name',
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
          obscureText: false,
          autofocus: false,
          onChanged: (value) {
           email=value;
          },
          onSubmitted: (value) {},
          decoration: InputDecoration(
            icon: Icon(
              Icons.mail,
              color: primaryColor,
            ),
            border: InputBorder.none,
            hintText:'Email',
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
            password=value;
          },
          onSubmitted: (value) {},
          decoration: InputDecoration(
            icon: Icon(
              Icons.lock,
              color: primaryColor,
            ),
            border: InputBorder.none,
            hintText:'Password',
          ),
          
        ),
          ),
                SizedBox(
                  height: 32,
                ),
                Button2(text: 'Sign Up',
                 press: ()async{
                  // print(password);
                   //print(email);
                   //print(name);
                   if (name != null && password != null && email != null) {
                   setState(() {
                     spinner=true;
                   });
                   }
                   
                try{
                    final newUser= await _auth.createUserWithEmailAndPassword(email: email, password: password);
                    Navigator.pushNamed(context, '/chat');
                    setState(() {
                      spinner=false;
                    });
                }
                catch(e)
                {
                  print(e);
                }
                },),
                SizedBox(
                  height: 5,
                ),
                GestureDetector(
                    onTap: () {
                      Navigator.pushReplacementNamed(context, '/login');
                    },
                    child: Text(
                      'or log in instead',
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
