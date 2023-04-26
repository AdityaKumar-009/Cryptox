import 'package:cryptoX/my_dashboard_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Scan2Pay.dart';
import 'apptheme/theme.dart';

class ProfilePage extends StatefulWidget {
  String? pubKey;

  ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with SingleTickerProviderStateMixin {
  fetch() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    setState(() {
      widget.pubKey = sp.getString(MyHomePageState.PUBLICADDRESS);
    });
  }

  late final AnimationController _animController =
      AnimationController(vsync: this, duration: const Duration(seconds: 8));

  @override
  void initState() {
    fetch();
    _animController.forward();
    Future.delayed(const Duration(seconds: 5), () {
      _animController.stop();
    });
    super.initState();
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        foregroundColor: Colors.black,
        // leading: IconButton(
        //     onPressed: () {
        //       Navigator.of(context).pop();
        //     },
        //     icon: const Icon(FontAwesomeIcons.close)),
        title: const Text('MY PROFILE',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 30,
                fontFamily: 'Space',
                // color: Color.fromARGB(255, 71, 217, 204),
                fontWeight: FontWeight.w700)),
        centerTitle: true,
        toolbarHeight: 80,
        shadowColor: const Color(0x10000000),
        backgroundColor: lightTheme(),
      ),
      body: Container(
        // color: Colors.grey.shade50,
        color: lightTheme(),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          child: SizedBox(
            height: 745,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 350,
                    height: 620,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0xffe1e1e1),
                          blurRadius: 40,
                          // spreadRadius: 5
                        )
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Positioned(
                            right: 112,
                            top: -75,
                            child: Hero(
                              tag: 'profile',
                              child: Container(
                                // width: 100,
                                margin:
                                    const EdgeInsets.only(top: 10, bottom: 10),
                                child: const Card(
                                  shape: CircleBorder(),
                                  elevation: 20,
                                  // shadowColor: Colors,
                                  child: CircleAvatar(
                                    backgroundColor:
                                        Color.fromARGB(100, 0, 90, 100),
                                    // backgroundColor: Colors.transparent,
                                    backgroundImage:
                                        AssetImage('assets/images/Adit.jpg'),
                                    radius: 50,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 50,
                            left: 0,
                            right: 0,
                            child: Text(userName,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontSize: 30,
                                    fontFamily: 'Space',
                                    // color: Color.fromARGB(255, 71, 217, 204),
                                    // color: Colors.black,
                                    fontWeight: FontWeight.w700)),
                          ),
                          Positioned(
                            left: 0,
                            right: 0,
                            top: 45,
                            child:
                                // (widget.pubKey != null)
                                // ?
                                //   Column(
                                //   mainAxisAlignment:
                                //   MainAxisAlignment.spaceEvenly,
                                //   children: [
                                //     InkWell(
                                //       onTap: () async {
                                //         Clipboard.setData(ClipboardData(
                                //             text:
                                //             widget.pubKey.toString()))
                                //             .then((_) {
                                //           ScaffoldMessenger.of(context)
                                //               .showSnackBar(SnackBar(
                                //             showCloseIcon: true,
                                //             backgroundColor:
                                //             Colors.green.shade700,
                                //             behavior:
                                //             SnackBarBehavior.floating,
                                //             content: const Text(
                                //               'Copied to your clipboard !',
                                //               style: TextStyle(
                                //                   fontFamily: 'Space'),
                                //             ),
                                //           ));
                                //         });
                                //         // copied successfully
                                //       },
                                //       child: Container(
                                //         margin: const EdgeInsets.fromLTRB(
                                //             0, 10, 0, 30),
                                //         // height: 40,
                                //         padding: const EdgeInsets.fromLTRB(
                                //             15, 10, 10, 10),
                                //         width: 300,
                                //         decoration: const BoxDecoration(
                                //           color: Color(0xffffe093),
                                //           borderRadius: BorderRadius.all(
                                //               Radius.circular(8)),
                                //         ),
                                //         child: Column(
                                //           crossAxisAlignment:
                                //           CrossAxisAlignment.center,
                                //           children: [
                                //             SizedBox(
                                //               width: 25,
                                //               child: IconButton(
                                //                   tooltip:
                                //                   'Click to copy on the clipboard',
                                //                   onPressed: () async {
                                //                     Clipboard.setData(
                                //                         ClipboardData(
                                //                             text: widget
                                //                                 .pubKey
                                //                                 .toString()))
                                //                         .then((_) {
                                //                       ScaffoldMessenger.of(
                                //                           context)
                                //                           .showSnackBar(
                                //                           SnackBar(
                                //                             showCloseIcon: true,
                                //                             backgroundColor:
                                //                             Colors.green
                                //                                 .shade700,
                                //                             behavior:
                                //                             SnackBarBehavior
                                //                                 .floating,
                                //                             content: const Text(
                                //                               'Copied to your clipboard !',
                                //                               style: TextStyle(
                                //                                   fontFamily:
                                //                                   'Space'),
                                //                             ),
                                //                           ));
                                //                     });
                                //                     // copied successfully
                                //                   },
                                //                   padding:
                                //                   const EdgeInsets.all(0),
                                //                   icon: Icon(
                                //                     // FontAwesomeIcons.clipboard,
                                //                     Icons
                                //                         .content_copy_rounded,
                                //                     color: accentColor(),
                                //                     size: 18,
                                //                   )),
                                //             ),
                                //             Text('Public Address: ',
                                //                 style: TextStyle(
                                //                     fontFamily: 'Space',
                                //                     color: primaryColor(),
                                //                     fontSize: 14)),
                                //             Container(
                                //                 margin:
                                //                 const EdgeInsets.fromLTRB(
                                //                     0, 10, 0, 10),
                                //                 // width: 150,
                                //                 child: Text(
                                //                   widget.pubKey.toString(),
                                //                   textAlign: TextAlign.center,
                                //                   // maxLines: 1,
                                //                   // overflow: TextOverflow.ellipsis,
                                //                   style: TextStyle(
                                //                       fontFamily: 'Space',
                                //                       color: primaryColor(),
                                //                       fontSize: 14,
                                //                       fontWeight:
                                //                       FontWeight.w700),
                                //                 )),
                                //           ],
                                //         ),
                                //       ),
                                //     ),
                                //     const Text('Scan this QR code to pay me',
                                //         textAlign: TextAlign.justify,
                                //         style: TextStyle(
                                //             fontSize: 15,
                                //             fontFamily: 'Space',
                                //             color: Colors.red,
                                //             // color: Color(0xffc73333),
                                //             fontWeight: FontWeight.w600)),
                                //     Padding(
                                //       padding: const EdgeInsets.only(
                                //           top: 10, bottom: 10),
                                //       child: QrImage(
                                //         data: widget.pubKey.toString(),
                                //         version: QrVersions.auto,
                                //         size: 250,
                                //         // gapless: false,
                                //         embeddedImage: const AssetImage(
                                //             'assets/images/ethereum-logo.png'),
                                //         // embeddedImageStyle: QrEmbeddedImageStyle(
                                //         //   size: const Size(10, 10),
                                //         // ),
                                //       ),
                                //     ),
                                //     RichText(
                                //       text: TextSpan(
                                //           text: '',
                                //           style: const TextStyle(
                                //             fontSize: 30,
                                //             fontFamily: 'Alpha',
                                //           ),
                                //           children: [
                                //             TextSpan(
                                //                 text: 'CRYPTOX',
                                //                 style: TextStyle(
                                //                   color: accentColor(),
                                //                   fontWeight: FontWeight.w700,
                                //                 ))
                                //           ]),
                                //     ),
                                //   ],
                                // ),

                                SizedBox(
                              height: 670,
                              child: Column(
                                // mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 50,
                                        right: 50,
                                        top: 80,
                                        bottom: 20),
                                    child: Lottie.network(
                                      // 'https://assets1.lottiefiles.com/packages/lf20_ZzPRr9.json',
                                      'https://assets10.lottiefiles.com/packages/lf20_O1b0iWuPju.json',
                                      // 'https://assets10.lottiefiles.com/packages/lf20_NODCLWy3iX.json',
                                      // 'assets/anim/no-profile.json',
                                      // controller: _animController,
                                    ),
                                  ),
                                  Icon(
                                    FontAwesomeIcons.triangleExclamation,
                                    color: Colors.red.shade500,
                                    size: 35,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        30, 20, 30, 20),
                                    child: Text(
                                      'Wallet not found!',
                                      textAlign: TextAlign.justify,
                                      style: TextStyle(
                                          fontFamily: 'Space',
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                          color: complementColor()),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        30, 20, 30, 20),
                                    child: Text(
                                      'Create or Restore it first from the \'Wallet\' screen to show your wallet address, which will allow you to make transaction with others.',
                                      textAlign: TextAlign.justify,
                                      style: TextStyle(
                                          fontFamily: 'Space',
                                          fontSize: 12,
                                          color: complementColor()),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
