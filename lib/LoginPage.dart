import 'package:cryptoX/main.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  build(context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xffa8edea), Color(0xfed6e3ff)],
            end: Alignment(1.0, 0.0),
            begin: Alignment(0.0, 1.0),
          ),
        ),
        width: double.infinity,
        // color: Colors.orange,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            RichText(
              text: const TextSpan(
                  text: 'Welcome to ',
                  style: TextStyle(
                    color: Color(0xff1f1f1f),
                    fontSize: 30,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                  ),
                  children: [
                    TextSpan(
                        text: 'cryptoX',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.w700,
                        ))
                  ]),
            ),
            SizedBox(
              width: 250,
              child: Text(
                'A wallet app powered by Blockchain Technology.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade500,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Poppins',
                ),
              ),
            ),
            SizedBox(
                width: 350,
                child: Image.asset('assets/images/ethereum-logo.png')),
            SizedBox(
              width: 210,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  // backgroundColor: const Color(0xfff0f8ff),
                  backgroundColor: Colors.white,
                  //background color of button
                  // side: const BorderSide(width: 2, color: Colors.orange),
                  //border width and color
                  elevation: 3,
                  // shadowColor: Color(0xff57aef5),
                  //elevation of button
                  shape: RoundedRectangleBorder(
                      //to set border radius to button
                      borderRadius: BorderRadius.circular(30)),
                  //content padding inside button
                ),
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              MyHomePage(title: 'Hi, Aditya')));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 25,
                      child: Image.asset('assets/images/G_logo.png'),
                    ),
                    const Text(
                      'Sign-in with Google',
                      style: TextStyle(
                          // color: Colors.orange,
                          color: Colors.black87,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('OPENING: FACEBOOK SIGN-IN')));
                  },
                  child: Container(
                    margin: const EdgeInsets.only(top: 25, left: 15, right: 15),
                    height: 40,
                    width: 40,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Color(0xffe1eeff),
                    ),
                    child: Icon(
                      FontAwesomeIcons.facebook,
                      color: Colors.blue.shade600,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('OPENING: EMAIL SIGN-IN PAGE')));
                  },
                  child: Container(
                    margin: const EdgeInsets.only(top: 25, left: 15, right: 15),
                    height: 40,
                    width: 40,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Color(0xffffeeee),
                    ),
                    child: Icon(
                      FontAwesomeIcons.envelope,
                      color: Colors.red.shade300,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('OPENING: Twitter Page')));
                  },
                  child: Container(
                    margin: const EdgeInsets.only(top: 25, left: 15, right: 15),
                    height: 40,
                    width: 40,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Color(0xffe1f9fc),
                    ),
                    child: Icon(
                      FontAwesomeIcons.twitter,
                      color: Colors.blue.shade400,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('OPENING: Phone Sign-in Page')));
                  },
                  child: Container(
                    margin: const EdgeInsets.only(top: 25, left: 15, right: 15),
                    height: 40,
                    width: 40,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Color(0xffebffdf),
                    ),
                    child: Icon(
                      FontAwesomeIcons.whatsapp,
                      color: Colors.green.shade300,
                    ),
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
