import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:qr_flutter/qr_flutter.dart';

class SeedonQR extends StatelessWidget {
  String? seedPhrase;

  SeedonQR(String seed, {super.key}) {
    seedPhrase = seed;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(FontAwesomeIcons.close)),
        title: const Text('Seed to QR',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 30,
                fontFamily: 'Poppins',
                // color: Color.fromARGB(255, 71, 217, 204),
                fontWeight: FontWeight.w700)),
        centerTitle: true,
        toolbarHeight: 80,
        shadowColor: const Color(0x10000000),
        backgroundColor: Colors.white,
      ),
      body: Container(
        color: Colors.grey.shade50,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: SizedBox(
            height: 748,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Padding(
                    padding:
                        EdgeInsets.only(left: 35.0, right: 35.0, bottom: 30),
                    child: Text(
                        'Take a screenshot of this QR, print it and put it on a safe deposit box, and please don\'t forget to delete all the digital copies of the QR (or the private key etc.) from your phone!',
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                            fontSize: 15,
                            fontFamily: 'Poppins',
                            color: Color(0xffc73333),
                            fontWeight: FontWeight.w500)),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      border: Border.all(
                        width: .5,
                        color: Colors.grey.shade300,
                      ),
                    ),
                    margin: const EdgeInsets.only(top: 50),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: QrImage(
                        data: seedPhrase!,
                        version: QrVersions.auto,
                        size: 320,
                        gapless: false,
                        embeddedImage:
                            const AssetImage('assets/images/ethereum-logo.png'),
                        embeddedImageStyle: QrEmbeddedImageStyle(
                          size: const Size(80, 80),
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
