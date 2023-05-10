import 'package:cryptoX/my_dashboard_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../app_utilities/theme.dart';

class BackupPage extends StatelessWidget {
  const BackupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //

      appBar: titledAppBar(
          context: context,
          title: 'Backup | Security',
          putLeading: true,
          leadingContent: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(
                FontAwesomeIcons.angleLeft,
              ))),

      //

      body: SafeArea(
        child: (myAddress != null)
            ? SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: listTile(
                          icon: FontAwesomeIcons.fileWord,
                          title: 'Seed Phrase Backup',
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ShowQR(
                                          Page: 'words',
                                        )));
                          }),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      child: Divider(),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: listTile(
                          icon: FontAwesomeIcons.key,
                          title: 'Private Key Backup',
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ShowQR(
                                          Page: 'PrivateKey',
                                        )));
                          }),
                    ),
                  ],
                ),
              )
            : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Icon(
                        FontAwesomeIcons.triangleExclamation,
                        color: red(),
                        size: 35,
                      ),
                    ),
                    text('Create a wallet first in order to use backup.',
                        textAlign: TextAlign.center, color: complementColor())
                  ],
                ),
              ),
      ),
    );
  }
}

//

class ShowQR extends StatefulWidget {
  String? page;
  String? encryptedQRData;
  String? password;
  ShowQR({super.key, required String Page}) {
    page = Page;
  }

  @override
  State<ShowQR> createState() => _ShowQRState();
}

class _ShowQRState extends State<ShowQR> {
  fetchBackup() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    setState(() {
      if (widget.page == 'words') {
        widget.encryptedQRData = sp.getString('encryptedWords');
        print('ENCRYPTED DATA: ${widget.encryptedQRData}');
        widget.password = sp.getString('QRWordsPassword');
        print('PASSWORD: ${widget.password}');
      } else {
        widget.encryptedQRData = sp.getString('encryptedPrivateKey');
        print('ENCRYPTED DATA: ${widget.encryptedQRData}');
        widget.password = sp.getString('QRPrivatePassword');
        print('PASSWORD: ${widget.password}');
      }
    });
  }

  @override
  void initState() {
    fetchBackup();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //

      appBar: titledAppBar(
          context: context,
          title: 'Backup QR',
          putLeading: true,
          leadingContent: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(
                FontAwesomeIcons.angleLeft,
              ))),

      //

      body: SafeArea(
          child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: SizedBox(
          height: 748,
          child: Center(
            child: (widget.encryptedQRData != null)
                ? Column(
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
                                data: widget.encryptedQRData!,
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
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 35.0, right: 35.0, top: 10),
                        child: (widget.password != null)
                            ? text('Password: ${widget.password}',
                                textAlign: TextAlign.justify,
                                fontSize: 15,
                                color: red(),
                                fontWeight: FontWeight.w700)
                            : const SizedBox(),
                      ),
                    ],
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Icon(
                          FontAwesomeIcons.triangleExclamation,
                          color: red(),
                          size: 35,
                        ),
                      ),
                      text('No backup found!',
                          textAlign: TextAlign.center, color: complementColor())
                    ],
                  ),
          ),
        ),
      )),
    );
  }
}
