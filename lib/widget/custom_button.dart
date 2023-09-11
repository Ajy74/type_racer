import 'package:flutter/material.dart';

class CustomeButtom extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final bool isHome;
  const CustomeButtom({
    super.key,
    required this.text,
    required this.onTap,
    this.isHome=false,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        minimumSize: Size(!isHome? width : width/5, 50),
      ), 
      child: Text(
        text,
        style:const TextStyle(
          fontSize: 16,
          color: Colors.white
        ),
      ),
    );
  }
}