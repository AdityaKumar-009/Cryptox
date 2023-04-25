import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';

import '../my_dashboard_page.dart';
import '../WalletCreation.dart';
import '../apptheme/theme.dart';
import '../confirmSeed.dart';

// ============================= FIRST PAGE ======================================|

class FirstPage extends StatefulWidget {
  bool flag = false;
  String? MyAddress;

  FirstPage(bool f, String? addr, {super.key}) {
    flag = f;
    MyAddress = addr;
  }
  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.white,
      child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Container(
              height: 920,
              child: Column(
                children: [
                  Balance(widget.flag, widget.MyAddress),
                  const RecentTransaction(),
                ],
              ))),
    );
  }
}

// ==========================================================================|

// ----------------------CONTAINERS ------------------------
//----------------------- BALANCE ----------------------------->
class Balance extends StatefulWidget {
  bool flag = false;
  String? pubAddrs;

  Balance(bool f, String? addr, {super.key}) {
    flag = f;
    pubAddrs = addr;
  }

  @override
  State<Balance> createState() => _BalanceState();
}

class _BalanceState extends State<Balance> {
  @override
  build(context) {
    return SizedBox(
      child: (widget.flag == true)
          ? SingleChildScrollView(
              clipBehavior: Clip.none,
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              child: Container(
                margin: const EdgeInsets.only(top: 30, bottom: 30),
                height: 230,
                child: Stack(
                  children: [
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
                    Container(
                      width: 350,
                      height: 220,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            // Color(0xffa8edea),
                            // Color(0xfed6e3ff),
                            // const Color(0xff0031c0),
                            // accentColor(),
                            const Color(0xff1f1f1f),
                            primaryColor()
                          ],
                          begin: const Alignment(0.5, 0.0),
                          end: const Alignment(0.5, 1.0),
                        ),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(16)),
                        // border: Border.all(
                        //   color: const Color(0xff093aa2),
                        //   width: 1,
                        // ),
                      ),
                      child: Stack(
                        clipBehavior: Clip.hardEdge,
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Positioned(
                            // top: 16,
                            top: 15,
                            // right: -50,
                            right: 0,
                            child: Lottie.asset(
                              'assets/anim/ethereum.json',
                              // 'assets/anim/no-wallet.json',
                              // 'https://assets1.lottiefiles.com/packages/lf20_ZzPRr9.json',
                              // width: 300,
                              width: 150,
                            ),
                          ),
                          const Positioned(
                            top: 0,
                            left: 5,
                            child: Padding(
                              padding: EdgeInsets.all(25.0),
                              child: Text(
                                'Total Balance',
                                style: TextStyle(
                                  fontFamily: 'Space',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  color: Color(0xe6d5d5d5),
                                  // color: Color(0xffd74444),
                                ),
                              ),
                            ),
                          ),
                          const Positioned(
                            top: 50,
                            left: 30,
                            child: Text(
                              '₹ 10,000',
                              style: TextStyle(
                                  fontFamily: 'Space',
                                  fontSize: 35,
                                  fontWeight: FontWeight.w900,
                                  // color: Color.fromRGBO(248, 98, 66, 1.0),
                                  color: Colors.white
                                  // color: accentColor(),
                                  ),
                            ),
                          ),
                          const Positioned(
                            top: 115,
                            left: 30,
                            child: Text(
                              'CRX Coins',
                              style: TextStyle(
                                fontFamily: 'Space',
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: Color(0xe6d5d5d5),
                                // color: Color(0xff000000),
                              ),
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
                                const Text(
                                  '100',
                                  style: TextStyle(
                                      fontFamily: 'Space',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15,
                                      color: Colors.white
                                      // color: Colors.orangeAccent,
                                      ),
                                ),
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
                                    content: const Text(
                                      'Copied to your clipboard !',
                                      style: TextStyle(fontFamily: 'Space'),
                                    ),
                                  ));
                                });
                                // copied successfully
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
                                    fontWeight: FontWeight.w900,
                                    fontSize: 18,
                                    // color: complementColor()
                                    // color: primaryColor()
                                    color: Color(0xff1f1f1f),

                                    // color: Colors.white70
                                    // color: Colors.orangeAccent,
                                  ),
                                ),
                              ),
                            ),
                            // child: ElevatedButton(
                            //   onPressed: () {
                            //     Navigator.push(
                            //         context,
                            //         MaterialPageRoute(
                            //             builder: (context) =>
                            //                 const WalletCreation()));
                            //   },
                            //   style: ElevatedButton.styleFrom(
                            //       padding: EdgeInsets.zero,
                            //       backgroundColor: const Color(0xe60fb022),
                            //       shape: RoundedRectangleBorder(
                            //         borderRadius: BorderRadius.circular(20),
                            //       )),
                            //   child: SizedBox(
                            //     width: 120,
                            //     child: Row(
                            //       mainAxisAlignment:
                            //           MainAxisAlignment.spaceEvenly,
                            //       children: const [
                            //         Icon(
                            //           FontAwesomeIcons.download,
                            //           // color: Colors.white70,
                            //           color: Color(0xe6ffffff),
                            //           //previous color
                            //           // color: Color(0xff699bcb),
                            //           size: 18,
                            //         ),
                            //         Text(
                            //           'Restore',
                            //           style: TextStyle(
                            //             fontFamily: 'Space',
                            //             fontWeight: FontWeight.w600,
                            //             fontSize: 18,
                            //             color: Color(0xe6ffffff),
                            //             //Previous
                            //             // color: Color(0xff699bcb)
                            //             //red
                            //             // color: Colors.white70
                            //             // color: Color(0xffd74444)
                            //             // color: Color(0xff0f87a2),
                            //           ),
                            //         ),
                            //       ],
                            //     ),
                            //   ),
                            // ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ))
          : SingleChildScrollView(
              clipBehavior: Clip.none,
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              child: Container(
                height: 200,
                margin: const EdgeInsets.only(top: 30, bottom: 30),
                child: Stack(
                  children: [
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
                    Positioned(
                      child: Container(
                        width: 350,
                        height: 190,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              // Color(0xffa8edea),
                              // Color(0xfed6e3ff),
                              // const Color(0xff0031c0),
                              // primaryColor(),
                              // const Color(0xff0e0e0e)
                              Color(0xffEECB6B),
                              Color(0xffD7AD38),
                            ],
                            begin: Alignment(0.5, 0.0),
                            end: Alignment(0.5, 1.0),
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                          // border: Border.all(
                          //   color: const Color(0xff093aa2),
                          //   width: 1,
                          // ),
                        ),
                        child: Stack(
                          // mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Positioned(
                              // top: 16,
                              top: -15,
                              // right: -50,
                              right: -5,
                              child: Lottie.asset(
                                'assets/anim/no-wallet.json',
                                // 'https://assets1.lottiefiles.com/packages/lf20_ZzPRr9.json',
                                // width: 300,
                                width: 210,
                              ),
                            ),
                            Positioned(
                              top: -10,
                              left: 100,
                              child: Padding(
                                padding: const EdgeInsets.all(25.0),
                                child: Text(
                                  'No wallet found!',
                                  style: TextStyle(
                                    fontFamily: 'Space',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                    color: primaryColor(),
                                    // color: Color(0xccd5d5d5),
                                    // color: Color(0xffd74444),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 50,
                              left: 40,
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const WalletCreation()));
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
                                        // color: Colors.white70,
                                        color: primaryColor(),
                                        //previous color
                                        // color: Color(0xff699bcb),
                                        size: 18,
                                      ),
                                      Text(
                                        'Create',
                                        style: TextStyle(
                                          fontFamily: 'Space',
                                          fontWeight: FontWeight.w600,
                                          fontSize: 18,
                                          color: primaryColor(),
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
                            Positioned(
                              bottom: 30,
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

// -------------------------------------------------------------
//----------------------- RECENT TRANSACTION ------------------>
class RecentTransaction extends StatefulWidget {
  const RecentTransaction({super.key});

  @override
  State<RecentTransaction> createState() => _RecentTransactionState();
}

class _RecentTransactionState extends State<RecentTransaction> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          margin: const EdgeInsets.only(left: 25, right: 25),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Recent Transaction',
                style: TextStyle(
                    color: primaryColor(),
                    fontFamily: 'Space',
                    fontSize: 20,
                    fontWeight: FontWeight.w900),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    pageController.animateToPage(2,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.ease);
                  });
                },
                child: Text(
                  'View all',
                  style: TextStyle(
                      // color: complementColor(),
                      color: accentColor(),
                      fontFamily: 'Space',
                      fontSize: 15,
                      fontWeight: FontWeight.w900),
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 25.0, right: 25.0),
          // height: 300,

          // width: 350,
          // decoration: BoxDecoration(
          //   borderRadius: const BorderRadius.all(Radius.circular(8)),
          //   border: Border.all(
          //     color: const Color(0xffe0c2a4),
          //     width: .5,
          //   ),
          //   //color: Colors.white
          //   // color: const Color(0xfff8e0bf),
          //   // border: ,
          // ),
          child: ListView.builder(
            padding: const EdgeInsets.only(top: 15.0, bottom: 0),
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.only(top: 10, bottom: 10),
                padding: const EdgeInsets.fromLTRB(0, 12, 0, 13),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0xffe1e1e1),
                      blurRadius: 40,
                      // spreadRadius: 5
                    )
                  ],
                ),
                child: ListTile(
                  onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text(
                              'Payment Page is Opening for ${names[index]}'))),
                  leading: CircleAvatar(
                    radius: 28,
                    backgroundColor: Colors.grey.shade200,
                    // backgroundImage: AssetImage('assets/images/Adit.jpg'),
                  ),
                  title: Text(
                    names[index],
                    style: TextStyle(
                        color: primaryColor(),
                        fontFamily: 'Space',
                        fontSize: 15,
                        fontWeight: FontWeight.w900),
                  ),
                  subtitle: Text(
                    '12:00 AM - Payment Recieved',
                    style: TextStyle(
                        color: complementColor(),
                        fontFamily: 'Space',
                        fontSize: 11,
                        fontWeight: FontWeight.w900),
                  ),
                  trailing: FittedBox(
                    fit: BoxFit.contain,
                    // width: 80,
                    // height: 50,
                    // color: Colors.blue,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: const [
                        Icon(
                          FontAwesomeIcons.plus,
                          color: Color(0xe60fb022),
                          size: 12,
                        ),
                        Text(
                          ' ₹ 100',
                          style: TextStyle(
                              fontSize: 15,
                              color: Color(0xe60fb022),
                              fontFamily: 'Space',
                              fontWeight: FontWeight.w900),
                        )
                      ],
                    ),
                  ),
                  // onTap: () => setState(() {
                  //   //usr_name = names[index];
                  // }),
                  // child: Column(
                  //   crossAxisAlignment: CrossAxisAlignment.center,
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     const SizedBox(
                  //       height: 50,
                  //       width: 50,
                  //       // child: Image.asset(
                  //       //     'assets/images/user_icon_5.png')
                  //       child: CircleAvatar(
                  //         backgroundColor: Color(0xffe7cebc),
                  //         // backgroundImage: AssetImage('assets/images/Adit.jpg'),
                  //       ),
                  //     ),
                  //     Padding(
                  //       padding: const EdgeInsets.all(8.0),
                  //       child: Text(
                  //         names[index],
                  //         style: const TextStyle(
                  //             fontSize: 12,
                  //             color: Colors.black54,
                  //             // backgroundColor: Colors.yellow,
                  //             fontWeight: FontWeight.w700),
                  //       ),
                  //     )
                  //   ],
                  // ),
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
// ----------------------------------------------------------------
