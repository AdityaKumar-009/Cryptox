import 'package:cryptoX/app_theme/theme.dart';
import 'package:cryptoX/creation_restoration_pages/confirm_or_restore.dart';
import 'package:cryptoX/private/secret_keys.dart';
import 'package:cryptoX/creation_restoration_pages/generate_qr.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class GenerateSeedPhrases extends StatefulWidget {
  const GenerateSeedPhrases({super.key});

  @override
  State<GenerateSeedPhrases> createState() => _GenerateSeedPhrasesState();
}

class _GenerateSeedPhrasesState extends State<GenerateSeedPhrases> {
  String generatedWords = '';
  List<String> twelveWords = [];

  @override
  void initState() {
    super.initState();
    // CREATING WALLET ADDRESS OBJECT TO USE DIFFERENT OPERATIONS [ WalletAddress is present in secret_keys.dart file ]
    WalletAddress service = WalletAddress();
    // INVOKING IT's GENERATE MNEMONIC METHOD TO GENERATE 12 WORDS
    final mnemonic = service.generateMnemonic();
    generatedWords = mnemonic;

    print(generatedWords);

    // CREATING A LIST THAT STORES ALL 12 WORDS
    twelveWords = generatedWords.split(' ');
    print(twelveWords.length);
    print(twelveWords);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightGrey(),
      appBar: titledAppBar(
          title: 'Create Wallet',
          leadingContent: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(FontAwesomeIcons.angleLeft, color: primaryColor()))),
      bottomNavigationBar: bottomBar(
          content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
              width: 160,
              height: 50,
              child: button(
                color: primaryColor(),
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    text('Generate QR',
                        color: lightTheme(),
                        fontSize: 15,
                        fontWeight: FontWeight.w600),
                    const Icon(Icons.qr_code_2),
                  ],
                ),
                onPressed: () async {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => GenerateQR(
                                words: generatedWords,
                                Page: 'words',
                              )));
                },
              )),
          SizedBox(
              width: 95,
              height: 50,
              child: button(
                color: accentColor(),
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    text('  Next',
                        fontSize: 15,
                        color: lightTheme(),
                        fontWeight: FontWeight.w600),
                    const Icon(FontAwesomeIcons.angleRight),
                  ],
                ),
                onPressed: () async {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ConfirmSeed(
                                wordPhrases: generatedWords,
                                twelveWordsList: twelveWords,
                                Page: 'create',
                              )));
                },
              )),
        ],
      )),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
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
                      child: text(
                        'STEP 1. ',
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width - 100,
                      margin: const EdgeInsets.fromLTRB(0, 20, 20, 20),
                      child: RichText(
                        textAlign: TextAlign.justify,
                        text: TextSpan(
                            style: TextStyle(
                                color: primaryColor(),
                                fontFamily: 'Space',
                                fontWeight: FontWeight.w600),
                            children: const [
                              TextSpan(
                                text:
                                    'Remember these 12 words for recovery purpose in case you lose your wallet.',
                                style: TextStyle(fontSize: 15),
                              ),
                            ]),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: text(
                          '!! IMPORTANT !!',
                          color: red(),
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      text(
                        'Two ways to remember these words:\n\n👉  Write these words on a sheet of paper (or a metal sheet etc.) and put it safe somewhere from theft and damages.\n\n👉 Generate QR of these words then you can print it on a paper and put it safe.\n',
                        textAlign: TextAlign.justify,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ],
                  ),
                ),
                const Divider(),
                // CONTAINER FOR SHOWING SEED PHRASES
                Container(
                  margin: const EdgeInsets.only(
                      left: 18, right: 18, top: 20, bottom: 10),
                  height: 267, // REQUIRED FOR GRID VIEW BUILDER
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                          mainAxisSpacing: 20,
                          crossAxisSpacing: 20,
                          maxCrossAxisExtent: 149,
                          mainAxisExtent: 45,
                        ),
                        itemCount: twelveWords.length,
                        itemBuilder: (context, index) {
                          return Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.white,
                              boxShadow: const [
                                BoxShadow(
                                  color: Color(0xffe8e8e8),
                                  blurRadius: 40,
                                )
                              ],
                            ),
                            child: Text(
                              '${(index + 1)}. ${twelveWords[index]}',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 15,
                                fontFamily: 'Space',
                                fontWeight: FontWeight.w900,
                                color: Color(0xffd5a930),
                              ),
                            ),
                          );
                        }),
                  ),
                ),
                const Divider(),
                Container(
                  margin: const EdgeInsets.fromLTRB(20, 5, 20, 20),
                  child: text(
                    'NOTE: Everytime you open this page, new words would be generated so proceed further accordingly. ',
                    textAlign: TextAlign.justify,
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: red(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
