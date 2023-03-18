import 'package:chatapp/Screens/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class Button extends StatelessWidget {
  final IconData icon;
  final String name;
  final Function ontap;
  final bool obscure;
  const Button({super.key, required this.icon, required this.name, required this.ontap, required this.obscure});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12),
      margin: EdgeInsets.only(top: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      child: TextField(
        obscureText: obscure,
        autofocus: false,
        onChanged: (value) =>ontap,
        onSubmitted: (value) {},
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: primaryColor,
          ),
          border: InputBorder.none,
          hintText: name,
        ),
        
      ),
    );
  }
}
