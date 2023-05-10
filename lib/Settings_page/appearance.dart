import 'package:cryptoX/app_utilities/theme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

class Appearance extends StatefulWidget {
  const Appearance({super.key});

  // static String? option = MyApp.sp!.getString('theme');

  @override
  State<Appearance> createState() => _AppearanceState();
}

class _AppearanceState extends State<Appearance> {
  @override
  void initState() {
    // Appearance.option ??= 'System';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //

      appBar: titledAppBar(
          context: context,
          title: 'Appearance',
          putLeading: true,
          leadingContent: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(
                FontAwesomeIcons.angleLeft,
              ))),

      //

      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.all(20),
                child: text('Choose theme: ',
                    fontSize: 25, fontWeight: FontWeight.w600),
              ),
              Column(
                children: [
                  RadioListTile(
                      title: text('System Theme',
                          fontSize: 15,
                          color: //(Appearance.option == 'System')
                              //            ?
                              accentColor()),
                      //          : null),
                      value: 'System',
                      groupValue: 'System',
                      //Appearance.option,
                      onChanged: (newValue) {
                        // setState(() {
                        //   Appearance.option = 'System';
                        //   MyApp.sp!.setString('theme', 'System');
                        //   print(
                        //       'THEME ---------------------> ${MyApp.sp!.getString('theme')}');
                        // });
                      }),
                  // RadioListTile(
                  //
                  //     title: text('Light',
                  //         fontSize: 15,
                  //         color: (Appearance.option == 'Light')
                  //             ? accentColor()
                  //             : null),
                  //     value: 'Light',
                  //     groupValue: Appearance.option,
                  //     onChanged: (newValue) {
                  //       setState(() {
                  //         Appearance.option = 'Light';
                  //         SharedPreferences sp;
                  //         MyApp.sp!.setString('theme', 'Light');
                  //         print(
                  //             'THEME ---------------------> ${MyApp.sp!.getString('theme')}');
                  //       });
                  //     }),
                  // RadioListTile(
                  //     title: text('Dark',
                  //         fontSize: 15,
                  //         color: (Appearance.option == 'Dark')
                  //             ? accentColor()
                  //             : null),
                  //     value: 'Dark',
                  //     groupValue: Appearance.option,
                  //     onChanged: (newValue) {
                  //       setState(() {
                  //         Appearance.option = 'Dark';
                  //         SharedPreferences sp;
                  //         MyApp.sp!.setString('theme', 'Dark');
                  //         print(
                  //             'THEME ---------------------> ${MyApp.sp!.getString('theme')}');
                  //       });
                  //     })
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
