import 'package:cryptoX/my_dashboard_page.dart';
import 'package:cryptoX/private/secret_keys.dart';
import 'package:cryptoX/creation_restoration_pages/generate_qr.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:just_audio/just_audio.dart';
import 'package:vibration/vibration.dart';
import 'package:web3dart/credentials.dart';

import '../app_theme/theme.dart';

class KeyGen extends StatefulWidget {
  String? seedPhrase, pubAddress, privAddress, page;
  // two values =>    page = 'create'  | 'restore'

  KeyGen(
      {String? seedWords,
      String? privateKey,
      required String Page,
      super.key}) {
    seedPhrase = seedWords;
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
    // creating object of wallet service [ present in secret_keys.dart] // for creation of private / public keys
    WalletAddress service = WalletAddress();

    String? privateKey;
    EthereumAddress? publicKey;
    if (widget.seedPhrase != null) {
      // CREATING PRIVATE | PUBLIC KEYS FROM SEED PHRASES [ if it is not null ]
      privateKey = await service.getPrivateKey(widget.seedPhrase!);
      publicKey = await service.getPublicKey(privateKey);
    } else if (widget.privAddress != null) {
      // if we already fetched private key from restore page
      publicKey = await service.getPublicKey(widget.privAddress!);
    }

    setState(() {
      if (widget.privAddress == null) {
        print('VALUE OF PRIVATE ADDRESS =======-> $privateKey');
        widget.privAddress = privateKey;
      }
      widget.pubAddress = publicKey.toString();
      walletCreated();
    });
  }

  // FOR ANIMATION TO TAKE 1.7 sec to complete for ' SUCCESSFUL TICK ANIMATION '
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

  // WAS TRYING TO VIBRATE THE PHONE WHEN WALLET GENERATED! -- YOU CAN TRY TO FIX IT 😊
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

    // DELAYING ANIMATION
    Future.delayed(const Duration(milliseconds: 300), () {
      _controller.forward();
    });
    print('WORDS FROM WALLET CREATION PAGE --------->${widget.seedPhrase}');
    generate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightGrey(),
      appBar: titledAppBar(
          title:
              (widget.page == 'create') ? 'Wallet Created' : 'Wallet Restored'),

      //

      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 30),
                width: 85,
                child: Lottie.asset('assets/anim/success.json',
                    controller: _controller),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20, bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        width: 270,
                        margin: const EdgeInsets.only(left: 15),
                        child: text(
                            (widget.page == 'create')
                                ? 'WALLET INITIATED SUCCESSFULLY !'
                                : 'WALLET RESTORED SUCCESSFULLY !',
                            textAlign: TextAlign.center,
                            fontSize: 20,
                            color: green(),
                            fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
              shadowBox(
                margin: const EdgeInsets.only(
                    top: 10, left: 25, right: 25, bottom: 10),
                padding: const EdgeInsets.all(20),
                content: SizedBox(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: text(
                          "Wallet Private Address :",
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: text("${widget.privAddress}",
                              textAlign: TextAlign.center,
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: complementColor()),
                        ),
                      ),
                      Center(
                        child: text(
                          "Do not reveal this private address to anyone!",
                          textAlign: TextAlign.center,
                          fontSize: 15,
                          color: Colors.red,
                        ),
                      ),
                      const Divider(),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: text(
                            "Wallet Public Address : ",
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Center(
                        child: text(
                          "${widget.pubAddress}",
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: complementColor(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(20),
                width: 200,
                child: (widget.page != 'restore')
                    ? button(
                        color: red(),
                        content: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Icon(Icons.enhanced_encryption_rounded),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: text('Encrypt | Export\nPrivate Key',
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: lightTheme()),
                            ),
                          ],
                        ),
                        onPressed: () async {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => GenerateQR(
                                        privKey: widget.privAddress,
                                        Page: 'privateKey',
                                      )));
                        },
                      )
                    : const SizedBox(),
              ),
              Container(
                margin: const EdgeInsets.all(20),
                width: 200,
                height: 50,
                child: button(
                  color: primaryColor(),
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Icon(FontAwesomeIcons.house),
                      text(
                        'Home Page',
                        color: lightTheme(),
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ],
                  ),
                  onPressed: () async {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => MyHomePage()));
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  // USING SHARED PREFERENCE TO STORE THE PUBLIC KEY
  void walletCreated() async {
    // Shared Preference Object
    SharedPreferences sp = await SharedPreferences.getInstance();
    bool isC = await sp.setBool(MyHomePageState.isCreated, true);
    if (isC) {
      print('--------->_WALLET CREATED SUCCESSFULLY!');
    } else {
      print('--------->_WALLET CREATION FAILED!');
    }
    bool isP =
        await sp.setString(MyHomePageState.publicAddress, widget.pubAddress!);
    if (isP) {
      print('-------------> PUBLIC ADDRESS STORED SUCCESSFULLY!');
    } else {
      print('---------> STORING PUBLIC KEY : FAILED!');
    }

    // TASK: STORE AN ENCRYPTED PRIVATE KEY IN THE PHONE [ since private key will be required when signing transaction]
    // USING ANY LOCAL STORAGE OPTION LIKE [ Shared preference, Hive, GetX etc. ]
  }
}
