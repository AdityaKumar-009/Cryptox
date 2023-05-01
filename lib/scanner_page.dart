import 'dart:developer';
import 'dart:io';
import 'package:cryptoX/private/aes_encryption_decryption.dart';
import 'package:cryptoX/profile_page.dart';
import 'package:encrypt/encrypt.dart' as enc;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'app_theme/theme.dart';

class Scan2Pay extends StatefulWidget {
  String? modeOfScanning;
  // modeOfScanning can be : 'scanAddress', 'scanWords' , 'scanPrivateKey'

  Scan2Pay({required String scannerMode, super.key}) {
    modeOfScanning = scannerMode;
  }

  //
  int popupCount = 0; //USED SINCE TWO ALERT POPUPS CREATE RUN TIME EXCEPTIONS

  // REQUIRED WHEN SCANNING MODE IS SCAN WORDS
  String? words;
  List twelveWords = [];

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
    Future.delayed(const Duration(milliseconds: 1000), () {
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

    if (widget.modeOfScanning == 'scanAddress') {
      h = MediaQuery.of(context).size.height - 100;
    } else {
      h = MediaQuery.of(context).size.height;
    }

    //
    return Scaffold(
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        // MULTIPLE CAMERA ELEMENTS AND BUTTONS ARE TOP OF EACH OTHER
        child: Stack(
          children: <Widget>[
            // SCANNER VIEW
            SizedBox(height: h, child: _buildQrView(context)),

            // TEXT ' SCAN A QR '
            Positioned(
              top: w / 2.5, // RESPONSIVE DISTANCE
              left: w / 2 - 55,
              child: text(
                'Scan a QR',
                color: accentColor(),
                fontSize: 22,
                fontWeight: FontWeight.w600,
              ),
            ),

            // SCANNING ANIMATION
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
                    child:
                        (!isOff) //if camera is not off then show scanning animation
                            ? Lottie.asset('assets/anim/scan.json', width: 300)
                            : const SizedBox(),
                  ),
                )),

            // CLOSE BUTTON
            Positioned(
                top: 50,
                left: 20,
                child: IconButton(
                  tooltip: 'Close Scanner',
                  onPressed: () {
                    Navigator.maybePop(context);
                  },
                  icon: Icon(
                    FontAwesomeIcons.xmark,
                    color: accentColor(),
                    size: 30,
                  ),
                )),

            // FLASH ON OFF BUTTON
            Positioned(
              top: 50,
              right: 20,
              child: IconButton(
                  tooltip: 'flashlight on/off',
                  onPressed: () async {
                    await controller?.toggleFlash();
                    setState(() {});
                  },
                  icon: FutureBuilder(
                    future: controller?.getFlashStatus(),
                    builder: (context, snapshot) {
                      return ('${snapshot.data}' == 'true')
                          ? Icon(Icons.flash_on_sharp,
                              color: accentColor(), size: 30)
                          : Icon(
                              Icons.flash_off_sharp,
                              color: accentColor(),
                              size: 30,
                            );
                    },
                  )),
            ),

            widget.modeOfScanning == 'scanAddress'
                ?
                // MY PROFILE PAGE THAT CONTAINS MY ADDRESS
                Positioned(
                    top: 51,
                    right: 70,
                    child: IconButton(
                      tooltip: 'My QR',
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProfilePage()));
                      },
                      icon: Icon(
                        FontAwesomeIcons.qrcode,
                        color: accentColor(),
                        size: 25,
                      ),
                    ))
                : const SizedBox(),
            widget.modeOfScanning == 'scanAddress'
                ? Positioned(
                    width: w,
                    bottom: 0,
                    child: Container(
                      height: 130,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(16),
                            topRight: Radius.circular(16)),
                        color: Color(0xffffeccf),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          if (result != null)
                            Text(
                                // 'Barcode Type: ${describeEnum(result!.format)}   ' // TO SHOW BARCODE TYPE
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
                                child: inputField(
                                    hintText:
                                        '0x - - - - - - - - - - - - - - -',
                                    shadowColor: const Color(0x54de9f3f),
                                    onTap: () async {
                                      await controller?.pauseCamera();
                                      setState(() {
                                        isOff = true;
                                      });
                                    },
                                    textAlign: TextAlign.center),
                              ),
                              const Expanded(
                                flex: 1,
                                child: SizedBox(
                                  width: 10,
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Container(
                                  padding: const EdgeInsets.only(bottom: 18),
                                  child: IconButton(
                                    padding: EdgeInsets.zero,
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
                                    icon: Icon(
                                      FontAwesomeIcons.arrowRight,
                                      color: primaryColor(),
                                    ),
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
      onPermissionSet: (qrController, cameraPermission) =>
          _onPermissionSet(context, qrController, cameraPermission),
    );
  }

  void _onQRViewCreated(QRViewController controller) async {
    setState(() {
      this.controller = controller;
    });

    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result =
            scanData; // scanData is data fetched from QR has two values: code -> string, format -> describe it is QR or Barcode
        widget.popupCount++;
        // if scanner is accessed from other pages not from home screen [normal scan to pay] then invoke decryption
        if (result!.code != null && widget.modeOfScanning != 'scanAddress') {
          decryptor(result, controller);
        }
      });
    });
  }

  //

  //REACT WHEN CAMERA PERMISSION IS NOT GIVEN
  void _onPermissionSet(
      BuildContext context, QRViewController qrController, bool permission) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $permission');
    if (!permission) {
      // if camera permission not given by the user show snackbar
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

  //

  // DECRYPTION OF ENCRYPTED QR ( that can contains words or private key )
  void decryptor(Barcode? result, QRViewController controller) {
    //
    print("LENGTH ---------------> ${result!.code!.length}");

    UseAES aes = UseAES(); // for using AES algorithm service I created
    try {
      widget.words = aes.doDecryption(res: result); // try with default password
      print(
          'WORDS DECRYPTED HURRAY ----------------------------> ${widget.words}');

      // Split the the strings into list that stores twelve words [ or one word private key ]
      if (widget.twelveWords.length != 12) {
        // if twelve words list is not already filled with any value then store it
        widget.twelveWords = widget.words!.split(' ');
      }
      print(
          'WORDS ---> ${widget.words}\n LIST_OF_WORDS ---> ${widget.twelveWords}');

      if (widget.twelveWords.length == 12) {
        // if 12 words are found
        controller.pauseCamera();
        setState(() {
          isOff = true;
        });

        // if Scanner Page can be popped, then pop it! [ used since exception occurs sometimes ] and return the decrypted 12 words
        Navigator.maybePop(context, widget.twelveWords);
      }
      if (widget.modeOfScanning == 'scanPrivateKey' &&
          widget.twelveWords.length == 1) {
        // condition for private key found on QR
        controller.pauseCamera();
        setState(() {
          isOff = true;
        });
        Navigator.maybePop(
            context, widget.twelveWords); // return the decrypted private key
      }
    } catch (e) {
      // EXCEPTION CAN BE OCCURRED IF DEFAULT PASSWORD DO NOT WORK, IT NEEDS PASSWORD, OR CAN BE WRONG QR
      String customKey = '';
      print(e);

      // !! USE THIS ALERT IN CLOUD RESTORE AS WELL FOR ENTERING PASSWORD FOR PRIVATE KEY ENCRYPTED USING CUSTOM PASSWORD
      // ------------------- ALERT --------------------|
      var alertStyle = AlertStyle(
        animationType: AnimationType.grow,
        isOverlayTapDismiss: false,
        descTextAlign: TextAlign.start,
        backgroundColor: lightGrey(),
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

      dynamic
          popup; // CREATED AN OBJECT FOR LATER ASSIGNING AN ALERT [ SINCE OK BUTTON IS DISMISSING ITS OWN INSTANCE AND DECLARED INSIDE IT ]

      // TODO USE THIS POPUP IN DECRYPTING PRIVATE KEY FROM THE CLOUD IN THE CLOUD RESTORE | IMPORT PAGE
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
        type: AlertType.warning,
        title: "Password Required",
        // desc: "This QR is encrypted using a custom password.",
        content: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 10, top: 10),
              child: Text(
                'This QR may have been encrypted using a custom password.',
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
              child: inputField(
                onChanged: (message) {
                  setState(() {
                    customKey = message;
                  });
                },
                onSubmitted: (message) {
                  setState(() {
                    customKey = message;
                  });
                },
                hintText: 'Enter Password here...',
                maxLength: 32,
              ),
            ),
          ],
        ),
        buttons: [
          DialogButton(
            onPressed: () async {
              try {
                widget.words = aes.doDecryption(
                    key: customKey,
                    res: result); // Try With Custom key / password
                print(
                    'WORDS DECRYPTED HURRAY ----------------------------> ${widget.words}');
                List lst = [];
                if (widget.twelveWords.length != 12) {
                  lst = widget.words!.split(' ');
                }
                widget.twelveWords = lst;
                popup.dismiss(); // DISMISS THE CUSTOM POPUP
                controller.pauseCamera();
                setState(() {
                  isOff = true;
                });
                if (widget.twelveWords.length == 12) {
                  Navigator.maybePop(context, widget.twelveWords);
                } else if (widget.modeOfScanning == 'scanPrivateKey' &&
                    widget.twelveWords.length == 1) {
                  Navigator.maybePop(context, widget.twelveWords);
                }
              } catch (e) {
                print("Error Occurred!");
                popup.dismiss();
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
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
      if (widget.popupCount == 1) {
        controller.pauseCamera();
        setState(() {
          isOff = true;
        });
        popup.show();
      } else if (widget.popupCount >= 2) {
        widget.popupCount = 0;
      }
      // ------------------- ALERT ---------------------|
    }
  }
}
