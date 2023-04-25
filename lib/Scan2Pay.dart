import 'dart:developer';
import 'dart:io';
import 'package:cryptoX/profilepage.dart';
import 'package:encrypt/encrypt.dart' as enc;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'apptheme/theme.dart';

class Scan2Pay extends StatefulWidget {
  int? page;

  Scan2Pay(int p, {super.key}) {
    page = p;
  }

  String? words;
  List tw = [];
  String one_word = '';

  @override
  State<StatefulWidget> createState() => _Scan2PayState();
}

class _Scan2PayState extends State<Scan2Pay>
    with SingleTickerProviderStateMixin {
  Barcode? result;
  QRViewController? controller;
  bool isOff = false;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  String txt = 'Wrong Password';

  late final AnimationController _animcontroller = AnimationController(
    vsync: this,
    duration: const Duration(
      milliseconds: 1700,
    ),
  );

  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 500), () {
      _animcontroller.forward();
    });
    super.initState();
  }

  @override
  void dispose() {
    _animcontroller.dispose();
    controller?.dispose();
    super.dispose();
  }

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    //   statusBarIconBrightness: Brightness.light,
    // ));
    double w = MediaQuery.of(context).size.width;
    double? h;

    if (widget.page == 1) {
      h = MediaQuery.of(context).size.height - 100;
    } else {
      h = MediaQuery.of(context).size.height;
    }

    //
    //
    // print(widget.page);
    return Scaffold(
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Stack(
          children: <Widget>[
            SizedBox(height: h, child: _buildQrView(context)),
            //Using Not symbol [ ! ] after variable means it will not be null.
            Positioned(
              top: w / 2.5,
              left: w / 2 - 55,
              // right: 50,
              child: Text(
                'Scan a QR',
                style: TextStyle(
                  color: accentColor(),
                  fontSize: 22,
                  fontFamily: 'Space',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: InkWell(
                  onTap: () async {
                    await controller?.resumeCamera();
                    setState(() {
                      isOff = false;
                    });
                  },
                  child: SizedBox(
                    // color: Colors.red,
                    height: h,
                    child: (!isOff)
                        ? Lottie.asset('assets/anim/scan.json',
                            // 'https://assets5.lottiefiles.com/packages/lf20_odNqQgGlnU.json',
                            // 'https://assets4.lottiefiles.com/packages/lf20_d4tt1t6i.json',
                            width: 300)
                        : const SizedBox(),
                  ),
                )),
            Positioned(
                top: 50,
                left: 20,
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Icon(
                      FontAwesomeIcons.xmark,
                      color: accentColor(),
                      size: 30,
                    ),
                  ),
                )),
            Positioned(
              // margin: const EdgeInsets.all(8),
              top: 50,
              right: 20,
              child: InkWell(
                  onTap: () async {
                    await controller?.toggleFlash();
                    setState(() {});
                  },
                  child: FutureBuilder(
                    future: controller?.getFlashStatus(),
                    builder: (context, snapshot) {
                      return Container(
                        height: 40,
                        width: 40,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          // color: Color(0xffd8edf5),
                        ),
                        child: ('${snapshot.data}' == 'true')
                            ? Icon(Icons.flash_on_sharp,
                                color: accentColor(), size: 30)
                            : Icon(
                                Icons.flash_off_sharp,
                                color: accentColor(),
                                size: 30,
                                // color: Colors.black
                              ),
                      ); //Text('Flash: ${snapshot.data}');
                    },
                  )),
            ),
            widget.page == 1
                ? Positioned(
                    top: 50,
                    right: 70,
                    child: InkWell(
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProfilePage()));
                      },
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Icon(
                          FontAwesomeIcons.qrcode,
                          color: accentColor(),
                        ),
                      ),
                    ))
                : const SizedBox(width: 0),
            widget.page == 1
                ? Positioned(
                    width: w,
                    bottom: 0,
                    child: Container(
                      height: 130,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(16),
                              topRight: Radius.circular(16)),
                          // color: Color(0xffd8edf5),
                          color: Color(0xffffeccf)
                          // border: ,
                          ),

                      // fit: BoxFit.contain,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          if (result != null)
                            Text(
                                // 'Barcode Type: ${describeEnum(result!.format)}   '
                                'Other\'s Address: ${result!.code}') //Using Not symbol [ ! ] after variable means it will not be null.
                          else
                            Text(
                              'Enter Address',
                              style: TextStyle(
                                color: accentColor(),
                                fontSize: 22,
                                fontFamily: 'Space',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.center,
                          //   crossAxisAlignment: CrossAxisAlignment.center,
                          //   children: <Widget>[
                          //     Container(
                          //       margin: const EdgeInsets.all(8),
                          //       child: ElevatedButton(
                          //           onPressed: () async {
                          //             await controller?.flipCamera();
                          //             setState(() {});
                          //           },
                          //           child: FutureBuilder(
                          //             future: controller?.getCameraInfo(),
                          //             builder: (context, snapshot) {
                          //               if (snapshot.data != null) {
                          //                 return Text(
                          //                     'Camera facing ${describeEnum(snapshot.data!)}');
                          //               } else {
                          //                 return const Text('loading');
                          //               }
                          //             },
                          //           )),
                          //     )
                          //   ],
                          // ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              const Expanded(
                                flex: 1,
                                child: SizedBox(
                                  width: 10,
                                ),
                              ),
                              Expanded(
                                flex: 20,
                                child: TextField(
                                  autocorrect: false,
                                  cursorColor: accentColor(),
                                  decoration: InputDecoration(
                                    fillColor: Colors.white,
                                    filled: true,
                                    hintText: '0x - - - - - - - - - - - - - ',
                                    helperMaxLines: 2,
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide.none,
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide.none,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  onTap: () async {
                                    await controller?.pauseCamera();
                                    setState(() {
                                      isOff = true;
                                    });
                                  },
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      fontSize: 15, fontFamily: 'Space'),
                                ),
                              ),
                              const Expanded(
                                flex: 1,
                                child: SizedBox(
                                  width: 10,
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: SizedBox(
                                  height: 50,
                                  child: TextButton(
                                    style: TextButton.styleFrom(
                                      foregroundColor: primaryColor(),
                                    ),
                                    onPressed: () async {
                                      await controller?.pauseCamera();
                                      setState(() {
                                        isOff = true;
                                      });
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              content: Text(
                                                  'OPENING: Paying Using Manual Address!')));
                                    },
                                    child:
                                        const Icon(FontAwesomeIcons.arrowRight),
                                    // child: const Text('pause',
                                    //     style: TextStyle(fontSize: 20)),
                                  ),
                                ),
                              ),
                              const Expanded(
                                flex: 1,
                                child: SizedBox(
                                  width: 10,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                : const SizedBox(width: 0)
          ],
        ),
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 300.0
        : 350.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: accentColor(),
          borderRadius: 16,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) async {
    setState(() {
      this.controller = controller;
    });

    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;

        if (result!.code != null && widget.page != 1) {
          decryptor(result, controller);
          // ScaffoldMessenger.of(context).removeCurrentSnackBar();
        }
      });
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        showCloseIcon: true,
        backgroundColor: Colors.red.shade700,
        behavior: SnackBarBehavior.floating,
        content: const Text(
          'No Camera Permission allowed by the User!',
          style: TextStyle(fontFamily: 'Space', fontWeight: FontWeight.w600),
        ),
      ));
    }
  }

  String doDecryption({String key = '', required Barcode res}) {
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

    final decryptedVal = encrypter.decrypt64(res.code.toString(), iv: iv);

    // if (decryptedVal.isEmpty) {
    //   setState(() {
    //     txt = 'Invalid Password or Invalid QR!';
    //   });
    // }
    print('DECRYPTED VALUE ------------->  $decryptedVal');

    return decryptedVal;
  }

  void decryptor(Barcode? result, QRViewController controller) {
    //Using Not symbol [ ! ] after variable means it will not be null.
    print("LENGTH ---------------> ${result!.code!.length}");

    try {
      widget.words = doDecryption(res: result);
      print(
          'WORDS DECRYPTED HURRAY ----------------------------> ${widget.words}');
      if (widget.tw.length != 12) {
        widget.tw = widget.words!.split(' ');
      }
      print('WORDS ---> ${widget.words}\n LIST_OF_WORDS ---> ${widget.tw}');
      if (widget.tw.length == 12) {
        controller.pauseCamera();
        setState(() {
          isOff = true;
        });
        Navigator.maybePop(context, widget.tw);
      }
      if (widget.page == 3 && widget.tw.length == 1) {
        controller.pauseCamera();
        setState(() {
          isOff = true;
        });
        Navigator.maybePop(context, widget.tw);
      }
    } catch (e) {
      String custom_key = '';
      print(e);

      var alertStyle = AlertStyle(
        animationType: AnimationType.grow,
        // isCloseButton: false,
        isOverlayTapDismiss: false,

        descTextAlign: TextAlign.start,
        animationDuration: const Duration(milliseconds: 400),
        alertBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide.none,
        ),
        titleStyle: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
            fontFamily: 'Space',
            color: Colors.red),
      );

      controller.pauseCamera();
      setState(() {
        isOff = true;
      });
      // TextEditingController passwd = TextEditingController();

      // bool enabled = false;
      dynamic popup;
      popup = Alert(
        closeFunction: () {
          controller.resumeCamera();
          setState(() {
            isOff = false;
          });
          popup.dismiss();
        },
        context: context,
        style: alertStyle,
        type: AlertType.info,
        title: "Password Required",
        // desc: "This QR is encrypted using a custom password.",
        content: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 10, top: 10),
              child: Text(
                'This QR may encrypted using a custom password.',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                    fontFamily: 'Space',
                    color: Colors.grey.shade500),
              ),
            ),
            Container(
              width: 320,
              margin: const EdgeInsets.all(10),
              child: TextField(
                // controller: passwd,
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
                  hintText: 'Enter password here...',
                  helperMaxLines: 2,
                  helperStyle: const TextStyle(
                    fontSize: 12,
                    fontFamily: 'Space',
                    // color: Colors.red,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(width: .5, color: Colors.grey.shade400),
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
            ),
            // Text(txt),
          ],
        ),
        buttons: [
          DialogButton(
            onPressed: () async {
              try {
                widget.words = doDecryption(key: custom_key, res: result);
                print(
                    'WORDS DECRYPTED HURRAY ----------------------------> ${widget.words}');
                List lst = [];
                if (widget.tw.length != 12) {
                  lst = widget.words!.split(' ');
                }
                widget.tw = lst;
                popup.dismiss();
                if (widget.tw.length == 12) {
                  Navigator.pop(context, widget.tw);
                } else if (widget.page == 3 && widget.tw.length == 1) {
                  controller.pauseCamera();
                  setState(() {
                    isOff = true;
                  });
                  Navigator.maybePop(context, widget.tw);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    // showCloseIcon: true,
                    backgroundColor: Colors.red.shade800,
                    behavior: SnackBarBehavior.floating,
                    content: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.error,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(
                                // width: double.infinity - 200,
                                child: Text(
                                  'ERROR OCCURRED!',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: 'Space',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18),
                                ),
                              ),
                            ],
                          ),
                          const Divider(),
                          const Text(
                            'Reasons can be:',
                            style: TextStyle(
                                fontFamily: 'Space',
                                fontWeight: FontWeight.w600,
                                fontSize: 12),
                          ),
                          const Text(
                            '1. Incorrect password entered.',
                            style: TextStyle(fontFamily: 'Space', fontSize: 10),
                          ),
                          const Text(
                            '2. Scanned an invalid QR.',
                            style: TextStyle(fontFamily: 'Space', fontSize: 10),
                          ),
                        ],
                      ),
                    ),
                  ));
                  controller.resumeCamera();
                  setState(() {
                    isOff = false;
                  });
                }
              } catch (e) {
                print("Error Occurred!");
                popup.dismiss();
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  // showCloseIcon: true,
                  backgroundColor: Colors.red.shade800,
                  behavior: SnackBarBehavior.floating,
                  content: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.error,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              // width: double.infinity - 200,
                              child: Text(
                                'ERROR OCCURRED!',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontFamily: 'Space',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18),
                              ),
                            ),
                          ],
                        ),
                        const Divider(),
                        const Text(
                          'Reasons can be:',
                          style: TextStyle(
                              fontFamily: 'Space',
                              fontWeight: FontWeight.w600,
                              fontSize: 12),
                        ),
                        const Text(
                          '1. Incorrect password entered.',
                          style: TextStyle(fontFamily: 'Space', fontSize: 10),
                        ),
                        const Text(
                          '2. Scanned an invalid QR.',
                          style: TextStyle(fontFamily: 'Space', fontSize: 10),
                        ),
                      ],
                    ),
                  ),
                ));
                controller.resumeCamera();
                setState(() {
                  isOff = false;
                });
              }
            },
            // color: const Color.fromRGBO(0, 179, 134, 1.0),
            color: accentColor(),
            radius: BorderRadius.circular(8),
            width: 80,
            child: const Text(
              "OK",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontFamily: 'Space',
                  fontWeight: FontWeight.w600),
            ),
          ),
        ],
      );
      popup.show();
      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      //   showCloseIcon: true,
      //   backgroundColor: Colors.red.shade700,
      //   behavior: SnackBarBehavior.floating,
      //   content: const Text(
      //     'INVALID QR',
      //     style:
      //     TextStyle(fontFamily: 'Space', fontWeight: FontWeight.w600),
      //   ),
      // ));
    }

    // setState(() {
    //   ScaffoldMessenger.of(context)
    //       .showSnackBar(SnackBar(content: Text(widget.tw.toString())));
    // });
  }
}
