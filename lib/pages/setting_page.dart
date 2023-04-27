import 'package:cryptoX/profilepage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';

import '../apptheme/theme.dart';

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
            child: Lottie.asset('assets/anim/settings.json',
                // 'https://assets6.lottiefiles.com/packages/lf20_eu5gscby.json',
                width: 350),
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
          InkWell(
            onTap: () {},
            child: ListTile(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ProfilePage()));
              },
              leading: CircleAvatar(
                backgroundColor: accentColor(),
                radius: 16,
                child: Container(
                  margin: const EdgeInsets.only(right: 2),
                  child: Icon(
                    FontAwesomeIcons.addressCard,
                    size: 18,
                    color: primaryColor(),
                  ),
                ),
              ),
              title: const Text('My Profile',
                  style: TextStyle(fontFamily: 'Space', fontSize: 18)),
              trailing: const Padding(
                padding: EdgeInsets.only(right: 10),
                child: Icon(
                  FontAwesomeIcons.angleRight,
                  size: 15,
                ),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Divider(),
          ),
          InkWell(
            onTap: () {},
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: accentColor(),
                radius: 16,
                child: Icon(
                  FontAwesomeIcons.lockOpen,
                  size: 18,
                  color: primaryColor(),
                ),
              ),
              title: const Text('Backup | Security',
                  style: TextStyle(fontFamily: 'Space', fontSize: 18)),
              trailing: const Padding(
                padding: EdgeInsets.only(right: 10),
                child: Icon(
                  FontAwesomeIcons.angleRight,
                  size: 15,
                ),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Divider(),
          ),
          InkWell(
            onTap: () {},
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: accentColor(),
                radius: 16,
                child: Container(
                  margin: const EdgeInsets.only(right: 2),
                  child: Icon(
                    FontAwesomeIcons.palette,
                    size: 18,
                    color: primaryColor(),
                  ),
                ),
              ),
              title: const Text('Appearance',
                  style: TextStyle(fontFamily: 'Space', fontSize: 18)),
              trailing: const Padding(
                padding: EdgeInsets.only(right: 10),
                child: Icon(
                  FontAwesomeIcons.angleRight,
                  size: 15,
                ),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Divider(),
          ),
        ],
      ),
    );
  }
}
