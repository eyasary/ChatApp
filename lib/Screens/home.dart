import 'package:chatapp/Screens/signin.dart';
import 'package:chatapp/similar/button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';

import 'constants.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Container(
              child: Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
            Hero(
              tag: 'heroicon',
              child: Icon(
                Icons.textsms,
                size: 150,
                color: Colors.deepPurple[900],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Hero(
              tag: 'HeroTitle',
              child: Text(
                'Chatter',
                style: TextStyle(
                    color: Colors.deepPurple[900],
                    fontFamily: 'Poppins',
                    fontSize: 26,
                    fontWeight: FontWeight.w700),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            Text(
              "World's most private chatting app".toUpperCase(),
              style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 12,
                  color: Colors.deepPurple),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.15,
            ),
            Hero(
              tag: 'loginbutton',
               child: Button2(
                text: 'Login',
                press: () {
                  Navigator.pushNamed(context, '/login');
                
                },
              ),

            ),
            SizedBox(
              height: 10,
            ),
            Hero(
              tag: 'signupbutton',
              child: Button2(
                text: 'Signup',
                press: () {
                  Navigator.pushReplacementNamed(context, '/signup');
                },
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            Text('Made with ♥ by eya'),
          ])))),
    );
  }
}
