import 'package:cryptoX/creation_restoration_pages/cloud_export_import_private_key.dart';
import 'package:cryptoX/private/aes_encryption_decryption.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:cryptoX/app_utilities/theme.dart';

class GenerateQR extends StatefulWidget {
  String? seedWords, privateKey, page;

  GenerateQR(
      {String? words, required String Page, String? privKey, super.key}) {
    seedWords = words;
    page = Page;
    privateKey = privKey;
  }

  String doEncryption({String? key}) {
    UseAES aes = UseAES();
    final encryptedVal =
        aes.doEncryption(key: key, words: seedWords, privateKey: privateKey);
    return encryptedVal;
  }

  @override
  State<GenerateQR> createState() => _GenerateQRState();
}

class _GenerateQRState extends State<GenerateQR> {
  String? userCustomKey;
  String option = 'default';

  bool buttonPressed = false;

  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: lightGrey(),
        appBar: titledAppBar(
            context: context,
            title: (widget.page == 'words')
                ? 'Encrypting Words'
                : 'Encrypting Key',
            putLeading: true,
            leadingContent: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(
                  FontAwesomeIcons.xmark,
                ))),
        bottomNavigationBar: (buttonPressed == false)
            ? bottomBar(
                context: context,
                content: SizedBox(
                  height: 80,
                  child: Row(
                    mainAxisAlignment: (widget.page == 'privateKey')
                        ? MainAxisAlignment.spaceAround
                        : MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: (widget.page == 'words') ? 125 : 155,
                        height: 50,
                        child: button(
                          // color: primaryColor(),
                          content: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              text(
                                (widget.page == 'words')
                                    ? 'Generate'
                                    : 'Generate QR',
                                fontSize: 15,
                                // color: lightTheme(),
                                fontWeight: FontWeight.w600,
                              ),
                              const Icon(Icons.qr_code_2_rounded),
                            ],
                          ),
                          onPressed: () {
                            setState(() {
                              print(
                                  'CUSTOM KEY -------------------> ${userCustomKey}');
                              buttonPressed =
                                  true; // if pressed, button pressed = true, Means we fetched the value from generated QR
                            });
                          },
                        ),
                      ),
                      (widget.page == 'privateKey')
                          ? SizedBox(
                              width: 155,
                              height: 50,
                              child: button(
                                color:
                                    (MediaQuery.platformBrightnessOf(context) ==
                                            Brightness.light)
                                        ? primaryColor()
                                        : const Color(0xff484848),
                                content: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    text('Cloud Store',
                                        fontSize: 15,
                                        color: lightTheme(),
                                        fontWeight: FontWeight.w600),
                                    const Icon(
                                      FontAwesomeIcons.cloudArrowUp,
                                      color: Colors.blueAccent,
                                    ),
                                  ],
                                ),
                                onPressed: () {
                                  String? privateKey;
                                  if (option == 'default') {
                                    privateKey = widget.doEncryption();
                                  } else {
                                    privateKey =
                                        widget.doEncryption(key: userCustomKey);
                                  }
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => CloudUpload(
                                                privKey: privateKey,
                                                page: 'export_to_cloud',
                                              )));
                                },
                              ),
                            )
                          : const SizedBox(),
                    ],
                  ),
                ),
              )
            : null,
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: (buttonPressed == false)
                ?
                // 'CHOOSE AN ENCRYPTION SCREEN'
                SizedBox(
                    child: Center(
                      child: Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 10, bottom: 10),
                            height: 200,
                            child: Lottie.asset(
                              'assets/anim/encryption.json',
                              frameRate: FrameRate.max,
                            ),
                          ),
                          text('Choose an Encryption method: ',
                              fontSize: 20, fontWeight: FontWeight.w600),
                          Container(
                            margin: const EdgeInsets.only(top: 10),
                            width: 350,
                            child: RadioListTile(
                                title: text(
                                  'Encrypt using a default password',
                                  fontSize: 15,
                                  color: (option == 'default')
                                      ? accentColor()
                                      : Theme.of(context)
                                          .colorScheme
                                          .inverseSurface,
                                ),
                                value: 'default',
                                groupValue: option,
                                onChanged: (value) {
                                  setState(() {
                                    option = value.toString();
                                  });
                                }),
                          ),
                          SizedBox(
                            width: 350,
                            child: RadioListTile(
                                title: text(
                                  'Encrypt using a custom password',
                                  fontSize: 15,
                                  color: (option == 'custom')
                                      ? accentColor()
                                      : Theme.of(context)
                                          .colorScheme
                                          .inverseSurface,
                                ),
                                value: 'custom',
                                groupValue: option,
                                onChanged: (value) {
                                  setState(() {
                                    option = value.toString();
                                  });
                                }),
                          ),
                          (option == 'custom')
                              ? Container(
                                  width: 320,
                                  margin: const EdgeInsets.all(10),
                                  child: inputField(
                                    context: context,
                                    controller: password,
                                    hintText: 'Enter Password',
                                    maxLength: 32,
                                    onChanged: (message) {
                                      setState(() {
                                        userCustomKey = message;
                                      });
                                    },
                                    onSubmitted: (message) {
                                      setState(() {
                                        userCustomKey = message;
                                      });
                                    },
                                    helperText:
                                        'Password can be any message, it will be used for encrypting the QR.',
                                  ),
                                )
                              : const SizedBox(),
                          const Divider(),
                          Container(
                            margin: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                            child: text(
                                'NOTE: \n\n👉 Using a default password option, you wouldn\'t be required any password when importing it back (while restoring your wallet). Since encryption is done using a password. \n\n👉 Using a custom password, you will be required to remember it, since it will be used again to decrypt the QR ( a more secure option even if the QR get\'s in the wrong hand they won\'t be able to decrypt it without the password) but if you forgot the password you won\'t be able to decrypt the QR again even we won\'t able to help you. So choose accordingly.',
                                textAlign: TextAlign.justify,
                                fontSize: 10,
                                color: red(),
                                fontWeight: FontWeight.w600),
                          ),
                          const Divider(),
                        ],
                      ),
                    ),
                  )
                :
                // ' GENERATED QR SCREEN'
                SizedBox(
                    height: 748,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 35.0, right: 35.0, bottom: 10),
                            child: text(
                                'Take a screenshot of this QR, print it and put it in a safe deposit box, and please don\'t forget to delete all the digital copies of the QR (or the private key etc.) from your phone!',
                                textAlign: TextAlign.justify,
                                fontSize: 15,
                                color: red(),
                                fontWeight: FontWeight.w500),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                              border: Border.all(
                                width: .5,
                                color: Colors.grey.shade300,
                              ),
                            ),
                            margin: const EdgeInsets.only(top: 50),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // GENERATED QR
                                  QrImage(
                                    data: (option == 'default')
                                        ? widget.doEncryption()
                                        : widget.doEncryption(
                                            key: userCustomKey),
                                    version: QrVersions.auto,
                                    size: 300,
                                    gapless: false,
                                    // CENTERED LOGO IN QR
                                    embeddedImage: const AssetImage(
                                        'assets/images/ethereum-logo.png'),
                                    embeddedImageStyle: QrEmbeddedImageStyle(
                                      size: const Size(80, 80),
                                    ),
                                  ),
                                  RichText(
                                    text: TextSpan(
                                        text: '',
                                        style: const TextStyle(
                                          color: Color(0xff1f1f1f),
                                          fontSize: 30,
                                          fontFamily: 'Alpha',
                                          fontWeight: FontWeight.w700,
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
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
          ),
        ));
  }
}
