import 'package:collection/collection.dart';
import 'package:cryptoX/KeyGeneration.dart';
import 'package:cryptoX/Scan2Pay.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ConfirmSeed extends StatefulWidget {
  String words = '';
  String qr_wrds = '';
  List t12words = [];
  List qr_t12words = [];
  int flag = 0;
  ConfirmSeed(
      {String wrds_qr = '',
      String wordPhrases = '',
      List twlv_words = const [],
      List twlv_wrds_qr = const [],
      int f = 0,
      super.key}) {
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
  @override
  void initState() {
    for (int i = 0; i < 12; i++) {
      input.add(TextEditingController());
    }

    for (int i = 0; i < 12; i++) {
      cndtn.add(0);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const Color rtxtBG = Color(0xfff1b4b4);
    const Color rtxtBrdr = Colors.red;

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
                        margin:
                            const EdgeInsets.only(left: 20, top: 22, right: 3),
                        child: const Text(
                          'STEP 2. ',
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
                                  text: 'Confirm your words that you ',
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
                        'or type them manually without any spaces by clicking on the pill shaped TextField down below 👇.',
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                            fontSize: 10,
                            color: Color(0xffdcc06b),
                            fontFamily: 'Poppins',
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
                                itemCount: widget.t12words.length,
                                itemBuilder: (context, index) {
                                  //index will iterate from 0 to 11
                                  // if (widget.flag == 1) {
                                  //   input[index].text = widget.words!;
                                  // }
                                  return Container(
                                    child: (cndtn[index] == 1 ||
                                            (widget.flag == 1 &&
                                                widget.qr_t12words[index] ==
                                                    widget.t12words[
                                                        index])) //if cndtn which has previously contained 0 as an element
                                        //by calling the setState() cndtn at that index becomes 1
                                        ? Container(
                                            decoration: BoxDecoration(
                                              color: const Color(0xffb4f1b4),
                                              border: Border.all(
                                                  width: .5,
                                                  color: Colors.green),
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(30)),
                                            ),
                                            child: const Icon(
                                              FontAwesomeIcons.check,
                                              color: Colors.green,
                                            ),
                                          )
                                        : TextField(
                                            autocorrect: false,
                                            controller: input[index],
                                            style: const TextStyle(
                                                fontSize: 15,
                                                fontFamily: 'Poppins',
                                                fontWeight: FontWeight.w600,
                                                color: Color(0xff9d5454)),
                                            onChanged: (txt) {
                                              if (txt ==
                                                  widget.t12words[index]) {
                                                // input[index].text = txt;

                                                //if [entered text] equals [12 Worded List at that index] are same
                                                print(
                                                    'At index ${index} Condition is true!');
                                                setState(() {
                                                  //call the setState() which will rebuild again the GridView.builder widget
                                                  cndtn[index] =
                                                      1; //with the new cndtn value at that index as 1 which was previously 0
                                                  count++;
                                                }); //means again the index iterate from start ie. 0 to 11
                                              }
                                            },
                                            textAlign: TextAlign.center,
                                            cursorColor:
                                                const Color(0xff9d5454),
                                            decoration: InputDecoration(
                                              contentPadding:
                                                  const EdgeInsets.fromLTRB(
                                                      6, 0, 6, 0),
                                              focusColor: rtxtBrdr,
                                              labelText: '${index + 1}. ',
                                              labelStyle: const TextStyle(
                                                  wordSpacing: 0,
                                                  color: Color(0xff9d5454)),
                                              enabledBorder:
                                                  const OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(30)),
                                                borderSide: BorderSide(
                                                  color: rtxtBrdr,
                                                  width: .5,
                                                ),
                                              ),
                                              filled: true,
                                              fillColor: rtxtBG,
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                borderSide: const BorderSide(
                                                  color: Color(0xffa43333),
                                                  width: 2,
                                                ),
                                              ),
                                            ),
                                          ),
                                  );
                                })),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(20, 20, 20, 25),
                    child: const Text(
                        'Note: Enter the all the correct words in order to proceed further to generate your wallet keys.',
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                            fontSize: 10,
                            color: Color(0xffd36161),
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600)),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 168),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                            width: 175,
                            height: 50,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                elevation: 5,
                                backgroundColor: const Color(0xff1e1e1e),
                                shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8)),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: const [
                                  Text(
                                    'Import from QR',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Icon(Icons.qr_code_scanner_rounded),
                                ],
                              ),
                              onPressed: () async {
                                final res = await Navigator.push<List>(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Scan2Pay(2)));
                                setState(() {
                                  widget.flag =
                                      1; // flag = 1, Means we fetched the value from generated QR
                                  widget.qr_t12words =
                                      res!; //Using Not symbol [ ! ] after variable means it will not be null.
                                  for (int i = 0; i < 12; i++) {
                                    input[i].text = widget.qr_t12words[i];
                                  }
                                  //For comparing two list basically ----------->
                                  Function deepEq =
                                      const DeepCollectionEquality().equals;
                                  if (deepEq(
                                      widget.qr_t12words, widget.t12words)) {
                                    count = 12;
                                  } else {
                                    count = 0;
                                  }
                                  print(
                                      'RESULT FROM QR PAGE-------------> ${widget.qr_t12words}');
                                });
                              },
                            )),
                        SizedBox(
                            width: 175,
                            height: 50,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                elevation: 5,
                                foregroundColor: Colors.white,
                                backgroundColor: const Color(0xff42a14e),
                                shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8)),
                                ),
                              ),
                              onPressed: count == 12
                                  ? () {
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  KeyGen(widget.words)));
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
                              //         fontFamily: 'Poppins',
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: const [
                                  Text(
                                    'Generate Keys',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Icon(FontAwesomeIcons.key),
                                ],
                              ),
                            )),
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
