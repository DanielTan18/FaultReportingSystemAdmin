import 'package:flutter/material.dart';

//if you change screen, you can go back
void changeScreen(BuildContext context, Widget widget, {bool listen}) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
}

//if you change screen, cannot go back
void changeScreenReplacement(BuildContext context, Widget widget) {
  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => widget));
}
