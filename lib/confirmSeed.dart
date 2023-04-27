import 'package:collection/collection.dart';
import 'package:cryptoX/KeyGeneration.dart';
import 'package:cryptoX/Scan2Pay.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'apptheme/theme.dart';
import 'cloudkeyupload.dart';

class ConfirmSeed extends StatefulWidget {
  String words = '';
  String qr_wrds = '';
  List t12words = [];
  List qr_t12words = [];
  int flag = 0;
  String page = '';
  String? privAddress;

  ConfirmSeed(
      {String wrds_qr = '',
      String wordPhrases = '',
      List<String> twlv_words = const [],
      List<String> twlv_wrds_qr = const [],
      int f = 0,
      String Page = 'create',
      super.key}) {
    page = Page;
    flag = f;
    qr_wrds = wrds_qr;
    words = wordPhrases;
    // print(words);
    qr_t12words = twlv_wrds_qr;
    print('QR_WORDS: $qr_t12words');
    t12words = twlv_words;
    print('PREVIOUS PAGE_WORDS: $t12words');
  }

  @override
  State<ConfirmSeed> createState() => _ConfirmSeedState();
}

class _ConfirmSeedState extends State<ConfirmSeed> {
  List<int> cndtn = [];
  int count = 0;
  List<TextEditingController> input = [];

  Color txtColor = Colors.blueGrey;

  bool enbld = true;

  @override
  void initState() {
    for (int i = 0; i < 12; i++) {
      input.add(TextEditingController());
    }

    for (int i = 0; i < 12; i++) {
      cndtn.add(0);
    }

    if (widget.t12words.isEmpty) {
      widget.t12words = [];
      for (int i = 0; i < 12; i++) {
        widget.t12words.add('*');
      }
      print(widget.t12words);
    }
    if (widget.qr_t12words.isEmpty) {
      widget.qr_t12words = [];
      for (int i = 0; i < 12; i++) {
        widget.qr_t12words.add('');
      }
      print(widget.qr_t12words);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const Color rtxtBG = Color(0xfff1b4b4);
    return Scaffold(
      // body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      //   Text('SEED PHRASES: ${generatedWords}'),
      //   Text('PrivateKey: ${privAddress}'),
      // ]),
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(FontAwesomeIcons.angleLeft)),
        foregroundColor: Colors.black,
        title:
            Text((widget.page == 'create') ? 'Create Wallet' : 'Restore Wallet',
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
      //
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        child: SizedBox(
          height: 80,
          // margin: const EdgeInsets.only(top: 168),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                  width: (widget.page == 'create') ? 175 : 80,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: primaryColor(),
                      // backgroundColor: const Color(0xff1e1e1e),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          (widget.page == 'create') ? 'Import from QR' : 'QR',
                          style: const TextStyle(
                              fontSize: 15,
                              fontFamily: 'Space',
                              fontWeight: FontWeight.w600),
                        ),
                        const Icon(Icons.qr_code_scanner_rounded),
                      ],
                    ),
                    onPressed: () async {
                      List? res;
                      res = await Navigator.push<List>(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  Scan2Pay((widget.page == 'create') ? 2 : 3)));
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => Scan2Pay(2)));
                      setState(() {
                        print(
                            'RES--------------------------> $res, Length ----------> ${res!.length}');
                        if (res!.length == 1) {
                          setState(() {
                            widget.privAddress = res![0];
                          });
                          print(
                              'privAddrrrrrrrrrrrrrrr --------------------------> ${widget.privAddress}');
                        }
                        widget.flag =
                            1; // flag = 1, Means we fetched the value from generated QR
                        if (res == null || res!.length == 1) {
                          //IF res = null then res = empty list of length 12 so no error of indexing
                          res = [];
                          for (int i = 0; i < 12; i++) {
                            res!.add('');
                          }
                        }
                        if (res!.length == 12) {
                          widget.qr_t12words =
                              res!; //Using Not symbol [ ! ] after variable means it will not be null.
                          for (int i = 0; i < 12; i++) {
                            input[i].text = widget.qr_t12words[i];
                            if (widget.page == 'restore') {
                              ++count;
                              enbld = false;
                              // txtColor = accentColor();
                            }
                          }
                          //For comparing two list basically ----------->
                          Function deepEq =
                              const DeepCollectionEquality().equals;
                          if (deepEq(widget.qr_t12words, widget.t12words)) {
                            count = 12;
                          }
                          print(
                              'RESULT FROM QR PAGE-------------> ${widget.qr_t12words}');
                        }
                      });
                    },
                  )),
              (widget.page == 'restore')
                  ? SizedBox(
                      width: 105,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          backgroundColor: accentColor(),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Cloud',
                              style: TextStyle(
                                  // color: Color(0xff1e1e1e),
                                  fontSize: 15,
                                  fontFamily: 'Space',
                                  fontWeight: FontWeight.w600),
                            ),
                            Icon(
                              FontAwesomeIcons.cloudArrowUp,
                              // color: Colors.blueAccent,
                              color: primaryColor(),
                            ),
                          ],
                        ),
                        onPressed: () async {
                          // String? privKey;
                          // if (option == 'default') {
                          //   privKey = widget.doEncryption();
                          // } else {
                          //   privKey =
                          //       widget.doEncryption(key: custom_key);
                          // }

                          final result = await Navigator.push<String>(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CloudUpload(
                                        page: 'import_from_db',
                                      )));
                          if (result != null) {
                            setState(() {
                              widget.privAddress = result;
                            });
                          }
                        },
                      ),
                    )
                  : const SizedBox(),
              SizedBox(
                  width: (widget.page == 'create') ? 175 : 80,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      foregroundColor: Colors.white,
                      backgroundColor: accentColor(),
                      // backgroundColor: const Color(0xff42a14e),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                    ),
                    onPressed: ((count == 12 ||
                            widget.privAddress !=
                                null)) //---------------------------
                        ? () {
                            if (widget.page != "restore") {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => KeyGen(
                                            seed: widget.words,
                                          )));
                            } else if (widget.page == "restore") {
                              if (widget.privAddress != null) {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => KeyGen(
                                              privateKey: widget.privAddress!,
                                              Page: 'restore',
                                            )));
                              } else {
                                String qrWords = '';
                                for (int i = 0;
                                    i < widget.qr_t12words.length;
                                    i++) {
                                  qrWords += widget.qr_t12words[i].toString();
                                  qrWords += ' ';
                                }
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => KeyGen(
                                              seed: qrWords.trimRight(),
                                              Page: 'restore',
                                            )));
                              }
                            }
                          }
                        : null
                    // ScaffoldMessenger.of(context)
                    //     .showMaterialBanner(MaterialBanner(
                    //   // behavior:
                    //   //     SnackBarBehavior.floating,
                    //   key: super.widget.key,
                    //   backgroundColor: Colors.red.shade700,
                    //   content: const Text(
                    //     'Enter all the words first! ',
                    //     style: TextStyle(
                    //         fontFamily: 'Space',
                    //         fontSize: 18,
                    //         fontWeight: FontWeight.w600,
                    //         color: Color(0xff960000)),
                    //   ),
                    //   actions: [
                    //     TextButton(
                    //         onPressed: () {
                    //           ScaffoldMessenger.
                    //               .clearMaterialBanners();
                    //         },
                    //         child: Text('OK'))
                    //   ],
                    // ));
                    ,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          (widget.page == 'create') ? 'Generate Keys' : 'Ok',
                          style: const TextStyle(
                              fontSize: 15,
                              fontFamily: 'Space',
                              fontWeight: FontWeight.w600),
                        ),
                        Icon((widget.page == 'create')
                            ? FontAwesomeIcons.key
                            : FontAwesomeIcons.angleRight),
                      ],
                    ),
                  )),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          child: SizedBox(
            height: 747,
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(
                              left: 20, top: 22, right: 3),
                          child: Text(
                            (widget.page == 'create') ? 'STEP 2. ' : 'STEP 1. ',
                            style: const TextStyle(
                                color: Color(0xff212121),
                                fontFamily: 'Space',
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
                                    fontFamily: 'Space',
                                    fontWeight: FontWeight.w600),
                                children: [
                                  TextSpan(
                                    text:
                                        'Type to confirm your words that you ',
                                    style: TextStyle(
                                        fontSize: 15, color: Color(0xff212121)),
                                  ),
                                  TextSpan(
                                    text: 'remembered',
                                    style: TextStyle(
                                        // decoration: TextDecoration.underline,
                                        fontSize: 15,
                                        color: Colors.redAccent),
                                  ),
                                  TextSpan(
                                    text: ' earlier.',
                                    style: TextStyle(
                                        fontSize: 15, color: Color(0xff212121)),
                                  ),
                                ]),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(20, 0, 20, 30),
                      child: const Text(
                          'Tip: Import the words from generated QR to simplify the process '
                          'or type them manually without any spaces by clicking on these TextField down below 👇.',
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                              fontSize: 10,
                              color: Color(0xffdcc06b),
                              fontFamily: 'Space',
                              fontWeight: FontWeight.w600)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 18, right: 18),
                      child: Container(
                        // decoration: BoxDecoration(
                        //     color: const Color(0xffe0ffdc),
                        //     borderRadius: const BorderRadius.all(
                        //         Radius.circular(30)),
                        //     border: Border.all(
                        //       color: Colors.green.shade100,
                        //       width: .5,
                        //     )),
                        // margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                        child: SizedBox(
                          height: 267,
                          child: Padding(
                              padding: const EdgeInsets.all(0),
                              child: GridView.builder(
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
                                    //index will iterate from 0 to 11
                                    // if (widget.flag == 1) {
                                    //   input[index].text = widget.words!;
                                    // }
                                    return Container(
                                      child: (cndtn[index] == 1 ||
                                              (widget.flag == 1 &&
                                                  widget.qr_t12words[index] ==
                                                      widget.t12words[index]))
                                          //if cndtn which has previously contained 0 as an element
                                          //by calling the setState() cndtn at that index becomes 1
                                          ? Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                color: Colors.white,
                                                boxShadow: const [
                                                  BoxShadow(
                                                    color: Color(0xffe8e8e8),
                                                    blurRadius: 40,
                                                    // spreadRadius: 5
                                                  )
                                                ],
                                              ),

                                              // decoration: BoxDecoration(
                                              //         color: const Color(0xffb4f1b4),
                                              //         border: Border.all(
                                              //             width: .5,
                                              //             color: Colors.green),
                                              //         borderRadius:
                                              //             const BorderRadius.all(
                                              //                 Radius.circular(8)),
                                              //       ),
                                              child: const Icon(
                                                FontAwesomeIcons.check,
                                                color: Colors.green,
                                              ),
                                            )
                                          : Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                color: Colors.white,
                                                boxShadow: const [
                                                  BoxShadow(
                                                    color: Color(0xffe8e8e8),
                                                    blurRadius: 40,
                                                    // spreadRadius: 5
                                                  )
                                                ],
                                              ),
                                              child: TextField(
                                                enabled: enbld,
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
                                                          ? Colors.red
                                                          : txtColor,
                                                  // color: Color(0xff9d5454)
                                                ),
                                                onChanged: (txt) {
                                                  if (txt ==
                                                      widget.t12words[index]) {
                                                    // input[index].text = txt;
                                                    //if [entered text] equals [12 Worded List at that index] are same
                                                    print(
                                                        'At index ${index} Condition is true!');
                                                    setState(() {
                                                      //call the setState() which will rebuild again the GridView.builder widget
                                                      cndtn[index] = 1;
                                                      //with the new cndtn value at that index as 1 which was previously 0
                                                      count++;
                                                    }); //means again the index iterate from start ie. 0 to 11
                                                  }
                                                },
                                                onSubmitted: (txt) {
                                                  if (widget.page ==
                                                      'restore') {
                                                    input[index].text = txt;
                                                  }
                                                },
                                                textAlign: TextAlign.center,
                                                // cursorColor: Colors.blueGrey,
                                                cursorColor: (widget.page ==
                                                        'create')
                                                    ? const Color(0xffd5a930)
                                                    : Colors.blueGrey,
                                                // const Color(0xff9d5454),
                                                decoration: InputDecoration(
                                                  contentPadding:
                                                      const EdgeInsets.fromLTRB(
                                                          6, 0, 6, 0),
                                                  // focusColor: rtxtBrdr,
                                                  labelText: '${index + 1}. ',
                                                  labelStyle: TextStyle(
                                                    wordSpacing: 0,
                                                    color: (widget.page ==
                                                            'create')
                                                        ? const Color(
                                                            0xffd5a930)
                                                        : Colors.blueGrey,
                                                    // color: Color(0xffd5a930),
                                                    // color: Colors.blueGrey
                                                    // color: Color(0xff9d5454)
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
                                                  // filled: true,
                                                  // fillColor: rtxtBG,
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                    borderSide: BorderSide(
                                                      // color: Colors.blueGrey,
                                                      color: (widget.page ==
                                                              'create')
                                                          ? const Color(
                                                              0xffd5a930)
                                                          : Colors.blueGrey,
                                                      // color: Color(0xffa43333),
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
                    ),
                    (widget.page == 'create')
                        ? Container(
                            margin: const EdgeInsets.fromLTRB(20, 20, 20, 25),
                            child: const Text(
                                'Note: Enter the all the correct words in order to proceed further to generate your wallet keys.',
                                textAlign: TextAlign.justify,
                                style: TextStyle(
                                    fontSize: 10,
                                    color: Color(0xffd36161),
                                    fontFamily: 'Space',
                                    fontWeight: FontWeight.w600)),
                          )
                        : const SizedBox(),
                    (widget.privAddress != null)
                        // true
                        ? Column(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(top: 30),
                              ),
                              const Divider(),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.white,
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Color(0xffe8e8e8),
                                      blurRadius: 40,
                                      // spreadRadius: 5
                                    )
                                  ],
                                ),
                                margin: const EdgeInsets.only(
                                    top: 30, left: 20, right: 20, bottom: 10),
                                padding: const EdgeInsets.all(10),
                                child: SizedBox(
                                  height: 80,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      const Center(
                                        child: Text(
                                          "Private Address Fetched",
                                          style: TextStyle(
                                              fontSize: 17,
                                              fontFamily: 'Space',
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                      const Divider(),
                                      Center(
                                        child: Text(
                                          widget.privAddress!,
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                              fontSize: 15,
                                              fontFamily: 'Space',
                                              color: Colors.red),
                                        ),
                                      ),
                                      // const Divider(),
                                      // const Center(
                                      //   child: Text(
                                      //     "Go back to home page!",
                                      //     style: TextStyle(
                                      //       color: Colors.grey,
                                      //       fontSize: 18,
                                      //     ),
                                      //   ),
                                      // )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )
                        : const SizedBox(),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
