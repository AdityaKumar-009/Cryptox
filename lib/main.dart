import 'package:cryptoX/intro_page.dart';
import 'package:flutter/material.dart';
import 'package:cryptoX/app_utilities/theme.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  static SharedPreferences? sp;
  @override
  State<MyApp> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness:
          (MediaQuery.platformBrightnessOf(context) == Brightness.dark)
              ? Brightness.light
              : Brightness.dark,
    ));
    return MaterialApp(
      title: 'Cryptox',
      debugShowCheckedModeBanner: false, //To remove Debug Banner on AppBar
      themeMode: ThemeMode.system,
      darkTheme: MyTheme.darkTheme,
      theme: MyTheme.lightTheme,
      home: const StartPage(),
    );
  }
}
