import 'package:collection/collection.dart';
import 'package:cryptoX/creation_restoration_pages/key_generation_or_restore.dart';
import 'package:cryptoX/scanner_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import '../app_utilities/theme.dart';
import 'cloud_export_import_private_key.dart';

class ConfirmSeed extends StatefulWidget {
  String? words, wordsFromQR, privateAddress;
  List twelveWords = [];
  List twelveWordsFromQR = [];
  bool wordFetched = false; // from QR
  String?
      page; // create or restore buttons invoked this page to load different contents accordingly

  ConfirmSeed(
      {String? qrWords,
      String? wordPhrases,
      List<String> twelveWordsList = const [],
      List<String> twelveWordsFromQRList = const [],
      required String Page,
      super.key}) {
    page = Page;
    wordsFromQR = qrWords;
    words = wordPhrases;
    twelveWordsFromQR = twelveWordsFromQRList;
    print(' [ LIST ] -> QR_WORDS: $twelveWordsFromQR');
    twelveWords = twelveWordsList;
    print('PREVIOUS PAGE_WORDS: $twelveWords');
  }

  @override
  State<ConfirmSeed> createState() => _ConfirmSeedState();
}

class _ConfirmSeedState extends State<ConfirmSeed> {
  // THIS LIST WILL INITIALLY CONTAINS 12 items of ' 0 ' if 1 is fetched then green tick appeared on textfield
  List<int> flagList = [];

  int count =
      0; // COUNTER VARIABLE TO COUNT TEXT INPUTS IF = 12 means all value entered

  int? count2; //FOR RESTORE PAGE : ie to count all the not emptied text fields

  List<TextEditingController> input = [];

  bool textFieldEnabled = true;

  @override
  void initState() {
    for (int i = 0; i < 12; i++) {
      input.add(
          TextEditingController()); // CREATING ARRAYS OF TEXT EDITING CONTROLLER
    }

    for (int i = 0; i < 12; i++) {
      flagList.add(0); // STORING INITIALLY ALL 0 elements in the FLAG LIST
    }

    // STORING SOME CHARACTER SO NO EXCEPTION OF INDEX OUT OF RANGE WHEN BUILDING IN 12 TEXT FIELDS
    if (widget.twelveWords.isEmpty) {
      widget.twelveWords = [];
      for (int i = 0; i < 12; i++) {
        widget.twelveWords.add('*');
      }
      print(widget.twelveWords);
    }
    if (widget.twelveWordsFromQR.isEmpty) {
      widget.twelveWordsFromQR = [];
      for (int i = 0; i < 12; i++) {
        widget.twelveWordsFromQR.add('');
      }
      print(widget.twelveWordsFromQR);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //

      // backgroundColor: lightGrey(),

      //

      appBar: titledAppBar(
          context: context,
          title: (widget.page == 'create') ? 'Create Wallet' : 'Restore Wallet',
          putLeading: true,
          leadingContent: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(FontAwesomeIcons.angleLeft))),

      //

      bottomNavigationBar: bottomBar(
        context: context,
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
                width: (widget.page == 'create') ? 175 : 80,
                height: 50,
                child: button(
                  color: (MediaQuery.platformBrightnessOf(context) ==
                          Brightness.light)
                      ? primaryColor()
                      : const Color(0xff484848),
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      text((widget.page == 'create') ? 'Import from QR' : 'QR',
                          color: lightTheme(),
                          fontSize: 15,
                          fontWeight: FontWeight.w600),
                      Icon(Icons.qr_code_scanner_rounded, color: lightTheme()),
                    ],
                  ),
                  onPressed: () async {
                    List? res;
                    res = await Navigator.push<List>(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Scan2Pay(
                                scannerMode: (widget.page == 'create')
                                    ? 'scanWords'
                                    : 'scanPrivateKey')));
                    if (res == null) {
                      //IF res = null then res = empty list of length 12 so no error of indexing
                      res = [];
                      for (int i = 0; i < 12; i++) {
                        res.add('');
                      }
                    }

                    setState(() {
                      print(
                          'RES--------------------------> $res, Length ----------> ${res!.length}');
                      if (res.length == 1) {
                        // if length one then it is private key
                        widget.privateAddress = res[0];
                        for (int i = 0; i < 12; i++) {
                          input[i].text = '';
                        }
                        if (widget.privateAddress != null) {
                          textFieldEnabled = false;
                        }
                        print(
                            'privAddrrrrrrrrrrrrrrr --------------------------> ${widget.privateAddress}');
                      }

                      widget.wordFetched =
                          true; // Means we fetched the words or private Key from generated QR

                      if (res.length == 12) {
                        widget.twelveWordsFromQR = res;
                        for (int i = 0; i < 12; i++) {
                          input[i].text = widget.twelveWordsFromQR[i];
                          if (widget.privateAddress != null ||
                              input[i].text != '') {
                            ++count;
                            textFieldEnabled = false;
                          }
                        }
                        //For comparing two list basically ----------->
                        Function deepEq = const DeepCollectionEquality().equals;
                        if (deepEq(
                            widget.twelveWordsFromQR, widget.twelveWords)) {
                          count = 12;
                        }
                        print(
                            'RESULT FROM QR PAGE-------------> ${widget.twelveWordsFromQR}');
                      }
                    });
                  },
                )),
            (widget.page == 'restore')
                ?
                // Cloud Import Button
                SizedBox(
                    width: 105,
                    height: 50,
                    child: button(
                      // color: accentColor(),
                      content: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          text(
                            'Cloud',
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                          Icon(
                            FontAwesomeIcons.cloudArrowUp,
                            color: primaryColor(),
                          ),
                        ],
                      ),
                      onPressed: () async {
                        final result = await Navigator.push<String>(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CloudUpload(
                                      page: 'import_from_db',
                                    )));
                        if (result != null) {
                          setState(() {
                            widget.privateAddress = result;
                          });
                        }
                      },
                    ),
                  )
                : const SizedBox(),
            // GENERATE | OK BUTTON
            SizedBox(
                width: (widget.page == 'create') ? 175 : 80,
                height: 50,
                child: button(
                  onPressed: ((count == 12 || widget.privateAddress != null) ||
                          count2 == 12) //---------------------------
                      ? () {
                          if (widget.page == "create") {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => KeyGen(
                                          seedWords: widget.words,
                                          Page: 'create',
                                        )));
                          } else {
                            if (widget.privateAddress != null) {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => KeyGen(
                                            privateKey: widget.privateAddress,
                                            Page: 'restore',
                                          )));
                            } else {
                              String qrWords = '';
                              for (int i = 0;
                                  i < widget.twelveWordsFromQR.length;
                                  i++) {
                                qrWords +=
                                    widget.twelveWordsFromQR[i].toString();
                                qrWords += ' ';
                              }
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => KeyGen(
                                            seedWords: qrWords.trimRight(),
                                            Page: 'restore',
                                          )));
                            }
                          }
                        }
                      : null,
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      text(
                        (widget.page == 'create') ? 'Generate Keys' : 'OK',
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                      Icon(
                        (widget.page == 'create')
                            ? FontAwesomeIcons.key
                            : FontAwesomeIcons.angleRight,
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),

      //

      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin:
                            const EdgeInsets.only(left: 20, top: 20, right: 3),
                        child: text(
                            (widget.page == 'create') ? 'STEP 2. ' : 'STEP 1. ',
                            fontSize: 15,
                            fontWeight: FontWeight.w600),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width - 100,
                        margin: const EdgeInsets.fromLTRB(0, 20, 20, 20),
                        child: RichText(
                          textAlign: TextAlign.justify,
                          text: TextSpan(
                              style: const TextStyle(
                                  color: Color(0xff212121),
                                  fontFamily: 'Space',
                                  fontWeight: FontWeight.w600),
                              children: [
                                TextSpan(
                                  text: 'Type to confirm your words that you ',
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .inverseSurface),
                                ),
                                TextSpan(
                                  text: 'remembered',
                                  style: TextStyle(fontSize: 15, color: red()),
                                ),
                                TextSpan(
                                  text: ' earlier.',
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .inverseSurface),
                                ),
                              ]),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(20, 0, 20, 30),
                    child: text(
                      'Tip: Import the words from generated QR to simplify the process '
                      'or type them manually without any spaces by clicking on these TextField down below 👇.',
                      textAlign: TextAlign.justify,
                      fontWeight: FontWeight.w600,
                      color: accentColor(),
                      fontSize: 10,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 18, right: 18),
                    child: SizedBox(
                      height: 267,
                      child: Padding(
                          padding: const EdgeInsets.all(0),
                          child: // THIS GRID VIEW SOMETIMES CREATE INDEX RANGE EXCEPTION IDK HOW TO SOLVE IT BUT STILL TRYING!
                              GridView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  gridDelegate:
                                      const SliverGridDelegateWithMaxCrossAxisExtent(
                                    maxCrossAxisExtent: 159,
                                    mainAxisSpacing: 25,
                                    crossAxisSpacing: 19,
                                    mainAxisExtent: 45,
                                  ),
                                  itemCount: 12,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      child: (flagList[index] == 1 ||
                                              widget.privateAddress != null ||
                                              (widget.wordFetched == true &&
                                                  widget.twelveWordsFromQR[
                                                          index] ==
                                                      widget
                                                          .twelveWords[index]))
                                          //if flagList which has previously contained 0 as an element
                                          //by calling the setState() flagList at that index becomes 1
                                          ? Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                color: (MediaQuery.of(context)
                                                            .platformBrightness ==
                                                        Brightness.light)
                                                    ? Colors.white
                                                    : Colors.black26,
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: (MediaQuery.of(
                                                                    context)
                                                                .platformBrightness ==
                                                            Brightness.light)
                                                        ? const Color(
                                                            0xffe8e8e8)
                                                        : Colors.transparent,
                                                    blurRadius: 40,
                                                  )
                                                ],
                                              ),
                                              child: Lottie.asset(
                                                  'assets/anim/Verified.json',
                                                  repeat: false,
                                                  frameRate: FrameRate.max))
                                          : Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: (MediaQuery.of(
                                                                    context)
                                                                .platformBrightness ==
                                                            Brightness.light)
                                                        ? const Color(
                                                            0xffe8e8e8)
                                                        : Colors.transparent,
                                                    blurRadius: 40,
                                                  )
                                                ],
                                              ),
                                              child: TextField(
                                                enabled: textFieldEnabled,
                                                autocorrect: false,
                                                textInputAction:
                                                    TextInputAction.next,
                                                controller: input[index],
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  fontFamily: 'Space',
                                                  fontWeight: FontWeight.w600,
                                                  color:
                                                      (widget.page == 'create')
                                                          ? red()
                                                          : accentColor(),
                                                ),
                                                onChanged: (txt) {
                                                  if (txt ==
                                                      widget
                                                          .twelveWords[index]) {
                                                    // input[index].text = txt;
                                                    //if [entered text] equals [12 Worded List at that index] are same
                                                    print(
                                                        'At index $index Condition is true!');
                                                    setState(() {
                                                      //call the setState() which will rebuild again the GridView.builder widget
                                                      flagList[index] = 1;
                                                      //with the new flagList value at that index as 1 which was previously 0
                                                      count++;
                                                    }); //means again the index iterate from start ie. 0 to 11
                                                  }
                                                },
                                                onSubmitted: (txt) {
                                                  if (widget.page ==
                                                      'restore') {
                                                    count2 = 0;
                                                    for (int i = 0;
                                                        i < 12;
                                                        i++) {
                                                      if (input[i].text != '') {
                                                        count2 = count2! + 1;
                                                      }
                                                    }
                                                  }
                                                },
                                                textAlign: TextAlign.center,
                                                cursorColor: accentColor(),
                                                decoration: InputDecoration(
                                                  contentPadding:
                                                      const EdgeInsets.fromLTRB(
                                                          6, 0, 6, 0),
                                                  labelText: '${index + 1}. ',
                                                  labelStyle: TextStyle(
                                                    wordSpacing: 0,
                                                    color: accentColor(),
                                                  ),
                                                  disabledBorder:
                                                      const OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(8)),
                                                    borderSide: BorderSide.none,
                                                  ),
                                                  enabledBorder:
                                                      const OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(8)),
                                                    borderSide: BorderSide.none,
                                                  ),
                                                  filled: true,
                                                  fillColor: (MediaQuery.of(
                                                                  context)
                                                              .platformBrightness ==
                                                          Brightness.light)
                                                      ? Colors.white
                                                      : const Color(0xff484848),
                                                  // DARK THEME
                                                  // fillColor: lightTheme(), // LIGHT THEME
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                    borderSide: BorderSide(
                                                      color: accentColor(),
                                                      width: 2,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                    );
                                  })),
                    ),
                  ),
                  (widget.page == 'create')
                      ? Container(
                          margin: const EdgeInsets.fromLTRB(20, 20, 20, 25),
                          child: text(
                              'Note: Enter all the correct words in order to proceed further to generate your wallet keys.',
                              textAlign: TextAlign.justify,
                              fontSize: 10,
                              color: red(),
                              fontWeight: FontWeight.w600),
                        )
                      : const SizedBox(),
                  (widget.privateAddress != null)
                      ? Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(top: 30),
                            ),
                            const Divider(),
                            shadowBox(
                              context: context,
                              margin: const EdgeInsets.only(
                                  top: 30, left: 20, right: 20, bottom: 10),
                              padding: const EdgeInsets.all(10),
                              content: Container(
                                color: Theme.of(context).cardColor,
                                height: 80,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    const Center(
                                      child: Text(
                                        "Private Key Fetched",
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontFamily: 'Space',
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                    const Divider(),
                                    Center(
                                      child: text(widget.privateAddress!,
                                          textAlign: TextAlign.center,
                                          fontSize: 15,
                                          color: red()),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.fromLTRB(20, 20, 20, 25),
                              child: text(
                                  'Press OK button to restore the wallet.',
                                  textAlign: TextAlign.justify,
                                  fontSize: 10,
                                  color: complementColor(),
                                  fontWeight: FontWeight.w600),
                            )
                          ],
                        )
                      : const SizedBox(),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
