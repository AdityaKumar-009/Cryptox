import 'package:cryptoX/app_theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';

class CloudUpload extends StatefulWidget {
  String? privateKey;
  String? Page;

  CloudUpload({String? privKey, required String page, super.key}) {
    privateKey = privKey;
    Page = page;
  }

  @override
  State<CloudUpload> createState() => _CloudUploadState();
}

class _CloudUploadState extends State<CloudUpload> {
  String? encryptedVal;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightGrey(),

      //

      appBar: titledAppBar(
          title: (widget.Page != 'import_from_db')
              ? 'CLOUD STORE'
              : 'CLOUD RESTORE',
          putLeading: true,
          leadingContent: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(
                FontAwesomeIcons.xmark,
                color: primaryColor(),
              ))),

      //

      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 20, bottom: 20),
                child: text(
                  'Choose a cloud storage provider',
                  fontSize: 18,
                ),
              ),
              Container(
                height: 300,
                margin: const EdgeInsets.only(top: 10, bottom: 30),
                child: Lottie.asset(
                  'assets/anim/cloud-store.json',
                ),
              ),
              Center(
                child: SizedBox(
                  width: 150,
                  height: 50,
                  child: button(
                    content: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        text('Google Drive',
                            fontSize: 15, fontWeight: FontWeight.w600),
                        const Icon(
                          FontAwesomeIcons.googleDrive,
                          color: Colors.blue,
                        ),
                      ],
                    ),
                    onPressed: () async {
                      if (widget.Page == 'export_to_db') {
                        //
                        // LOGIC TO EXPORT / UPLOAD PRIVATE KEY
                        // [ firstly encrypt the private key using UseAES class then create a .txt file ]
                        // AND UPLOAD -> LOGIC TO THE GOOGLE DRIVE
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
                    width: 150,
                    height: 50,
                    child: button(
                      color: primaryColor(),
                      content: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          text('Fire Store',
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Colors.orangeAccent),
                          const Icon(
                            FontAwesomeIcons.fireFlameCurved,
                            color: Colors.orangeAccent,
                          ),
                        ],
                      ),
                      onPressed: () async {
                        if (widget.Page == 'export_to_db') {
                          //
                          // LOGIC TO EXPORT / UPLOAD PRIVATE KEY
                          // [ firstly encrypt the private key using UseAES class then create a .txt file ]
                          // AND UPLOAD LOGIC TO THE FIRESTORE CLOUD
                          //
                        } else {
                          //
                          // LOGIC TO IMPORT BACK ENCRYPTED PRIVATE KEY FROM A FILE THAT WAS STORED IN THE FIRESTORE AND
                          // SHOW THE POPUP [ used in the scanner_page.dart ] TO ENTER THE PASSWORD
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
    );
  }
}
