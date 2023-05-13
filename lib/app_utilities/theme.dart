import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MyTheme {
  static final lightTheme = ThemeData(
      scaffoldBackgroundColor: Colors.grey.shade50,
      primaryColor: Colors.black,
      colorScheme: const ColorScheme.light(),
      shadowColor: const Color(0xffeaeaea),
      canvasColor: const Color(0xff2f2f2f),
      applyElevationOverlayColor: false,
      radioTheme: RadioThemeData(
        fillColor: MaterialStatePropertyAll(accentColor()),
        overlayColor: MaterialStatePropertyAll(primaryColor()),
      ));

  static final darkTheme = ThemeData(
      applyElevationOverlayColor: false,
      scaffoldBackgroundColor: const Color(0xff232323),
      colorScheme: const ColorScheme.dark(),
      canvasColor: const Color(0xffe4e4e4),
      shadowColor: const Color(0xff333333),
      buttonTheme: ButtonThemeData(
        buttonColor: accentColor(),
      ),
      radioTheme: RadioThemeData(
        fillColor: MaterialStatePropertyAll(accentColor()),
        overlayColor: MaterialStatePropertyAll(primaryColor()),
      ));
}

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
  // return const Color(0xfff3f3f3);
}

Color complementColor() {
  // return const Color(0xff757575); // FOR DARK THEME
  // return const Color(0xffe4e4e4);
  return const Color(0xff858585);
}

Color lightGrey() {
  // return Colors.grey.shade50;
  // return const Color(0xff1a1a1a);
  return const Color(0xff232323);
}

Color lightTheme() {
  // return const Color(0xff1a1a1a);
  // return const Color(0xff111111);
  return Colors.white;
}

Color darkTheme() {
  return const Color(0xff000000);
  // return const Color(0xffeaeaea);
}

Color red() {
  return Colors.red.shade500;
}

Color green() {
  return const Color(0xff2CDA94);
}

// CUSTOM TEXT WITH  ' SPACE ' FONT FOR CRYPTOX APP
Text text(
  String, {
  // Color color = const Color(0xff1b1b1b),
  // Color color = Colors.white,
  Color? color,
  double fontSize = 15,
  TextAlign textAlign = TextAlign.start,
  fontWeight = FontWeight.w400,
}) {
  // color = primaryColor();
  return Text(
    String,
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
  required BuildContext context,
  ImageProvider? image,
  double circleRadius = 25,
  Color color = const Color(0xffe8e8e8),
  Widget? content,
}) {
  return CircleAvatar(
    backgroundImage: image,
    radius: circleRadius,
    backgroundColor:
        (MediaQuery.of(context).platformBrightness == Brightness.dark)
            ? const Color(0xFF4F4F4F)
            : const Color(0xffe7e7e7),
    child: content,
  );
}

// APP CUSTOM BUTTON FOR CRYPTOX
ElevatedButton button({
  required void Function()? onPressed,
  required Widget content,
  Color color = const Color(0xffc9a408),
  double elevation = 2,
  // Color elevationColor = const Color(0x80f3f3f3)
}) {
  // color = lightTheme();
  return ElevatedButton(
    onPressed: onPressed,
    style: ElevatedButton.styleFrom(
      padding: const EdgeInsets.all(0),
      backgroundColor: color,
      elevation: elevation,
      // shadowColor: elevationColor,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(width: 0, color: color)),
    ),
    child: content,
  );
}

// CUSTOM APP BAR FOR CRYPTOX
AppBar appBar(
    {required Widget content,
    bool alignCenter = true,
    bool putLeading = false,
    double elevation = 1,
    Widget? leadingContent,
    required Color backgroundColor,
    Color elevationColor = const Color(0x10000000),
    Color? foregroundColor}) {
  return AppBar(
    leading: leadingContent,
    centerTitle: alignCenter,
    toolbarHeight: 80,
    automaticallyImplyLeading: putLeading,
    backgroundColor: backgroundColor,
    foregroundColor: foregroundColor,
    elevation: elevation,
    shadowColor: elevationColor,
    title: content,
  );
}

// APP BAR FOR SHOWING ONLY TITLE [ IN CENTER ] FOR CRYPTOX
AppBar titledAppBar({
  required String title,
  required BuildContext context,
  bool putLeading = false,
  Widget? leadingContent,
  double elevation = 2,
}) {
  return appBar(
      foregroundColor: Theme.of(context).colorScheme.inverseSurface,
      elevation: elevation,
      putLeading: putLeading,
      leadingContent: leadingContent,
      content: text(
        title,
        textAlign: TextAlign.center,
        fontSize: 30,
        fontWeight: FontWeight.w700,
      ),
      backgroundColor: Theme.of(context).cardColor);
}

// CRYPTOX BOTTOM NAVIGATION BAR [ used in wallet creation | restoration etc. ]
BottomAppBar bottomBar(
    {required Widget content, required BuildContext context}) {
  return BottomAppBar(
    color: Theme.of(context).scaffoldBackgroundColor,
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
  return const BorderRadius.all(Radius.circular(8));
}

// CONTAINER WITH LITTLE BACK SHADOW
Widget shadowBox({
  required Widget content, // REQUIRES A CONTENT WITH DEFINITE WIDTH, HEIGHT
  EdgeInsetsGeometry margin = EdgeInsets.zero,
  EdgeInsetsGeometry padding = EdgeInsets.zero,
  required BuildContext context,
  Color? shadowColor,
  Color? backgroundColor,
  // Color shadowColor = const Color(0xff333333),
}) {
  return Container(
    padding: padding,
    margin: margin,
    decoration: BoxDecoration(
      borderRadius: round_16(),
      color: (backgroundColor == null)
          ? Theme.of(context).cardColor
          : backgroundColor,
      boxShadow: [
        BoxShadow(
          color: (shadowColor == null)
              ? (MediaQuery.platformBrightnessOf(context) == Brightness.light)
                  ? Theme.of(context).shadowColor
                  : Colors.transparent
              : shadowColor,
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
  required BuildContext context,
  FontWeight fontWeight = FontWeight.w400,
  void Function()? onTap,
  int? maxLength,
  void Function(String)? onChanged,
  void Function(String)? onSubmitted,
  TextEditingController? controller,
  Color? shadowColor,
  Color? backgroundColor,
  Color? textColor,
  TextInputType keyboardType = TextInputType.text,
  bool autofocus = false,
  Widget? prefix,
  List<TextInputFormatter>? inputFormatters,
}) {
  return Stack(
    clipBehavior: Clip.none,
    children: [
      Positioned(
        top: 5,
        left: 0,
        right: 0,
        child: shadowBox(
            backgroundColor: backgroundColor,
            context: context,
            shadowColor: (shadowColor == null)
                ? (MediaQuery.platformBrightnessOf(context) == Brightness.light)
                    ? const Color(0xffeaeaea)
                    : Colors.transparent
                : shadowColor,
            content: const SizedBox(
              height: 45,
            )),
      ),
      TextField(
          inputFormatters: inputFormatters,
          autofocus: autofocus,
          autocorrect: false,
          cursorColor: accentColor(),
          maxLength: maxLength,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            // prefixText: '₹',
            prefix: prefix,
            fillColor: (backgroundColor == null)
                ? Theme.of(context).cardColor
                : backgroundColor,
            filled: true,
            hintText: hintText,
            hintStyle: TextStyle(
              color: (textColor == null) ? const Color(0xFF969494) : textColor,
            ),
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
            color: (textColor == null)
                ? Theme.of(context).colorScheme.inverseSurface
                : textColor,
          ))
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
        ? Text(
            subtitle,
            style: TextStyle(
                fontSize: 10,
                color: complementColor(),
                fontWeight: FontWeight.w600,
                fontFamily: 'Space'),
          )
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
