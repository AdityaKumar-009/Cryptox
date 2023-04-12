import 'package:cryptoX/MyDashBoardPage.dart';
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
        width: double.infinity, //To take full possible screen width
        // color: Colors.orange,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.all(10),
              child: Text('Welcome to ',
                  style: TextStyle(
                    color: Color(0xff1f1f1f),
                    fontSize: 25,
                    fontFamily: 'Alpha',
                    fontWeight: FontWeight.w900,
                  )),
            ),
            const Padding(
              padding: EdgeInsets.all(10.0),
              child: Text('CRYPTOX',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 65,
                    fontFamily: 'Alpha',
                    fontWeight: FontWeight.w900,
                  )),
            ),
            //--------------------- |       PREVIOUS TEXT      | --------------------------->
            // RichText(
            //   text: const TextSpan(
            //       // text: 'Welcome to ',
            //       style: TextStyle(
            //         color: Color(0xff1f1f1f),
            //         fontSize: 25,
            //         fontFamily: 'Alpha',
            //         fontWeight: FontWeight.w900,
            //       ),
            //       children: [
            //         TextSpan(
            //             text: 'CRYPTOX',
            //             style: TextStyle(
            //               color: Colors.blue,
            //               fontSize: 55,
            //               fontFamily: 'Alpha',
            //               fontWeight: FontWeight.w900,
            //             ))
            //       ]),
            // ),
            SizedBox(
              width: 250,
              child: Text(
                'A decentralized wallet app powered by Blockchain Technology.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade500,
                  fontWeight: FontWeight.w400,
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
                  //To Add new styles to existing button
                  backgroundColor: Colors.white,
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                      //to set border radius to button
                      borderRadius: BorderRadius.circular(30)),
                ),
                onPressed: () {
                  Navigator.pushReplacement(
                      //To Invoke New Page (in this case that is MyHomePage which is an account dashboard screen).
                      context,
                      MaterialPageRoute(builder: (context) => MyHomePage()));
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
                      Icons.mobile_friendly,
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
