import 'package:cryptoX/MyDashBoardPage.dart';
import 'package:cryptoX/secret_keys.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

    final privateKey = await service.getPrivateKey(widget
        .seedPhrase!); //Using Not symbol [ ! ] after variable means it will not be null.
    final publicKey = await service.getPublicKey(privateKey);

    setState(() {
      privAddress = privateKey;
      pubAddress = publicKey.toString();
      wallet_created();
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
        // leading: IconButton(
        //     onPressed: () {
        //       Navigator.of(context).pop();
        //     },
        //     icon: const Icon(FontAwesomeIcons.close)),
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
                  margin: const EdgeInsets.all(30), alignment: Alignment.center,
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
                Container(
                  margin: EdgeInsets.all(20),
                  width: 200,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 5,
                      backgroundColor: const Color(0xff1e1e1e),
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const [
                        Icon(FontAwesomeIcons.wallet),
                        Text(
                          'Main Page',
                          style: TextStyle(
                              fontSize: 15,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    onPressed: () async {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MyHomePage()));
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void wallet_created() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    bool isC = await sp.setBool(MyHomePageState.IS_CREATED, true);
    if (isC) {
      print('--------->_ISCREATED SUCCESSFULLY!');
    }
    bool isP = await sp.setString(MyHomePageState.PUBLICADDRESS, pubAddress!);
    if (isP) {
      print('------------->pubAdress updated SUCCESSFULLY!');
    }

    //Using Not symbol [ ! ] after variable means it will not be null.
  }

  // wallet_created() async {
  //   SharedPreferences sp = await SharedPreferences.getInstance();
  //   await sp.setBool(MyHomePageState.IS_CREATED, true);
  //   await sp.setString(
  //       MyHomePageState.PUBLICADDRESS,
  //       pubAddress
  //           .toString()); //Using Not symbol [ ! ] after variable means it will not be null.
  // }
}
