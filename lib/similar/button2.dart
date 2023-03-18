import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../Screens/constants.dart';

class Button2 extends StatelessWidget {
  final String text;
  final VoidCallback press;
  const Button2({super.key, required this.text, required this.press});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:  press,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.6,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Center(
            child: Text(
          text,
          style: TextStyle(color: Colors.white),
        )),
      ),
    );
  }
}
