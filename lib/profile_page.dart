import 'package:cryptoX/my_dashboard_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app_theme/theme.dart';

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
      widget.pubKey = sp.getString(MyHomePageState.publicAddress);
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
      backgroundColor: lightTheme(),
      // TITLED APP BAR CREATED IN THEME.DART
      appBar: titledAppBar(title: 'MY PROFILE'),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        child: Padding(
          padding: const EdgeInsets.only(top: 90, bottom: 40),
          child: SizedBox(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  shadowBox(
                    margin: const EdgeInsets.only(left: 25, right: 25),
                    content: Container(
                      color: lightTheme(),
                      width: 350,
                      height: 620,
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Positioned(
                            right: 112,
                            top: -75,
                            child: Hero(
                              tag: 'profile',
                              child: Container(
                                margin:
                                    const EdgeInsets.only(top: 10, bottom: 10),
                                child: const Card(
                                  shape: CircleBorder(),
                                  elevation: 20,
                                  child: CircleAvatar(
                                    backgroundColor:
                                        Color.fromARGB(100, 0, 90, 100),
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
                            child: text(
                              userName,
                              textAlign: TextAlign.center,
                              fontSize: 30,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Positioned(
                            left: 0,
                            right: 0,
                            top: 94,
                            child: (widget.pubKey != null)
                                ? Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      InkWell(
                                        onTap: () async {
                                          Clipboard.setData(ClipboardData(
                                                  text:
                                                      widget.pubKey.toString()))
                                              .then((_) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                              showCloseIcon: true,
                                              backgroundColor:
                                                  Colors.green.shade700,
                                              behavior:
                                                  SnackBarBehavior.floating,
                                              content: const Text(
                                                'Copied to your clipboard !',
                                                style: TextStyle(
                                                    fontFamily: 'Space'),
                                              ),
                                            ));
                                          });
                                          // copied successfully
                                        },
                                        child: Container(
                                          margin: const EdgeInsets.fromLTRB(
                                              0, 10, 0, 30),
                                          padding: const EdgeInsets.fromLTRB(
                                              15, 10, 10, 10),
                                          width: 300,
                                          decoration: const BoxDecoration(
                                            color: Color(0xffffe093),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(8)),
                                          ),
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
                                                                      .pubKey
                                                                      .toString()))
                                                          .then((_) {
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                                SnackBar(
                                                          showCloseIcon: true,
                                                          backgroundColor:
                                                              Colors.green
                                                                  .shade700,
                                                          behavior:
                                                              SnackBarBehavior
                                                                  .floating,
                                                          content: const Text(
                                                            'Copied to your clipboard !',
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    'Space'),
                                                          ),
                                                        ));
                                                      });
                                                    },
                                                    padding:
                                                        const EdgeInsets.all(0),
                                                    icon: Icon(
                                                      // FontAwesomeIcons.clipboard,
                                                      Icons
                                                          .content_copy_rounded,
                                                      color: accentColor(),
                                                      size: 18,
                                                    )),
                                              ),
                                              text(
                                                'Public Address: ',
                                                fontSize: 14,
                                              ),
                                              Container(
                                                  margin:
                                                      const EdgeInsets.fromLTRB(
                                                          0, 10, 0, 10),
                                                  child: text(
                                                    widget.pubKey.toString(),
                                                    textAlign: TextAlign.center,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w700,
                                                  )),
                                            ],
                                          ),
                                        ),
                                      ),
                                      text(
                                        'Scan this QR code to pay me',
                                        textAlign: TextAlign.justify,
                                        fontSize: 15,
                                        color: red(),
                                        fontWeight: FontWeight.w600,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 10, bottom: 10),
                                        child: QrImage(
                                          data: widget.pubKey.toString(),
                                          version: QrVersions.auto,
                                          size: 250,
                                          embeddedImage: const AssetImage(
                                              'assets/images/ethereum-logo.png'),
                                        ),
                                      ),
                                      RichText(
                                        text: TextSpan(
                                            text: '',
                                            style: const TextStyle(
                                              fontSize: 30,
                                              fontFamily: 'Alpha',
                                            ),
                                            children: [
                                              TextSpan(
                                                  text: 'CRYPTOX',
                                                  style: TextStyle(
                                                    color: accentColor(),
                                                    fontWeight: FontWeight.w700,
                                                  ))
                                            ]),
                                      ),
                                    ],
                                  )
                                : SizedBox(
                                    height: 670,
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 50,
                                              right: 50,
                                              top: 15,
                                              bottom: 32),
                                          child: Lottie.asset(
                                              'assets/anim/Wallet.json',
                                              frameRate: FrameRate.max,
                                              width: 350),
                                        ),
                                        Icon(
                                          FontAwesomeIcons.triangleExclamation,
                                          color: Colors.red.shade500,
                                          size: 35,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              30, 20, 30, 20),
                                          child: text(
                                            'Wallet not found!',
                                            textAlign: TextAlign.justify,
                                            fontWeight: FontWeight.w600,
                                            color: red(),
                                            fontSize: 16,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              30, 20, 30, 20),
                                          child: text(
                                            'Create or Restore it first from the \'Wallet\' screen to show your wallet address, which will allow you to make transaction with others.',
                                            textAlign: TextAlign.justify,
                                            fontSize: 12,
                                            color: complementColor(),
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
