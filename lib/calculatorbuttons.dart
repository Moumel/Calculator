import 'package:flutter/material.dart';

class Cbuttons extends StatelessWidget {

  final color;
  final textColor;
  final String button;
  final buttonTap;

  Cbuttons({this.color, required this.button, this.textColor, this.buttonTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: buttonTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
            child: Container(
              color: color,
              child: Center(child: Text(button, style: TextStyle(color: textColor, fontSize: 20,),),),
            )),
      ),
    );
  }
}
