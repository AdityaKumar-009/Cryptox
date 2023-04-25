import 'package:cryptoX/MyDashBoardPage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'apptheme/theme.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  build(context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        // decoration: const BoxDecoration(
        //   gradient: LinearGradient(
        //     colors: [
        //       // Color(0xffa8edea),
        //       // Color(0xfed6e3ff),
        //       Color(0xfed6e3ff),
        //       Colors.white,
        //     ],
        //     end: Alignment(0.5, 0.0),
        //     begin: Alignment(0.5, 1.0),
        //   ),
        // ),
        width: double.infinity, //To take full possible screen width
        // color: Colors.orange,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text('Welcome to ',
                  style: TextStyle(
                    color: primaryColor(),
                    fontSize: 25,
                    fontFamily: 'Alpha',
                    fontWeight: FontWeight.w900,
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child:
                  // RichText(
                  //     text: const TextSpan(
                  //         style: TextStyle(
                  //             fontSize: 65,
                  //             fontFamily: 'Alpha',
                  //             fontWeight: FontWeight.w900),
                  //         children: [
                  //       TextSpan(
                  //           text: 'C', style: TextStyle(color: Color(0xffFEED5B))),
                  //       TextSpan(
                  //           text: 'R', style: TextStyle(color: Color(0xffF48067))),
                  //       TextSpan(
                  //           text: 'Y', style: TextStyle(color: Color(0xff53BA68))),
                  //       TextSpan(
                  //           text: 'P', style: TextStyle(color: Colors.black54)),
                  //       TextSpan(
                  //           text: 'T', style: TextStyle(color: Color(0xffA85CA5))),
                  //       TextSpan(
                  //           text: 'O', style: TextStyle(color: Color(0xff01B3E2))),
                  //       TextSpan(
                  //           text: 'X', style: TextStyle(color: Color(0xff6676B9))),
                  //     ])),
                  Text('CRYPTOX',
                      style: TextStyle(
                        // color: Colors.blue,
                        color: accentColor(),
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
                'A decentralized wallet app powered by Blockchain',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  // color: Colors.grey.shade400,
                  color: complementColor(),
                  // fontWeight: FontWeight.w400,
                  fontFamily: 'Space',
                ),
              ),
            ),
            SizedBox(
                width: 350,
                child: Image.asset('assets/images/ethereum-logo.png')),
            SizedBox(
              width: 210,
              height: 50,
              child: Container(
                decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xffe1e1e1),
                      blurRadius: 40,
                      // spreadRadius: 5
                    )
                  ],
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    //To Add new styles to existing button
                    backgroundColor: Colors.white,
                    elevation: 2,
                    shadowColor: const Color(0x80f3f3f3),
                    shape: RoundedRectangleBorder(
                        //to set border radius to button
                        borderRadius: BorderRadius.circular(8)),
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
                            fontFamily: 'Space',
                            fontWeight: FontWeight.w600),
                      ),
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
                  decoration: const BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xffe1e1e1),
                        blurRadius: 20,
                      )
                    ],
                  ),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      //To Add new styles to existing button
                      backgroundColor: Colors.red.shade400,
                      elevation: 1,
                      shadowColor: const Color(0x80f3f3f3),
                      padding: const EdgeInsets.all(0),
                      shape: RoundedRectangleBorder(
                          //to set border radius to button
                          borderRadius: BorderRadius.circular(5)),
                    ),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('OPENING: EMAIL SIGN-IN PAGE')));
                    },
                    child: const SizedBox(
                      // width: 25,
                      child: Icon(
                        FontAwesomeIcons.envelope,
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 45,
                  width: 45,
                  margin: const EdgeInsets.only(top: 20, left: 10, right: 10),
                  decoration: const BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xffe1e1e1),
                        blurRadius: 20,
                      )
                    ],
                  ),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      //To Add new styles to existing button
                      backgroundColor: Colors.green.shade400,
                      elevation: 1,
                      shadowColor: const Color(0x80f3f3f3),
                      padding: const EdgeInsets.only(right: 5),
                      shape: RoundedRectangleBorder(
                          //to set border radius to button
                          borderRadius: BorderRadius.circular(5)),
                    ),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('OPENING: Phone Sign-in Page')));
                    },
                    child: const SizedBox(
                      // width: 25,
                      child: Icon(
                        Icons.mobile_friendly,
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 45,
                  width: 45,
                  margin: const EdgeInsets.only(top: 20, left: 10, right: 10),
                  decoration: const BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xffe1e1e1),
                        blurRadius: 20,
                      )
                    ],
                  ),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      //To Add new styles to existing button
                      // backgroundColor: Colors.white,
                      backgroundColor: Colors.blue.shade600,
                      elevation: 1,
                      shadowColor: const Color(0x80f3f3f3),
                      padding: const EdgeInsets.all(0),
                      shape: RoundedRectangleBorder(
                          //to set border radius to button
                          borderRadius: BorderRadius.circular(5)),
                    ),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('OPENING: FACEBOOK SIGN-IN')));
                    },
                    child: const SizedBox(
                      // width: 25,
                      child: Icon(
                        FontAwesomeIcons.facebook,
                      ),
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
