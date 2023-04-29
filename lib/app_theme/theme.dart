import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Color accentColor() {
  // return const Color(0xff1448f1); //DARK BLUE
  // return const Color(0xffEECB6B);  //LIGHT GOLD : ACCENT COLOR
  // return const Color(0xffDBB44B);  //LITTLE DARKER THAN PREVIOUS

  //CURRENT USED GOLD COLOR (MORE DARKER THAN BOTH...)

  return const Color(0xffc9a408);
}

Color accentColor2() {
  return const Color(0xffEECB6B); //LIGHT GOLD : ACCENT COLOR
}

Color primaryColor() {
  return const Color(0xff1b1b1b); // 10% LESS DARKER THAN BLACK
  // return Colors.white;
}

Color complementColor() {
  return const Color(0xffbdbdbd);
  // Color(0xffe4e4e4);
}

Color lightGrey() {
  return Colors.grey.shade50;
  // return const Color(0xff181818);
}

Color lightTheme() {
  // return Colors.black;
  return Colors.white;
}

Color darkTheme() {
  return const Color(0xff000000);
}

Color red() {
  return Colors.red.shade500;
}

Color green() {
  return const Color(0xff2CDA94);
}

// CUSTOM TEXT WITH  ' SPACE ' FONT FOR CRYPTOX APP
Text text(
  String text2Show, {
  Color color = const Color(0xff1b1b1b),
  double fontSize = 20,
  TextAlign textAlign = TextAlign.start,
  fontWeight = FontWeight.w400,
}) {
  return Text(
    text2Show,
    textAlign: textAlign,
    style: TextStyle(
      fontFamily: 'Space',
      color: color,
      fontSize: fontSize,
      fontWeight: fontWeight,
    ),
  );
}

// CUSTOM CIRCLE AVATAR FOR CRYPTOX
CircleAvatar circularProfile({
  ImageProvider? image,
  double circleRadius = 25,
  Color color = const Color(0xffe8e8e8),
  Widget? content,
}) {
  return CircleAvatar(
    backgroundImage: image,
    radius: circleRadius,
    backgroundColor: color,
    child: content,
  );
}

// APP CUSTOM BUTTON FOR CRYPTOX
ElevatedButton button(
    {required void Function()? onPressed,
    required Widget content,
    Color color = Colors.white,
    double elevation = 2,
    Color elevationColor = const Color(0x80f3f3f3)}) {
  return ElevatedButton(
    onPressed: onPressed,
    style: ElevatedButton.styleFrom(
      padding: const EdgeInsets.all(0),
      backgroundColor: color,
      elevation: elevation,
      shadowColor: elevationColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
    child: content,
  );
}

// CUSTOM APP BAR FOR CRYPTOX
AppBar appBar({
  required Widget content,
  bool alignCenter = true,
  bool putLeading = false,
  double elevation = 1,
  Widget? leadingContent,
  Color elevationColor = const Color(0x10000000),
}) {
  return AppBar(
    leading: leadingContent,
    centerTitle: alignCenter,
    toolbarHeight: 80,
    automaticallyImplyLeading: putLeading,
    backgroundColor: lightTheme(),
    elevation: elevation,
    shadowColor: elevationColor,
    title: content,
  );
}

// APP BAR FOR SHOWING ONLY TITLE [ IN CENTER ] FOR CRYPTOX
AppBar titledAppBar({
  required String title,
  bool putLeading = false,
  Widget? leadingContent,
  double elevation = 2,
}) {
  return appBar(
      elevation: elevation,
      putLeading: putLeading,
      leadingContent: leadingContent,
      content: text(
        title,
        textAlign: TextAlign.center,
        fontSize: 30,
        fontWeight: FontWeight.w700,
      ));
}

// CRYPTOX BOTTOM NAVIGATION BAR [ used in wallet creation | restoration etc. ]
BottomAppBar bottomBar({required Widget content}) {
  return BottomAppBar(
    color: lightTheme(),
    height: 80,
    elevation: 0,
    child: content,
  );
}

// ROUNDED CONTAINERS VALUE:
BorderRadiusGeometry round_16() {
  return const BorderRadius.all(Radius.circular(16));
}

BorderRadiusGeometry round_8() {
  return const BorderRadius.all(Radius.circular(16));
}

// CONTAINER WITH LITTLE BACK SHADOW
Widget shadowBox({
  required Widget content, // REQUIRES A CONTENT WITH DEFINITE WIDTH, HEIGHT
  EdgeInsetsGeometry margin = EdgeInsets.zero,
  EdgeInsetsGeometry padding = EdgeInsets.zero,
  Color shadowColor = const Color(0xffeaeaea),
}) {
  return Container(
    padding: padding,
    margin: margin,
    decoration: BoxDecoration(
      borderRadius: round_16(),
      color: lightTheme(),
      boxShadow: [
        BoxShadow(
          color: shadowColor,
          blurRadius: 20,
          // spreadRadius: 5
        )
      ],
    ),
    child: content,
  );
}

Widget inputField({
  String hintText = '',
  String helperText = '',
  TextAlign textAlign = TextAlign.start,
  double fontSize = 15,
  FontWeight fontWeight = FontWeight.w400,
  void Function()? onTap,
  int? maxLength,
  void Function(String)? onChanged,
  void Function(String)? onSubmitted,
  TextEditingController? controller,
  Color shadowColor = const Color(0xffeaeaea),
}) {
  return Stack(
    clipBehavior: Clip.none,
    children: [
      Positioned(
        top: 5,
        left: 0,
        right: 0,
        child: shadowBox(
            shadowColor: shadowColor,
            content: const SizedBox(
              height: 45,
            )),
      ),
      TextField(
        autocorrect: false,
        cursorColor: accentColor(),
        maxLength: maxLength,
        decoration: InputDecoration(
          fillColor: lightTheme(),
          filled: true,
          hintText: hintText,
          helperStyle: TextStyle(
              fontSize: 10,
              fontFamily: 'Space',
              fontWeight: fontWeight,
              color: Colors.grey.shade500),
          helperText: helperText,
          helperMaxLines: 2,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        controller: controller,
        onTap: onTap,
        onSubmitted: onSubmitted,
        onChanged: onChanged,
        textAlign: textAlign,
        style: TextStyle(
            fontSize: fontSize,
            fontFamily: 'Space',
            fontWeight: fontWeight,
            color: primaryColor()),
      )
    ],
  );
}

// FOR SETTINGS PAGE - SETTING TILES
ListTile listTile({
  void Function()? onTap,
  required IconData icon,
  required String title,
  String? subtitle,
}) {
  return ListTile(
    subtitle: (subtitle != null)
        ? text(subtitle,
            fontSize: 12, color: complementColor(), fontWeight: FontWeight.w600)
        : null,
    onTap: onTap,
    leading: CircleAvatar(
      backgroundColor: accentColor(),
      radius: 16,
      child: Container(
        margin: const EdgeInsets.only(right: 2),
        child: Icon(
          icon,
          size: 18,
          color: primaryColor(),
        ),
      ),
    ),
    title: text(title, fontSize: 18),
    trailing: const Padding(
      padding: EdgeInsets.only(right: 10),
      child: Icon(
        FontAwesomeIcons.angleRight,
        size: 15,
      ),
    ),
  );
}
