import 'package:cryptoX/cloudkeyupload.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:encrypt/encrypt.dart' as enc;

import 'apptheme/theme.dart';

class SeedonQR extends StatefulWidget {
  String? seedPhrase;

  String? encryptedVal;

  String? decryptedVal;

  String? privateKey;

  int pageid = 1;

  SeedonQR({String seed = '', int page = 1, String privKey = '', super.key}) {
    seedPhrase = seed;
    pageid = page;
    privateKey = privKey;
  }

  String doEncryption({String key = ''}) {
    String dfault = 'It is my Secret Key No One Knows';
    enc.Key myfinalkey;
    if (key.isEmpty) {
      myfinalkey = enc.Key.fromUtf8(dfault);
    } //It should of 16,32 character size to work, since key is of 128/256 bits but 1UTF8 character size is 4bits, means 32[char needed]*4 = 128bits
    else {
      print(
          'KEY IS -------------------> ${key} \t\t [LENGTH]----->${key.length}');
      String key32len = key;
      print(
          'MY 32 LENGTH KEY [BEFORE LOOP]-------------------> ${key32len} [LENGTH]----->${key32len.length}');
      for (int i = key.length; i < 32; i++) {
        key32len += '*';
      }
      print(
          'MY 32 LENGTH KEY [AFTER LOOP]-------------------> $key32len  [LENGTH]----->${key32len.length}');
      myfinalkey = enc.Key.fromUtf8(key32len);
    }

    print(myfinalkey.length);
    final iv = enc.IV.fromLength(16);

    final encrypter = enc.Encrypter(enc.AES(myfinalkey));

    final encrypted =
        encrypter.encrypt((pageid == 1) ? seedPhrase! : privateKey!, iv: iv);

    decryptedVal = encrypter.decrypt(encrypted, iv: iv);

    encryptedVal = encrypted.base64;

    print('ENCRYPTED VALUE ------------->  $encryptedVal');
    print('DECRYPTED VALUE ------------->  $decryptedVal');
    return encryptedVal!; //Using Not symbol [ ! ] after variable means it will not be null.
  }

  @override
  State<SeedonQR> createState() => _SeedonQRState();
}

class _SeedonQRState extends State<SeedonQR> {
  //Logic for encryption
  String custom_key = '';
  int btn_pressed = 0;
  String option = 'default';
  TextEditingController passwd = TextEditingController();

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
        title: Text((widget.pageid == 1) ? 'Encrypting the QR' : 'Encryption',
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
      bottomNavigationBar: (btn_pressed == 0)
          ? BottomAppBar(
              elevation: 0,
              child: SizedBox(
                height: 80,
                child: Row(
                  mainAxisAlignment: (widget.pageid == 2)
                      ? MainAxisAlignment.spaceAround
                      : MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: (widget.pageid == 1) ? 135 : 155,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          backgroundColor: primaryColor(),
                          // backgroundColor: const Color(0xff1e1e1e),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              (widget.pageid == 1) ? 'Generate' : 'Generate QR',
                              style: const TextStyle(
                                  fontSize: 15,
                                  fontFamily: 'Space',
                                  fontWeight: FontWeight.w600),
                            ),
                            const Icon(Icons.qr_code_2_rounded),
                          ],
                        ),
                        onPressed: () {
                          setState(() {
                            print(
                                'CUSTOM KEY -------------------> ${custom_key}');
                            btn_pressed =
                                1; // if pressed, button pressed = 1, Means we fetched the value from generated QR
                          });
                        },
                      ),
                    ),
                    (widget.pageid == 2)
                        ? SizedBox(
                            width: 155,
                            height: 50,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                                backgroundColor: accentColor(),
                                shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8)),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: const [
                                  Text(
                                    'Cloud Store',
                                    style: TextStyle(
                                        // color: Color(0xff1e1e1e),
                                        fontSize: 15,
                                        fontFamily: 'Space',
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Icon(
                                    FontAwesomeIcons.cloudArrowUp,
                                    color: Colors.blue,
                                  ),
                                ],
                              ),
                              onPressed: () {
                                String? privKey;
                                if (option == 'default') {
                                  privKey = widget.doEncryption();
                                } else {
                                  privKey =
                                      widget.doEncryption(key: custom_key);
                                }
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => CloudUpload(
                                              privKey: privKey!,
                                            )));
                              },
                            ),
                          )
                        : const SizedBox(width: 0),
                  ],
                ),
              ),
            )
          : null,
      body: (btn_pressed == 0)
          ? SafeArea(
              child: Container(
                color: Colors.grey.shade50,
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: SizedBox(
                    height: 828,
                    child: Center(
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 10, bottom: 20),
                            height: 200,
                            child: Lottie.asset('assets/anim/encryption.json'),
                          ),
                          Text(
                            'Choose an Encryption method: ',
                            style: TextStyle(
                                color: primaryColor(),
                                fontSize: 20,
                                fontFamily: 'Space',
                                fontWeight: FontWeight.w600),
                          ),
                          // const Divider(),
                          SizedBox(
                            width: 350,
                            child: RadioListTile(
                                title: Text('Encrypt using a default password',
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: accentColor(),
                                      // color: Color(0xff8d8d8d),
                                      // color: Colors.blue.shade800,
                                      fontFamily: 'Space',
                                      // fontWeight: FontWeight.w400
                                    )),
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
                                title: Text('Encrypt using a custom password',
                                    style: TextStyle(
                                      fontSize: 15,
                                      // color: Colors.blue.shade800,
                                      // color: Color(0xff8d8d8d),
                                      color: accentColor(),
                                      fontFamily: 'Space',
                                      // fontWeight: FontWeight.w600
                                    )),
                                value: 'custom',
                                groupValue: option,
                                onChanged: (value) {
                                  setState(() {
                                    option = value.toString();
                                  });
                                }),
                          ),
                          if (option == 'custom')
                            Container(
                              width: 320,
                              margin: const EdgeInsets.all(10),
                              child: TextField(
                                controller: passwd,
                                onChanged: (message) {
                                  setState(() {
                                    custom_key = message;
                                  });
                                },
                                onSubmitted: (message) {
                                  setState(() {
                                    custom_key = message;
                                  });
                                },
                                decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  filled: true,
                                  hintText: 'Enter password',
                                  helperText:
                                      'Password can be any message, it will be used for encrypting the QR.',
                                  helperMaxLines: 2,
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 0, color: Colors.grey.shade400),
                                    borderRadius: BorderRadius.circular(0),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(0),
                                  ),
                                ),
                                maxLength: 32,
                                style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'Space'),
                              ),
                            )
                          else
                            const SizedBox(),
                          const Divider(),
                          Container(
                            margin: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                            child: const Text(
                                'NOTE: \n\nUsing a default password option, you don\'t required any password when importing it back (while restoring your wallet). Since encryption is done using a password. \n\nUsing a custom password, you will be required to remember it since it will be used again to decrypt the QR required when importing it back (but it is much more secure option even if the QR get\'s in the wrong hand they won\'t be able to decrypt it without the password) but if you forgot the password you won\'t be able to decrypt the QR again even we won\'t able to help you. So choose accordingly.',
                                textAlign: TextAlign.justify,
                                style: TextStyle(
                                    fontSize: 10,
                                    color: Color(0xffdc5151),
                                    fontFamily: 'Space',
                                    fontWeight: FontWeight.w600)),
                          ),
                          const Divider(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )
          : SafeArea(
              child: Container(
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
                            padding: EdgeInsets.only(
                                left: 35.0, right: 35.0, bottom: 30),
                            child: Text(
                                'Take a screenshot of this QR, print it and put it on a safe deposit box, and please don\'t forget to delete all the digital copies of the QR (or the private key etc.) from your phone!',
                                textAlign: TextAlign.justify,
                                style: TextStyle(
                                    fontSize: 15,
                                    fontFamily: 'Space',
                                    color: Color(0xffc73333),
                                    fontWeight: FontWeight.w500)),
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
                                  QrImage(
                                    data: (option == 'default')
                                        ? widget.doEncryption()
                                        : widget.doEncryption(key: custom_key),
                                    version: QrVersions.auto,
                                    size: 320,
                                    gapless: false,
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
              ),
            ),
    );
  }
}

// class QRPage extends StatelessWidget {
//   const QRPage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Colors.grey.shade50,
//       child: SingleChildScrollView(
//         physics: const BouncingScrollPhysics(),
//         child: SizedBox(
//           height: 748,
//           child: Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 const Padding(
//                   padding: EdgeInsets.only(left: 35.0, right: 35.0, bottom: 30),
//                   child: Text(
//                       'Take a screenshot of this QR, print it and put it on a safe deposit box, and please don\'t forget to delete all the digital copies of the QR (or the private key etc.) from your phone!',
//                       textAlign: TextAlign.justify,
//                       style: TextStyle(
//                           fontSize: 15,
//                           fontFamily: 'Space',
//                           color: Color(0xffc73333),
//                           fontWeight: FontWeight.w500)),
//                 ),
//                 Container(
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: const BorderRadius.all(Radius.circular(10)),
//                     border: Border.all(
//                       width: .5,
//                       color: Colors.grey.shade300,
//                     ),
//                   ),
//                   margin: const EdgeInsets.only(top: 50),
//                   child: Padding(
//                     padding: const EdgeInsets.all(10.0),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         QrImage(
//                           data: '',
//                           //widget.doEncryption(),
//                           version: QrVersions.auto,
//                           size: 320,
//                           gapless: false,
//                           embeddedImage: const AssetImage(
//                               'assets/images/ethereum-logo.png'),
//                           embeddedImageStyle: QrEmbeddedImageStyle(
//                             size: const Size(80, 80),
//                           ),
//                         ),
//                         RichText(
//                           text: const TextSpan(
//                               text: '',
//                               style: TextStyle(
//                                 color: Color(0xff1f1f1f),
//                                 fontSize: 30,
//                                 fontFamily: 'Alpha',
//                                 fontWeight: FontWeight.w700,
//                               ),
//                               children: [
//                                 TextSpan(
//                                     text: 'CRYPTOX',
//                                     style: TextStyle(
//                                       color: Colors.blue,
//                                       fontWeight: FontWeight.w700,
//                                     ))
//                               ]),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
