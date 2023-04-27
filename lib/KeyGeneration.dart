import 'package:cryptoX/my_dashboard_page.dart';
import 'package:cryptoX/secret_keys.dart';
import 'package:cryptoX/seedonQR.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:just_audio/just_audio.dart';
import 'package:vibration/vibration.dart';
import 'package:web3dart/credentials.dart';

import 'apptheme/theme.dart';

class KeyGen extends StatefulWidget {
  String seedPhrase = '';
  String? pubAddress;
  String? privAddress;
  String page = 'create';
  KeyGen(
      {String seed = '', String privateKey = '', String Page = '', super.key}) {
    seedPhrase = seed;
    privAddress = privateKey;
    page = Page;
  }

  @override
  State<KeyGen> createState() => _KeyGenState();
}

class _KeyGenState extends State<KeyGen> with SingleTickerProviderStateMixin {
  WalletAddress service = WalletAddress();

  static AudioPlayer player = AudioPlayer();

  generate() async {
    WalletAddress service = WalletAddress();

    String privateKey = '';
    EthereumAddress? publicKey;
    if (widget.seedPhrase.isNotEmpty) {
      privateKey = await service.getPrivateKey(widget.seedPhrase);
      publicKey = await service.getPublicKey(privateKey);
    } else if (widget.privAddress!.isNotEmpty) {
      publicKey = await service.getPublicKey(widget.privAddress!);
    }
    //Using Not symbol [ ! ] after variable means it will not be null.

    setState(() {
      if (widget.privAddress!.isEmpty) {
        widget.privAddress = privateKey;
      }
      widget.pubAddress = publicKey.toString();
      walletCreated();
    });
  }

  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(
      milliseconds: 1700,
    ),
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  playTune() async {
    await player.setAsset(
        'assets/tunes/success.mp3'); // Load a URL  // Schemes: (https: | file: | asset: )
    player.play();
  }

  // vibrate() async {
  //   if (await Vibration.hasVibrator() == true) {
  //     print('VIBRATION STARTED-----------------------------.');
  //     if (await Vibration.hasAmplitudeControl() == true) {
  //       if (await Vibration.hasCustomVibrationsSupport() == true) {
  //         Vibration.vibrate(amplitude: 500, duration: 1000);
  //       }
  //     } else {
  //       Vibration.vibrate();
  //     }
  //   }
  // }

  @override
  void initState() {
    print('PRIVATE KEY FROM RESTORE PAGE --------->${widget.privAddress}');
    // vibrate();
    playTune();
    Future.delayed(const Duration(milliseconds: 500), () {
      _controller.forward();
    });
    print('WORDS FROM WALLET CREATION PAGE --------->${widget.seedPhrase}');
    generate();
    super.initState();
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
        title: Text(
            (widget.page == 'create') ? 'WALLET CREATED' : 'WALLET RESTORED',
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontSize: 30,
                fontFamily: 'Space',
                // color: Color.fromARGB(255, 71, 217, 204),
                fontWeight: FontWeight.w700)),
        centerTitle: true,
        toolbarHeight: 80,
        shadowColor: const Color(0x10000000),
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: SizedBox(
            height: 748,
            child: Center(
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 30),
                    width: 85,
                    // height: 150,
                    child: Lottie.asset('assets/anim/success.json',
                        controller: _controller),
                  ),
                  Center(
                      child: Container(
                    margin: const EdgeInsets.only(left: 30, right: 30),
                    alignment: Alignment.center,
                    // height: 80,
                    width: MediaQuery.of(context).size.width,
                    // color: const Color(0xff7cb76f),
                    // color: const Color(0xff2CDA94),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // const Icon(
                          //   FontAwesomeIcons.check,
                          //   color: Color(0xff007525),
                          // ),
                          Container(
                            width: 270,
                            margin: const EdgeInsets.only(left: 15),
                            child: Text(
                                (widget.page == 'create')
                                    ? 'WALLET INITIATED SUCCESSFULLY !'
                                    : 'WALLET RESTORED SUCCESSFULLY !',
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontSize: 20,
                                    fontFamily: 'Space',
                                    color: Color(0xff2CDA94),
                                    // color: Color(0xff007525),
                                    fontWeight: FontWeight.w600)),
                          ),
                        ],
                      ),
                    ),
                  )),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0xffe8e8e8),
                          blurRadius: 40,
                          // spreadRadius: 5
                        )
                      ],
                    ),
                    margin: const EdgeInsets.only(
                        top: 10, left: 20, right: 20, bottom: 10),
                    padding: const EdgeInsets.all(20),
                    child: SizedBox(
                      // height: MediaQuery.of(context).size.height - 110,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Center(
                            child: Text(
                              "Wallet Private Address :",
                              style: TextStyle(
                                  fontSize: 17,
                                  fontFamily: 'Space',
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "${widget.privAddress}",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 10,
                                    fontFamily: 'Space',
                                    fontWeight: FontWeight.w600,
                                    color: complementColor()),
                              ),
                            ),
                          ),
                          const Center(
                            child: Text(
                              "Do not reveal this private address to anyone!",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 15,
                                  fontFamily: 'Space',
                                  color: Colors.red),
                            ),
                          ),
                          const Divider(),
                          const Center(
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                "Wallet Public Address : ",
                                style: TextStyle(
                                    fontSize: 17,
                                    fontFamily: 'Space',
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                          Center(
                            child: Text("${widget.pubAddress}",
                                style: TextStyle(
                                    fontSize: 10,
                                    fontFamily: 'Space',
                                    fontWeight: FontWeight.w600,
                                    color: complementColor())),
                          ),
                          // const Divider(),
                          // const Center(
                          //   child: Text(
                          //     "Go back to home page!",
                          //     style: TextStyle(
                          //       color: Colors.grey,
                          //       fontSize: 18,
                          //     ),
                          //   ),
                          // )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(20),
                    width: 200,
                    // height: 60,
                    child: (widget.page != 'restore')
                        ? ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              // backgroundColor: const Color(0xff1e1e1e),
                              backgroundColor: Colors.red,
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8))),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: const [
                                Icon(Icons.enhanced_encryption_rounded),
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    'Encrypt | Export\nPrivate Key',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontFamily: 'Space',
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ],
                            ),
                            onPressed: () async {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SeedonQR(
                                            privKey:
                                                widget.privAddress.toString(),
                                            page: 2,
                                          )));
                            },
                          )
                        : const SizedBox(),
                  ),
                  Container(
                    margin: const EdgeInsets.all(20),
                    width: 200,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: const Color(0xff1e1e1e),
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: const [
                          Icon(FontAwesomeIcons.house),
                          Text(
                            'Home Page',
                            style: TextStyle(
                                fontSize: 15,
                                fontFamily: 'Space',
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      onPressed: () async {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MyHomePage()));
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void walletCreated() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    bool isC = await sp.setBool(MyHomePageState.IS_CREATED, true);
    if (isC) {
      print('--------->_WALLET CREATED SUCCESSFULLY!');
    }
    bool isP =
        await sp.setString(MyHomePageState.PUBLICADDRESS, widget.pubAddress!);
    if (isP) {
      print('------------->pubAddress CREATED SUCCESSFULLY!');
    }

    //Using Not symbol [ ! ] after variable means it will not be null.
  }

// wallet_created() async {
//   SharedPreferences sp = await SharedPreferences.getInstance();
//   await sp.setBool(MyHomePageState.IS_CREATED, true);
//   await sp.setString(
//       MyHomePageState.PUBLICADDRESS,
//       pubAddress
//           .toString()); //Using Not symbol [ ! ] after variable means it will not be null.
// }
}
