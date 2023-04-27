import 'package:encrypt/encrypt.dart' as enc;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';

class CloudUpload extends StatefulWidget {
  String privateKey = '';
  String Page = '';
  CloudUpload({String privKey = '', String page = 'export_to_db', super.key}) {
    privateKey = privKey;
    Page = page;
  }

  @override
  State<CloudUpload> createState() => _CloudUploadState();
}

class _CloudUploadState extends State<CloudUpload> {
  String? encryptedVal;

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
        title: Text(
            (widget.Page != 'import_from_db') ? 'CLOUD STORE' : 'CLOUD RESTORE',
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
                      onPressed: () async {
                        if (widget.Page == 'export_to_db') {
                          //
                          // LOGIC TO EXPORT / UPLOAD ENCRYPTED PRIVATE KEY IN A FILE TO THE
                          //
                        } else {
                          //
                          // LOGIC TO IMPORT BACK ENCRYPTED PRIVATE KEY FROM A FILE STORED IN THAT GOOGLE DRIVE AND
                          // SHOW THE POPUP (IF ENCRYPTED USING CUSTOM PASSWORD)
                          // TO ENTER THE PASSWORD FOR DECRYPTION AND POP THE PAGE WITH RETURNING THAT PRIVATE KEY STRING
                          //
                        }
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text(
                                'Exporting or importing from Google Drive method is called!')));
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
                        onPressed: () async {
                          if (widget.Page == 'export_to_db') {
                            //
                            // LOGIC TO EXPORT / UPLOAD ENCRYPTED PRIVATE KEY IN A FILE TO THE FIRESTORE CLOUD
                            //
                          } else {
                            //
                            // LOGIC TO IMPORT BACK ENCRYPTED PRIVATE KEY FROM A FILE THAT WAS STORED IN THE FIRESTORE AND
                            // SHOW THE POPUP TO ENTER THE PASSWORD
                            //  (IF ENCRYPTED USING CUSTOM PASSWORD) FOR DECRYPTION AND POP THE PAGE WITH RETURNING THAT PRIVATE KEY STRING
                            //
                          }
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              content: Text(
                                  'Exporting or importing from FIRE STORE method is called!')));
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
