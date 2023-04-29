import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import '../my_dashboard_page.dart';
import '../creation_restoration_pages/generate_seed_words.dart';
import '../app_theme/theme.dart';
import '../creation_restoration_pages/confirm_or_restore.dart';

// FETCHING CRX AMOUNT BALANCE FROM ETHEREUM NETWORK
double crxBalance = 100.00;

// ============================= FIRST PAGE ======================================|

class FirstPage extends StatefulWidget {
  bool isWalletCreated = false;
  String? myPublicAddress;
  PageController? pageNavigationController;

  FirstPage(
      {required bool isCreated,
      required String publicAddress,
      PageController? pageController,
      super.key}) {
    isWalletCreated = isCreated;
    myPublicAddress = publicAddress;
    pageNavigationController = pageController;
  }

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 50),
          child: SizedBox(
              // height: 920,
              child: Column(
            children: [
              Balance(widget.isWalletCreated, widget.myPublicAddress),
              // ADD CONDITION TO SHOW THIS BELOW WIDGET WHEN TRANSACTION HISTORY LIST ITEMS > 0
              RecentTransaction(widget.pageNavigationController!),
              // ADD ASSET SECTION WHICH SHOWS 10 POPULAR ASSETS PRICES
            ],
          )),
        ));
  }
}

// ==========================================================================|

// ----------------------CONTAINERS ------------------------

// ==>

//----------------------- BALANCE -----------------------------=>

class Balance extends StatefulWidget {
  bool walletCreatedFlag = false;
  String? pubAddrs;

  Balance(bool f, String? addr, {super.key}) {
    walletCreatedFlag = f;
    pubAddrs = addr;
  }

  @override
  State<Balance> createState() => _BalanceState();
}

class _BalanceState extends State<Balance> {
  @override
  build(context) {
    return SizedBox(
      child: (widget.walletCreatedFlag == true)
          // IF WALLET CREATED THEN SHOWING AMOUNT
          ? SingleChildScrollView(
              clipBehavior: Clip.none,
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              child: Container(
                margin: const EdgeInsets.only(top: 30, bottom: 30),
                height: 230,
                child: Stack(
                  // USED FOR DISPLAYING CUSTOM BACK SHADOW AND THE BALANCE CARD
                  children: [
                    // BACK SHADOW
                    Positioned(
                      left: 37.5,
                      child: Container(
                        width: 275,
                        height: 220,
                        decoration: const BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: Color(0xffc2c2c2),
                                offset: Offset(0, 20),
                                blurRadius: 20,
                                spreadRadius: 0),
                          ],
                        ),
                      ),
                    ),
                    // CONTAINER THAT SHOWS AMOUNT [ PLACED ABOVE THE BACK SHADOW ]
                    Container(
                      width: 350,
                      height: 220,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [const Color(0xff1f1f1f), primaryColor()],
                            begin: const Alignment(0.5, 0.0),
                            end: const Alignment(0.5, 1.0),
                          ),
                          borderRadius: round_16()),
                      child: Stack(
                        children: [
                          Positioned(
                            top: 15,
                            right: 0,
                            child: // LOTTIE ANIMATION PACKAGE FOR IMPORTING CUSTOM .JSON FILE ANIMATION
                                Lottie.asset(
                              'assets/anim/ethereum.json',
                              width: 150,
                            ),
                          ),
                          Positioned(
                            top: 0,
                            left: 5,
                            child: Padding(
                              padding: const EdgeInsets.all(25.0),
                              child: text(
                                'Available balance',
                                color: const Color(0xe6d5d5d5),
                                fontSize: 14,
                              ),
                            ),
                          ),
                          Positioned(
                            top: 50,
                            left: 30,
                            child: Text(
                              '₹ ${crxBalance * 100}',
                              style: const TextStyle(
                                  fontFamily: 'Space',
                                  fontSize: 35,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white),
                            ),
                          ),
                          Positioned(
                            top: 115,
                            left: 30,
                            child: text(
                              'CRX Coins',
                              color: const Color(0xe6d5d5d5),
                              fontSize: 14,
                            ),
                          ),
                          Positioned(
                            bottom: 58,
                            left: 25,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 25,
                                  child: Image.asset(
                                    'assets/images/ethereum-logo.png',
                                  ),
                                ),
                                text(
                                  crxBalance.toString(),
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                )
                              ],
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            child: InkWell(
                              onTap: () async {
                                Clipboard.setData(
                                        ClipboardData(text: widget.pubAddrs))
                                    .then((_) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    showCloseIcon: true,
                                    backgroundColor: Colors.green.shade700,
                                    behavior: SnackBarBehavior.floating,
                                    content: text(
                                      'Copied to clipboard!',
                                      color: Colors.white,
                                      fontSize: 14,
                                    ),
                                  ));
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                decoration: const BoxDecoration(
                                  // color: Color(0xff252525),
                                  color: Color(0xfffadd8f),
                                  // color: primaryColor(),
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(16),
                                      bottomRight: Radius.circular(16)),
                                ),
                                width: 350,
                                child: Text(
                                  '0x${widget.pubAddrs.toString().substring(2).toUpperCase()}',
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    letterSpacing: 5,
                                    fontFamily: 'Space',
                                    fontWeight: FontWeight.w700,
                                    fontSize: 18,
                                    color: Color(0xff1f1f1f),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ))
          : // OTHERWISE DISPLAY CONTAINER THAT INCLUDES CREATE / RESTORE BUTTON
          SingleChildScrollView(
              clipBehavior: Clip.none,
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              child: Container(
                height: 200,
                margin: const EdgeInsets.only(top: 30, bottom: 30),
                child: Stack(
                  children: [
                    // BACK SHADOW
                    Positioned(
                      left: 37.5,
                      child: Container(
                        width: 275,
                        height: 190,
                        decoration: const BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: Color(0xffc2c2c2),
                                offset: Offset(0, 20),
                                blurRadius: 20,
                                spreadRadius: 0),
                          ],
                        ),
                      ),
                    ),
                    // CREATE / RESTORE CONTAINER ABOVE SHADOW
                    Positioned(
                      child: Container(
                        width: 350,
                        height: 190,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [
                              Color(0xffEECB6B),
                              Color(0xffD7AD38),
                            ],
                            begin: Alignment(0.5, 0.0),
                            end: Alignment(0.5, 1.0),
                          ),
                          borderRadius: round_16(),
                        ),
                        child: Stack(
                          children: [
                            Positioned(
                              top: -25,
                              right: -5,
                              child: Lottie.asset(
                                'assets/anim/no-wallet.json',
                                width: 210,
                              ),
                            ),
                            Positioned(
                              top: 12,
                              left: 0,
                              right: 0,
                              child: text('No Wallet Found!',
                                  color: primaryColor(),
                                  fontSize: 14,
                                  textAlign: TextAlign.center,
                                  fontWeight: FontWeight.w400),
                            ),
                            Positioned(
                              top: 45,
                              left: 40,
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const GenerateSeedPhrases()));
                                },
                                style: ElevatedButton.styleFrom(
                                    padding: EdgeInsets.zero,
                                    backgroundColor: const Color(0xe6ffffff),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    )),
                                child: SizedBox(
                                  width: 120,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Icon(
                                        FontAwesomeIcons.circlePlus,
                                        color: primaryColor(),
                                        size: 18,
                                      ),
                                      Text(
                                        'Create',
                                        style: TextStyle(
                                          fontFamily: 'Space',
                                          fontWeight: FontWeight.w600,
                                          fontSize: 18,
                                          color: primaryColor(),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 45,
                              left: 40,
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ConfirmSeed(
                                                Page: 'restore',
                                              )));
                                },
                                style: ElevatedButton.styleFrom(
                                    padding: EdgeInsets.zero,
                                    backgroundColor: const Color(0xe60fb022),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    )),
                                child: SizedBox(
                                  width: 120,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: const [
                                      Icon(
                                        FontAwesomeIcons.download,
                                        // color: Colors.white70,
                                        color: Color(0xe6ffffff),
                                        //previous color
                                        // color: Color(0xff699bcb),
                                        size: 18,
                                      ),
                                      Text(
                                        'Restore',
                                        style: TextStyle(
                                          fontFamily: 'Space',
                                          fontWeight: FontWeight.w600,
                                          fontSize: 18,
                                          color: Color(0xe6ffffff),
                                          //Previous
                                          // color: Color(0xff699bcb)
                                          //red
                                          // color: Colors.white70
                                          // color: Color(0xffd74444)
                                          // color: Color(0xff0f87a2),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}

// ------------------------------------------------------------=>

// ==>

//----------------------- RECENT TRANSACTION -----------------------=>

class RecentTransaction extends StatefulWidget {
  PageController? pageController;

  RecentTransaction(PageController pc, {super.key}) {
    pageController = pc;
  }

  @override
  State<RecentTransaction> createState() => _RecentTransactionState();
}

class _RecentTransactionState extends State<RecentTransaction> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // CONTAINER FOR TEXTs : 'RECENT TRANSACTION' and 'View all'
        Container(
          width: double.infinity,
          margin: const EdgeInsets.only(left: 25, right: 25),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              text(
                'Recent Transaction',
                color: primaryColor(),
                fontWeight: FontWeight.w900,
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    widget.pageController!.animateToPage(2,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.ease);
                  });
                },
                child: text(
                  'View all',
                  color: accentColor(),
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),

        // LISTS OF CONTAINERS DISPLAYING RECENT TRANSACTION
        Container(
          margin: const EdgeInsets.only(left: 25.0, right: 25.0),
          child: ListView.builder(
            padding: const EdgeInsets.only(top: 15.0, bottom: 0),
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return shadowBox(
                margin: const EdgeInsets.only(top: 10, bottom: 10),
                padding: const EdgeInsets.fromLTRB(0, 12, 0, 13),
                // CONTAINS PEOPLE NAME, TIME, PAYMENT RECEIVED / SENT TRANSACTION AMOUNT
                content: ListTile(
                  // OPEN PAYMENT DESCRIPTION
                  onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text(
                              'Payment Page is Opening for ${names[index]}'))),

                  // USER PROFILE PHOTO
                  leading: circularProfile(),
                  // USER NAME
                  title: text(
                    names[index],
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                  // TIME , PAYMENT RECEIVED / SENT
                  subtitle: text(
                    '12:00 AM - Payment Received',
                    color: complementColor(),
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                  trailing: FittedBox(
                    fit: BoxFit.contain,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Icon(
                          FontAwesomeIcons.plus,
                          color: Color(0xe60fb022),
                          size: 12,
                        ),
                        text(
                          ' ₹ 100',
                          fontWeight: FontWeight.w600,
                          color: Color(0xe60fb022),
                          fontSize: 15,
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
            itemCount: 3,
          ),
        ),
      ],
    );
  }
}

// -----------------------------------------------------------------=>
