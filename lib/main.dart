import 'package:cryptoX/intro_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_theme/theme.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
    statusBarBrightness: Brightness.dark,
  ));
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cryptox',
      debugShowCheckedModeBanner: false, //To remove Debug Banner on AppBar
      theme: ThemeData(
          primaryColor: Colors.orangeAccent,
          radioTheme: RadioThemeData(
            fillColor: MaterialStatePropertyAll(accentColor()),
            overlayColor: MaterialStatePropertyAll(primaryColor()),
          )),
      home: const StartPage(),
    );
  }
}
