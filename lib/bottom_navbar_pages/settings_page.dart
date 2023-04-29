import 'package:cryptoX/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';

import '../app_theme/theme.dart';

class FourthPage extends StatefulWidget {
  const FourthPage({super.key});

  @override
  State<FourthPage> createState() => _FourthPageState();
}

class _FourthPageState extends State<FourthPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics:
          const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Lottie.asset('assets/anim/settings.json', width: 350),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 20, bottom: 20),
            child: Text(
              'Settings',
              style: TextStyle(
                  fontFamily: 'Space',
                  fontSize: 30,
                  fontWeight: FontWeight.w600),
            ),
          ),
          listTile(
              icon: FontAwesomeIcons.addressCard,
              title: 'My Profile',
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ProfilePage()));
              }),
          const Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Divider(),
          ),
          listTile(
              icon: FontAwesomeIcons.lockOpen,
              title: 'Backup | Security',
              onTap: () {}),
          const Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Divider(),
          ),
          listTile(
              icon: FontAwesomeIcons.palette,
              title: 'Appearance',
              subtitle: 'Light',
              onTap: () {}),
        ],
      ),
    );
  }
}
