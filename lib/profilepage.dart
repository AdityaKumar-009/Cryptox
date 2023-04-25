import 'package:cryptoX/MyDashBoardPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Scan2Pay.dart';

class ProfilePage extends StatefulWidget {
  String? pubKey;

  ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  fetch() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    setState(() {
      widget.pubKey = sp.getString(MyHomePageState.PUBLICADDRESS);
    });
  }

  @override
  void initState() {
    fetch();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        automaticallyImplyLeading: false,
        // foregroundColor: Colors.black,
        // foregroundColor: Colors.white,
        // backgroundColor: Colors.white,
        // backgroundColor: Color(0xff1f1f1f),
        elevation: 0,
        shadowColor: const Color(0x4dffffff),
        title: SizedBox(
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 55, bottom: 35, left: 8),
                child: Text('Hi, $userName',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 30,
                        fontFamily: 'Space',
                        // color: Color.fromARGB(255, 71, 217, 204),
                        // color: Colors.black,
                        fontWeight: FontWeight.w700)),
              ),
              Container(
                // width: 100,
                margin: const EdgeInsets.only(top: 30, bottom: 15, right: 5),
                child: const Card(
                  shape: CircleBorder(),
                  elevation: 3,
                  // shadowColor: Colors,
                  child: CircleAvatar(
                    backgroundColor: Color.fromARGB(100, 0, 90, 100),
                    // backgroundColor: Colors.transparent,
                    backgroundImage: AssetImage('assets/images/Adit.jpg'),
                    maxRadius: 25,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      //-------------------- FLOATING ACTION BUTTON --------------------------------------
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: SizedBox(
        height: 85,
        width: 85,
        child: FloatingActionButton(
          tooltip: 'Scan to Pay',
          // splashColor: Colors.blue,
          onPressed: () {
            int page = 1;
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => Scan2Pay(page),
            ));
          },
          backgroundColor: Colors.white,
          child: Container(
            margin: const EdgeInsets.only(top: 15, bottom: 15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              image: const DecorationImage(
                  image: AssetImage('assets/images/QR_scan.png')),
              // boxShadow: const [
              //   BoxShadow(
              //     blurRadius: 30,
              //     spreadRadius: 0,
              //     color: Colors.blueAccent,
              //   )
              // ],
            ),
          ),
        ),
      ),
      //----------------------------- BOTTOM NAVIGATION BAR ------------------------------
      bottomNavigationBar: Container(
        // color: const Color(0xfff9f9f9),
        // color: const Color(0xff131313),
        // color: const Color(0xfff3f3f3),
        color: Colors.blue,
        child: BottomAppBar(
          height: 80,
          //bottom navigation bar on scaffold
          // color: Colors.white,
          // color: Colors.black,
          // color: const Color(0xff1f1f1f),
          shape: const CircularNotchedRectangle(),
          //shape of notch
          notchMargin: 10,
          //notch margin between floating button and bottom appbar
          child: Row(
            //children inside bottom appbar
            // mainAxisSize: MainAxisSize.min,
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    IconButton(
                      tooltip: 'My Wallet',
                      icon: const Icon(
                        // FontAwesomeIcons.wallet,
                        Icons.account_balance_wallet_outlined,
                        color: Colors.black,
                        size: 27,
                      ),
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MyHomePage()));
                      },
                    ),
                    const Text(
                      'My Wallet',
                      style: TextStyle(fontFamily: 'Space', fontSize: 12),
                    ),
                  ],
                ),
              ),
              const Expanded(
                  flex: 1,
                  child: SizedBox(
                    width: 10,
                  )),
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    IconButton(
                      tooltip: 'Profile',
                      icon: const Icon(
                        Icons.account_circle_rounded,
                        // FontAwesomeIcons.addressCard,
                        // color: Colors.black,
                        // color: Colors.white,
                        size: 30,
                        color: Colors.blueAccent,
                      ),
                      onPressed: () {},
                    ),
                    const Text(
                      'My Profile',
                      style: TextStyle(
                          fontFamily: 'Space',
                          fontWeight: FontWeight.w600,
                          fontSize: 12),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: Container(
        // color: Colors.grey.shade50,
        color: Colors.blue,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          child: Container(
            color: Colors.blue,
            height: 700,
            child: Center(
              child: Column(
                children: [
                  // const Padding(
                  //   padding:
                  //       EdgeInsets.only(left: 35.0, right: 35.0, bottom: 30),
                  //   child: Text(
                  //       'Take a screenshot of this QR, print it and put it on a safe deposit box, and please don\'t forget to delete all the digital copies of the QR (or the private key etc.) from your phone!',
                  //       textAlign: TextAlign.justify,
                  //       style: TextStyle(
                  //           fontSize: 15,
                  //           fontFamily: 'Space',
                  //           color: Color(0xffc73333),
                  //           fontWeight: FontWeight.w500)),
                  // ),
                  (widget.pubKey.toString() != 'null')
                      ? Container(
                          width: 350,
                          height: 620,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                            border: Border.all(
                              width: .5,
                              color: Colors.grey.shade300,
                            ),
                          ),
                          margin: const EdgeInsets.only(top: 20),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                const Text('Scan this QR code to pay me',
                                    textAlign: TextAlign.justify,
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontFamily: 'Space',
                                        color: Color(0xffc73333),
                                        fontWeight: FontWeight.w600)),
                                InkWell(
                                  onTap: () async {
                                    Clipboard.setData(
                                            ClipboardData(text: widget.pubKey!))
                                        .then((_) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                        showCloseIcon: true,
                                        backgroundColor: Colors.green.shade700,
                                        behavior: SnackBarBehavior.floating,
                                        content: const Text(
                                          'Copied to your clipboard !',
                                          style: TextStyle(fontFamily: 'Space'),
                                        ),
                                      ));
                                    });
                                    // copied successfully
                                  },
                                  child: Container(
                                    // height: 40,
                                    width: 300,
                                    decoration: const BoxDecoration(
                                      color: Color(0xffd8edf5),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8)),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          15, 10, 10, 10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            width: 25,
                                            child: IconButton(
                                                tooltip:
                                                    'Click to copy on the clipboard',
                                                onPressed: () async {
                                                  Clipboard.setData(
                                                          ClipboardData(
                                                              text: widget
                                                                  .pubKey!))
                                                      .then((_) {
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(SnackBar(
                                                      showCloseIcon: true,
                                                      backgroundColor:
                                                          Colors.green.shade700,
                                                      behavior: SnackBarBehavior
                                                          .floating,
                                                      content: const Text(
                                                        'Copied to your clipboard !',
                                                        style: TextStyle(
                                                            fontFamily:
                                                                'Space'),
                                                      ),
                                                    ));
                                                  });
                                                  // copied successfully
                                                },
                                                padding:
                                                    const EdgeInsets.all(0),
                                                icon: const Icon(
                                                  // FontAwesomeIcons.clipboard,
                                                  Icons.content_copy_rounded,
                                                  color: Colors.blue,
                                                  size: 18,
                                                )),
                                          ),
                                          const Text('Your Public Address: ',
                                              style: TextStyle(
                                                  fontFamily: 'Space',
                                                  color: Colors.black54,
                                                  fontSize: 14)),
                                          Container(
                                              margin: const EdgeInsets.fromLTRB(
                                                  0, 10, 0, 10),
                                              // width: 150,
                                              child: Text(
                                                widget.pubKey!,
                                                // maxLines: 1,
                                                // overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                    fontFamily: 'Space',
                                                    color: Colors.black54,
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              )),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                QrImage(
                                  data: widget.pubKey!,
                                  //Using Not symbol [ ! ] after variable means it will not be null.
                                  version: QrVersions.auto,
                                  size: 250,
                                  // gapless: false,
                                  embeddedImage: const AssetImage(
                                      'assets/images/ethereum-logo.png'),
                                  // embeddedImageStyle: QrEmbeddedImageStyle(
                                  //   size: const Size(10, 10),
                                  // ),
                                ),
                                RichText(
                                  text: const TextSpan(
                                      text: '',
                                      style: TextStyle(
                                        color: Color(0xff1f1f1f),
                                        fontSize: 30,
                                        fontFamily: 'Alpha',
                                        fontWeight: FontWeight.w700,
                                      ),
                                      children: [
                                        TextSpan(
                                            text: 'CRYPTOX',
                                            style: TextStyle(
                                              color: Colors.blue,
                                              fontWeight: FontWeight.w700,
                                            ))
                                      ]),
                                ),
                              ],
                            ),
                          ),
                        )
                      : SizedBox(
                          height: 670,
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Container(
                                height: 220,
                                // color: const Color(0xfff1b4b4),
                                color: const Color(0xff2c2c2c),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(30, 20, 30, 20),
                                  child: Column(
                                    children: [
                                      Icon(
                                        FontAwesomeIcons.close,
                                        color: Colors.red.shade500,
                                        size: 35,
                                      ),
                                      Text(
                                        'Wallet is not created! Create it first from the \'My Wallet\' screen To show your Wallet Address which will allow you to do the transaction with others.',
                                        textAlign: TextAlign.justify,
                                        style: TextStyle(
                                            fontFamily: 'Space',
                                            fontWeight: FontWeight.w600,
                                            fontSize: 18,
                                            color: Colors.red.shade400),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
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
