import 'dart:developer';
import 'dart:io';
import 'package:cryptoX/confirmSeed.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

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

class _Scan2PayState extends State<Scan2Pay> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

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
    OpenPage() async {
      // Navigator.pushReplacement(
      //     context,
      //     MaterialPageRoute(
      //         builder: (context) => ConfirmSeed(widget.words!, widget.tw)));
      setState(() {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(widget.tw.toString())));
      });
    }

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
    if (result != null && widget.page == 2) {
      print("LENGTH--------------->${result!.code!.length}");
      widget.words = result!.code;
      if (widget.tw.length != 12) {
        for (int i = 0; i < widget.words!.length; i++) {
          if (widget.words![i] == ' ') {
            widget.tw.add(widget.one_word);
            widget.one_word = '';
          } else {
            widget.one_word += widget.words![i];
          }
          if (i == widget.words!.length - 1) {
            widget.tw.add(widget.one_word);
          }
        }
      }

      print('WORDS: ${widget.words}\n LIST_OF_WORDS: ${widget.tw}');
      OpenPage();
      // setState(() {
      //   ScaffoldMessenger.of(context)
      //       .showSnackBar(SnackBar(content: Text(widget.tw.toString())));
      // });
    }
    return Scaffold(
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Stack(
          children: <Widget>[
            InkWell(
                onTap: () async {
                  await controller?.resumeCamera();
                },
                child: SizedBox(height: h!, child: _buildQrView(context))),
            Positioned(
              // margin: const EdgeInsets.all(8),
              top: 50,
              left: 30,
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
                          color: Color(0xffd8edf5),
                        ),
                        child: ('${snapshot.data}' == 'true')
                            ? const Icon(FontAwesomeIcons.boltLightning,
                                color: Colors.orangeAccent)
                            : const Icon(FontAwesomeIcons.boltLightning,
                                color: Colors.black),
                      ); //Text('Flash: ${snapshot.data}');
                    },
                  )),
            ),
            widget.page == 1
                ? Positioned(
                    top: 50,
                    right: 30,
                    child: InkWell(
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('OPENING: MY ADDRESS QR PAGE')));
                      },
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: Color(0xffd8edf5),
                        ),
                        child: Icon(
                          FontAwesomeIcons.qrcode,
                          color: Colors.blue.shade300,
                        ),
                      ),
                    ))
                : const SizedBox(width: 0),
            widget.page == 1
                ? Positioned(
                    width: w,
                    bottom: 0,
                    child: Container(
                      height: 180,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30)),
                        color: Color(0xffd8edf5),
                        // border: ,
                      ),

                      // fit: BoxFit.contain,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          if (result != null)
                            Text(
                                // 'Barcode Type: ${describeEnum(result!.format)}   '
                                'Data: ${result!.code}')
                          else
                            const Text(
                              'Scan a code',
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 22,
                                fontFamily: 'Poppins',
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
                                  decoration: InputDecoration(
                                    hintText: 'OR Enter Address here...',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  onTap: () async {
                                    await controller?.pauseCamera();
                                  },
                                  style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: 'Poppins'),
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
                                    onPressed: () async {
                                      await controller?.pauseCamera();
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
          borderColor: Colors.blueAccent,
          borderRadius: 15,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No Camera Permission!')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
