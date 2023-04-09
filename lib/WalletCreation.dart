import 'package:cryptoX/confirmSeed.dart';
import 'package:cryptoX/secret_keys.dart';
import 'package:cryptoX/seedonQR.dart';
import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class WalletCreation extends StatefulWidget {
  const WalletCreation({super.key});

  @override
  State<WalletCreation> createState() => _WalletCreationState();
}

class _WalletCreationState extends State<WalletCreation> {
  int? selected;
  String? username;
  String generatedWords = '', word = '';
  List twelve_words = [];
  WalletAddress service = WalletAddress();
  // WalletAddress service = WalletAddress();

  // @override
  // void initState() {
  //   super.initState();
  //   () async {
  //     final mnemonic = service.generateMnemonic();
  //     final privateKey = await service.getPrivateKey(mnemonic);
  //     privAddress = privateKey;
  //   };
  // }
  @override
  void initState() {
    super.initState();
    details();
    final mnemonic = service.generateMnemonic();
    generatedWords = mnemonic;

    print(generatedWords);

    for (int i = 0; i < generatedWords.length; i++) {
      if (generatedWords[i] == ' ' || i == generatedWords.length - 1) {
        // print('${word}: ${word.length}');
        twelve_words.add(word);
        word = '';
      } else {
        word += generatedWords[i];
      }
    }
    print(twelve_words);
  }

  details() async {
    //dynamic data = await getUserDetails();
    //data != null?
    // setState(() {
    //   privAddress = data['privateKey'];
    //   pubAddress = data['publicKey'];
    //   username = data['user_name'];
    //   bool created = data['wallet_created'];
    //   created == true ? selected = 1 : selected = 0;
    // }):
    setState(() {
      selected = 0;
    });
  }

  // final publicKey = await service.getPublicKey(privateKey);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      //   Text('SEED PHRASES: ${generatedWords}'),
      //   Text('PrivateKey: ${privAddress}'),
      // ]),
      appBar: AppBar(
        foregroundColor: Colors.black,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(FontAwesomeIcons.angleLeft)),
        title: const Text('To Add a Wallet',
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
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        child: SizedBox(
          height: 748,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin:
                            const EdgeInsets.only(left: 25, top: 22, right: 3),
                        child: const Text(
                          'STEP 1. ',
                          style: TextStyle(
                              color: Color(0xff212121),
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width - 100,
                        margin: const EdgeInsets.fromLTRB(0, 20, 20, 20),
                        child: RichText(
                          textAlign: TextAlign.justify,
                          text: const TextSpan(
                              style: TextStyle(
                                  color: Color(0xff212121),
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600),
                              children: [
                                TextSpan(
                                  text: 'First ',
                                  style: TextStyle(
                                      fontSize: 15, color: Color(0xff212121)),
                                ),
                                TextSpan(
                                  text: 'you need to remember',
                                  style: TextStyle(
                                      // decoration: TextDecoration.underline,
                                      fontSize: 15,
                                      color: Colors.red),
                                ),
                                TextSpan(
                                  text:
                                      ' below 12 words in order to recover your wallet if lost.',
                                  style: TextStyle(
                                      fontSize: 15, color: Color(0xff212121)),
                                ),
                              ]),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
                    child: Column(
                      children: const [
                        Padding(
                          padding: EdgeInsets.only(bottom: 10),
                          child: Text(
                            '!! IMPORTANT !!',
                            style: TextStyle(
                                color: Color(0xffdc5151),
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        Text(
                          'Two ways to remember these words:\n\n👉 Write these words in a paper (or a metal sheet etc.) and put it on a safe deposit box.\n\n👉 Generate QR of these words then you can print it on the paper and put it safe.\n',
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                              fontSize: 12,
                              color: Color(0xff7a7a7a),
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w200),
                        ),
                      ],
                    ),
                  ),
                  const Divider(),
                  Padding(
                    padding: const EdgeInsets.only(left: 18, right: 18),
                    child: Container(
                      // decoration: BoxDecoration(
                      //     color: const Color(0xffe0ffdc),
                      //     borderRadius:
                      //         const BorderRadius.all(Radius.circular(30)),
                      //     border: Border.all(
                      //       color: Colors.green.shade100,
                      //       width: .5,
                      //     )),
                      // margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                      child: Container(
                        margin: const EdgeInsets.only(top: 20, bottom: 10),
                        height: 267,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GridView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  const SliverGridDelegateWithMaxCrossAxisExtent(
                                mainAxisSpacing: 20,
                                crossAxisSpacing: 10,
                                maxCrossAxisExtent: 159,
                                mainAxisExtent: 45,
                              ),
                              itemCount: twelve_words.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  alignment: Alignment.center,
                                  // margin: const EdgeInsets.all(6),
                                  // alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: const Color(0xffb4f1b4),
                                    border: Border.all(
                                        width: .5, color: Colors.green),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(30)),
                                  ),
                                  child: Text(
                                    '${(index + 1)}. ${twelve_words[index]}',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        fontSize: 15,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xff549d54)),
                                  ),
                                );
                              }),
                        ),
                      ),
                    ),
                  ),
                  const Divider(),
                  Container(
                    margin: const EdgeInsets.fromLTRB(20, 5, 20, 20),
                    child: const Text(
                        'NOTE: Everytime you open this page new words are generated so further proceed accordingly. ',
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                            fontSize: 10,
                            color: Color(0xffdc5151),
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600)),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 6),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                            width: 180,
                            height: 50,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                elevation: 5,
                                backgroundColor: const Color(0xff1e1e1e),
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(30),
                                      bottomLeft: Radius.circular(30)),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: const [
                                  Text(
                                    'Generate QR',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Icon(Icons.qr_code_2),
                                ],
                              ),
                              onPressed: () async {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            SeedonQR(generatedWords)));
                              },
                            )),
                        SizedBox(
                            width: 95,
                            height: 50,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                elevation: 5,
                                backgroundColor: const Color(0xff42a14e),
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(30),
                                      bottomRight: Radius.circular(30)),
                                ),
                              ),
                              child: Row(
                                children: const [
                                  Text(
                                    'Next',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Icon(FontAwesomeIcons.angleRight),
                                ],
                              ),
                              onPressed: () async {
                                // setState(() {
                                //   selected = 1;
                                // });

                                // final privateKey = await service
                                //     .getPrivateKey(generatedWords);
                                // final publicKey = await service
                                //     .getPublicKey(privateKey);
                                // privAddress = privateKey;
                                // pubAddress = publicKey.toString();

                                //addUserDetails(privateKey, publicKey);

                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ConfirmSeed(
                                            generatedWords, twelve_words)));
                              },
                            )),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
