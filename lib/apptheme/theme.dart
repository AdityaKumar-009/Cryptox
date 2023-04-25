import 'package:flutter/material.dart';

Color accentColor() {
  // return const Color(0xff1448f1); //BLUE
  // return const Color(0xffEECB6B);  //LIGHT GOLD
  // return const Color(0xffDBB44B);  //LITTLE DARKER THAN PREVIOUS
  return const Color(
      0xffc9a408); //CURRENT USED GOLD COLOR (MORE DARKER THAN BOTH...)
}

Color primaryColor() {
  return const Color(0xff1b1b1b); // 10% LESS DARKER THAN BLACK
}

Color complementColor() {
  return const Color(0xffbdbdbd);
  // Color(0xffe4e4e4);
}

Color lightTheme() {
  return Colors.white;
}

Color darkTheme() {
  return const Color(0xff000000);
}
