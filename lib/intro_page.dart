import 'package:cryptoX/my_dashboard_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cryptoX/app_utilities/theme.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  build(context) {
    return Scaffold(
      body: Container(
        // color: lightTheme(),
        width: double.infinity, //To take full possible screen width
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.all(10),
              child: Text('Welcome to ',
                  style: TextStyle(
                    // color: primaryColor(),
                    fontSize: 25,
                    fontFamily: 'Alpha',
                    fontWeight: FontWeight.w900,
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text('CRYPTOX',
                  style: TextStyle(
                    color: accentColor(),
                    fontSize: 65,
                    fontFamily: 'Alpha',
                    fontWeight: FontWeight.w900,
                  )),
            ),
            SizedBox(
              width: 250,
              child: text('A decentralized wallet app powered by Blockchain',
                  color: complementColor(),
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  textAlign: TextAlign.center),
            ),
            SizedBox(
                width: 350,
                child: Image.asset('assets/images/ethereum-logo.png')),
            SizedBox(
              width: 190,
              height: 50,
              child: shadowBox(
                context: context,
                content: button(
                  color: Colors.white,
                  onPressed: () {
                    Navigator.pushReplacement(
                        //To Invoke New Page (in this case that is MyHomePage which is a dashboard screen).
                        context,
                        MaterialPageRoute(builder: (context) => MyHomePage()));
                  },
                  content: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: SizedBox(
                          width: 25,
                          child: Image.asset('assets/images/G_logo.png'),
                        ),
                      ),
                      text('Sign-in with Google',
                          color: primaryColor(),
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                    ],
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 45,
                  width: 45,
                  margin: const EdgeInsets.only(top: 20, left: 10, right: 10),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(context).shadowColor,
                        blurRadius: 20,
                      )
                    ],
                  ),
                  child: button(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('OPENING: EMAIL SIGN-IN PAGE')));
                    },
                    content: const Icon(
                      FontAwesomeIcons.envelope,
                    ),
                    // color: accentColor(),
                  ),
                ),
                Container(
                  height: 45,
                  width: 45,
                  margin: const EdgeInsets.only(top: 20, left: 10, right: 10),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(context).shadowColor,
                        blurRadius: 20,
                      )
                    ],
                  ),
                  child: button(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('OPENING: PHONE NUMBER SIGN-IN PAGE')));
                    },
                    content: const Icon(
                      FontAwesomeIcons.mobileScreen,
                    ),
                    // color: accentColor(),
                  ),
                ),
                Container(
                  height: 45,
                  width: 45,
                  margin: const EdgeInsets.only(top: 20, left: 10, right: 10),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(context).shadowColor,
                        blurRadius: 20,
                      )
                    ],
                  ),
                  child: button(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('OPENING: EMAIL SIGN-IN PAGE')));
                    },
                    content: const Icon(
                      FontAwesomeIcons.facebook,
                    ),
                    // color: accentColor(),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
