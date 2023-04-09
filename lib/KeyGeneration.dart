import 'package:cryptoX/secret_keys.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class KeyGen extends StatefulWidget {
  String? seedPhrase;

  KeyGen(String seed, {super.key}) {
    seedPhrase = seed;
  }

  @override
  State<KeyGen> createState() => _KeyGenState();
}

class _KeyGenState extends State<KeyGen> {
  WalletAddress service = WalletAddress();
  String? pubAddress;
  String? privAddress;

  generate() async {
    WalletAddress service = WalletAddress();

    final privateKey = await service.getPrivateKey(widget.seedPhrase!);
    final publicKey = await service.getPublicKey(privateKey);

    setState(() {
      privAddress = privateKey;
      pubAddress = publicKey.toString();
    });
  }

  @override
  void initState() {
    generate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        foregroundColor: Colors.black,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(FontAwesomeIcons.close)),
        title: const Text('WALLET CREATED',
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
        physics: const BouncingScrollPhysics(),
        child: SizedBox(
          height: 748,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                    child: Container(
                  margin: const EdgeInsets.all(30),
                  alignment: Alignment.center,
                  // height: 80,
                  width: MediaQuery.of(context).size.width,
                  color: const Color(0xff7cb76f),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          FontAwesomeIcons.check,
                          color: Color(0xff007525),
                        ),
                        Container(
                          width: 180,
                          margin: const EdgeInsets.only(left: 15),
                          child: const Text('WALLET INITIATED SUCCESSFULLY!',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'Poppins',
                                  // color: Color(0xffc73333),
                                  color: Color(0xff007525),
                                  fontWeight: FontWeight.w600)),
                        ),
                      ],
                    ),
                  ),
                )),
                Container(
                  margin: const EdgeInsets.only(top: 50),
                  child: SizedBox(
                    // height: MediaQuery.of(context).size.height - 110,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Center(
                          child: Text(
                            "Wallet Private Address :",
                            style: TextStyle(
                              fontSize: 17,
                            ),
                          ),
                        ),
                        Center(
                          child: Text(
                            "$privAddress",
                            style: const TextStyle(
                              fontSize: 10,
                            ),
                          ),
                        ),
                        const Center(
                          child: Text(
                            "Do not reveal your private address to anyone!",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        const Divider(),
                        const Center(
                          child: Text(
                            "Wallet Public Address : ",
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                        Center(
                          child: Text(
                            "$pubAddress",
                            style: const TextStyle(
                              fontSize: 10,
                            ),
                          ),
                        ),
                        const Divider(),
                        const Center(
                          child: Text(
                            "Go back to main page!",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 18,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
