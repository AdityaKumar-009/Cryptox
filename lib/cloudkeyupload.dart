import 'package:encrypt/encrypt.dart' as enc;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';

class CloudUpload extends StatefulWidget {
  String privKey = '';

  CloudUpload(String privateKey, {super.key}) {
    privKey = privateKey;
  }

  @override
  State<CloudUpload> createState() => _CloudUploadState();
}

class _CloudUploadState extends State<CloudUpload>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(vsync: this, duration: const Duration(seconds: 5));

  String? encryptedVal;
  @override
  void initState() {
    _controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // String? decryptedVal;
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
        title: const Text('CLOUD STORE',
            textAlign: TextAlign.center,
            style: TextStyle(
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
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          child: SizedBox(
            height: 700,
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 20, bottom: 20),
                  child: const Text(
                    'Choose a cloud storage provider',
                    style: TextStyle(
                        color: Color(0xba000000),
                        fontSize: 18,
                        fontFamily: 'Space',
                        fontWeight: FontWeight.w400),
                  ),
                ),
                Container(
                  height: 300,
                  margin: const EdgeInsets.only(top: 10, bottom: 30),
                  child: Lottie.asset(
                    'assets/anim/cloud-store.json',
                    // controller: _controller
                  ),
                ),
                Center(
                  child: SizedBox(
                    width: 160,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 1,
                        backgroundColor: const Color(0xffffffff),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            'Google Drive',
                            style: TextStyle(
                                color: Color(0xff1e1e1e),
                                fontSize: 15,
                                fontFamily: 'Space',
                                fontWeight: FontWeight.w600),
                          ),
                          Icon(
                            FontAwesomeIcons.googleDrive,
                            color: Colors.blue,
                          ),
                        ],
                      ),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Uploading on Google Drive')));
                      },
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20, bottom: 20),
                  child: Center(
                    child: SizedBox(
                      width: 135,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          // backgroundColor: const Color(0xffffffff),
                          backgroundColor: const Color(0xff1e1e1e),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              'Fire Store',
                              style: TextStyle(
                                  // color: Color(0xff1e1e1e),
                                  fontSize: 15,
                                  fontFamily: 'Space',
                                  fontWeight: FontWeight.w600),
                            ),
                            Icon(
                              FontAwesomeIcons.fireFlameCurved,
                              color: Colors.orangeAccent,
                            ),
                          ],
                        ),
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content:
                                      Text('Uploading on FireBase Store')));
                        },
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
