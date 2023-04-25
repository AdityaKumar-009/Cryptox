import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:cryptoX/WalletCreation.dart';
import 'package:cryptoX/profilepage.dart';
import 'package:flutter/material.dart';
import 'package:cryptoX/Scan2Pay.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'apptheme/theme.dart';
import 'confirmSeed.dart';

List names = [
  'Ayan Basu',
  'Prince Makkar',
  'Vidyanshu',
  'Charchit',
  'Saurabh',
  'Anuj Rane',
  'Rahul'
]; //For Storing all the User's Name

const List<TabItem> items = [
  TabItem(
    icon: FontAwesomeIcons.wallet,
    title: 'Wallet',
  ),
  TabItem(
    icon: FontAwesomeIcons.receipt,
    title: 'History',
  ),
  TabItem(icon: Icons.expand_less_rounded),
  TabItem(
    icon: FontAwesomeIcons.chartLine,
    title: 'Market',
  ),
  TabItem(
    icon: FontAwesomeIcons.addressCard,
    title: 'Profile',
  ),
];

String userName = 'Aditya Kumar'; //For current User Name

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key}) {
    //Used flag for changing states, if flag = 0 means keys are not created.
    //if flag is passed as 1 by another page (ie. KeyGeneration Page) then it shows the account balance info.
  }

  @override
  State<MyHomePage> createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  bool flag = false;
  String? MyAddress;
  static const String IS_CREATED = 'isWalletCreated';
  static const String PUBLICADDRESS = 'PublicKey';
  late final AnimationController _controller = AnimationController(
    animationBehavior: AnimationBehavior.preserve,
    vsync: this,
    duration: const Duration(
      milliseconds: 4500,
    ),
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 500), () {
      _controller.forward();
    });
    isWalletCreated();
    super.initState();
  }

  int visit = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //----------------------------------- APP BAR --------------------------------------
      appBar: AppBar(
        toolbarHeight: 80,
        automaticallyImplyLeading: false,
        // foregroundColor: Color(0xffd6e4ef),
        // foregroundColor: primaryColor(),
        backgroundColor: Colors.white,
        // backgroundColor: Color(0xff1f1f1f),
        elevation: 0,
        // shadowColor: const Color(0x4dffffff),
        title: SizedBox(
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 55, bottom: 35, left: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Welcome,',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 12,
                            fontFamily: 'Space',
                            // color: Color.fromARGB(255, 71, 217, 204),
                            // color: Colors.black,
                            color: complementColor(),
                            fontWeight: FontWeight.w600)),
                    Text(userName,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'Space',
                            color: primaryColor(),
                            // color: Color.fromARGB(255, 71, 217, 204),
                            // color: Colors.black,
                            fontWeight: FontWeight.w900))
                  ],
                ),
              ),
              Container(
                // width: 100,
                margin: const EdgeInsets.only(top: 30, bottom: 15, right: 5),
                child: const Card(
                  shape: CircleBorder(),
                  elevation: 0,
                  // shadowColor: Colors,
                  child: CircleAvatar(
                    backgroundColor: Color.fromARGB(100, 0, 90, 100),
                    // backgroundColor: Colors.transparent,
                    backgroundImage: AssetImage('assets/images/Adit.jpg'),
                    maxRadius: 25,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      //-------------------- FLOATING ACTION BUTTON --------------------------------------
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: SizedBox(
        height: 77,
        width: 77,
        child: FloatingActionButton(
          tooltip: 'Scan to Pay',
          // splashColor: Colors.blue,
          // elevation: 0,
          // backgroundColor: Colors.white,
          backgroundColor: (flag == false)
              ? const Color(0xffc9a408)
              : const Color(0xffEECB6B),
          // backgroundColor: accentColor(),
          onPressed: () {
            int page = 1;
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => Scan2Pay(page),
            ));
          },
          // backgroundColor: Colors.white,
          child: Lottie.asset('assets/anim/qrScanner.json',
              // 'https://assets10.lottiefiles.com/packages/lf20_v3xtulro.json',
              // 'https://assets4.lottiefiles.com/packages/lf20_ncwesvwe.json',
              controller: _controller),
          // Container(
          //   margin: const EdgeInsets.only(top: 15, bottom: 15),
          //   decoration: BoxDecoration(
          //     borderRadius: BorderRadius.circular(15),
          //
          //     // image: const DecorationImage(
          //     //     image: AssetImage('assets/images/QR_scan.png')),
          //     // boxShadow: const [
          //     //   BoxShadow(
          //     //     blurRadius: 30,
          //     //     spreadRadius: 0,
          //     //     color: Colors.blueAccent,
          //     //   )
          //     // ],
          //   ),
          // ),
        ),
      ),
      //----------------------------- BOTTOM NAVIGATION BAR ------------------------------

      bottomNavigationBar: Container(
        height: 85,
        padding: const EdgeInsets.only(bottom: 15, right: 15, left: 15),
        color: Colors.white,
        child: BottomBarCreative(
          // blur: 10,
          highlightStyle: HighlightStyle(
              // background: Color(0xff05131e),
              background: primaryColor(),
              // color: Color(0xff05131e),
              color: primaryColor()),
          // isFloating: true,
          borderRadius: BorderRadius.circular(16),
          items: items,
          // top: 100,
          // paddingVertical: 24,
          // backgroundColor: Colors.transparent,
          // styleIconFooter: StyleIconFooter.dot,
          backgroundColor: primaryColor(),
          // backgroundColor: const Color(0xff05131e),
          color: const Color(0xff6a767c),
          // colorSelected: const Color(0xfff9f9f9),
          colorSelected: (flag == false)
              ? const Color(0xffc9a408)
              : const Color(0xffEECB6B),
          // colorSelected: const Color(0xff1448f1),
          indexSelected: visit,
          onTap: (int index) => setState(() {
            visit = index;
          }),
        ),
      ),
      // bottomNavigationBar: Container(
      //   // color: const Color(0xfff9f9f9),
      //   //DARK
      //   // color: Color(0xff131313),
      //   // color: const Color(0xfff3f3f3),
      //   // color: const Color(0xff05131e),
      //   child: BottomNavigationBar(
      //     enableFeedback: false,
      //     backgroundColor: const Color(0xff05131e),
      //     // height: 80,
      //     //bottom navigation bar on scaffold
      //     // color: Colors.white,
      //     // color: Colors.black,
      //     //Dark
      //     // color: Color(0xff1f1f1f),
      //     // color: const Color(0xff05131e),
      //     // shape: const CircularNotchedRectangle(),
      //     //shape of notch
      //     // notchMargin: 10,
      //     //notch margin between floating button and bottom appbar
      //     items: const [
      //       BottomNavigationBarItem(
      //           icon: Icon(
      //             // FontAwesomeIcons.wallet,
      //             Icons.account_balance_wallet_rounded,
      //             // color: Colors.blue,
      //             color: Color(0xffcdd6ff),
      //             size: 27,
      //           ),
      //           label: 'My Wallet'),
      //       BottomNavigationBarItem(
      //         icon: Icon(
      //           Icons.account_circle_outlined,
      //           // FontAwesomeIcons.addressCard,
      //           color: Color(0xff6f7a81),
      //           size: 30,
      //           // color: Colors.white,
      //         ),
      //         label: 'My Profile',
      //       )
      //     ],
      //     // child: Row(
      //     //   //children inside bottom appbar
      //     //   // mainAxisSize: MainAxisSize.min,
      //     //   // mainAxisAlignment: MainAxisAlignment.spaceAround,
      //     //   children: <Widget>[
      //     //     Expanded(
      //     //       flex: 2,
      //     //       child: Column(
      //     //         children: [
      //     //           IconButton(
      //     //             tooltip: 'My Wallet',
      //     //             icon: const Icon(
      //     //               // FontAwesomeIcons.wallet,
      //     //               Icons.account_balance_wallet_rounded,
      //     //               // color: Colors.blue,
      //     //               color: Color(0xffcdd6ff),
      //     //               size: 27,
      //     //             ),
      //     //             onPressed: () {},
      //     //           ),
      //     //           const Text(
      //     //             'My Wallet',
      //     //             style: TextStyle(
      //     //                 color: Color(0xffcdd6ff),
      //     //                 fontFamily: 'Space',
      //     //                 fontWeight: FontWeight.w600,
      //     //                 fontSize: 12),
      //     //           ),
      //     //         ],
      //     //       ),
      //     //     ),
      //     //     const Expanded(
      //     //         flex: 1,
      //     //         child: SizedBox(
      //     //           width: 10,
      //     //         )),
      //     //     Expanded(
      //     //       flex: 2,
      //     //       child: Column(
      //     //         children: [
      //     //           IconButton(
      //     //             tooltip: 'Profile',
      //     //             icon: const Icon(
      //     //               Icons.account_circle_outlined,
      //     //               // FontAwesomeIcons.addressCard,
      //     //               color: Color(0xff6f7a81),
      //     //               size: 30,
      //     //               // color: Colors.white,
      //     //             ),
      //     //             onPressed: () {
      //     //               Navigator.pushReplacement(
      //     //                   context,
      //     //                   MaterialPageRoute(
      //     //                       builder: (context) => ProfilePage()));
      //     //             },
      //     //           ),
      //     //           const Text(
      //     //             'My Profile',
      //     //             style: TextStyle(
      //     //               fontFamily: 'Space',
      //     //               fontSize: 12,
      //     //               color: Color(0xff6f7a81),
      //     //             ),
      //     //           ),
      //     //         ],
      //     //       ),
      //     //     ),
      //     //   ],
      //     // ),
      //   ),
      // ),
      //---BODY--->
      body: PageView(
        physics: const BouncingScrollPhysics(),
        children: [
          firstPage(flag, MyAddress),
        ],
      ),
    );
    // body: Column(
    //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //     children: const [Text('data'), Text("data"), Text("data")]));
  }

  void isWalletCreated() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    setState(() {
      flag = (sp.getBool(IS_CREATED) != null) ? sp.getBool(IS_CREATED)! : false;
      print("FLAG --------->$flag");
      MyAddress = sp.getString(PUBLICADDRESS);
      print("PUBLIC ADDRESS --------->$MyAddress");
    });
  }
}

// ============================= PAGES ======================================|

class firstPage extends StatefulWidget {
  bool flag = false;
  String? MyAddress;

  firstPage(bool f, String? addr, {super.key}) {
    flag = f;
    MyAddress = addr;
  }
  @override
  State<firstPage> createState() => _firstPageState();
}

class _firstPageState extends State<firstPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Container(
              height: 920,
              color: Colors.white,
              //New Change here---------
              // color: const Color(0xfff9f9f9),
              // color: const Color(0xff101010),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                // mainAxisSize: MainAxisSize.min,
                children: [
                  Balance(widget.flag, widget.MyAddress),
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
                              // color: Colors.white,
                              fontFamily: 'Space',
                              fontSize: 20,
                              fontWeight: FontWeight.w900),
                        ),
                        Text(
                          'View all',
                          style: TextStyle(
                              // color: complementColor(),
                              color: accentColor(),
                              fontFamily: 'Space',
                              fontSize: 15,
                              fontWeight: FontWeight.w900),
                        ),
                      ],
                    ),
                  ),
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
      // margin: const EdgeInsets.only(top: 15, bottom: 25),
      // height: 180,
      // width: 350,
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
          // SizedBox(
          //         height: 400,
          //         child: Container(
          //           child: Column(
          //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //             children: [
          //               SizedBox(
          //                 height: 180,
          //                 // margin: const EdgeInsets.only(top: 0),
          //                 child: Card(
          //                   shape: const RoundedRectangleBorder(
          //                       borderRadius: BorderRadius.all(Radius.circular(8)),
          //                       side: BorderSide(width: 0, color: Color(0xff9aceea)
          //                           // color: Color(0xffffffff),
          //                           )),
          //                   elevation: 0,
          //                   // color: Colors.white,
          //                   color: const Color(0xffd8edf5),
          //                   // shadowColor: const Color.fromRGBO(255, 172, 0, 0.25),
          //                   child: Column(
          //                     mainAxisAlignment: MainAxisAlignment.center,
          //                     children: [
          //                       const Text(
          //                         'Available Balance',
          //                         style: TextStyle(
          //                           fontFamily: 'Space',
          //                           fontWeight: FontWeight.w400,
          //                           fontSize: 20,
          //                           // color: Color(0xff0f87a2),
          //                         ),
          //                       ),
          //                       const Text(
          //                         '₹ 10,000',
          //                         style: TextStyle(
          //                             fontFamily: 'Space',
          //                             fontSize: 35,
          //                             fontWeight: FontWeight.w700,
          //                             // color: Color.fromRGBO(248, 98, 66, 1.0),
          //                             color: Colors.blue),
          //                       ),
          //                       const Text(
          //                         'Wallet (ETH)',
          //                         style: TextStyle(
          //                           fontFamily: 'Space',
          //                           fontWeight: FontWeight.w500,
          //                           fontSize: 14,
          //                           // color: Color(0xff000000),
          //                         ),
          //                       ),
          //                       Row(
          //                         mainAxisAlignment: MainAxisAlignment.center,
          //                         children: [
          //                           SizedBox(
          //                             height: 25,
          //                             child:
          //                                 Image.asset('assets/images/ethereum.png'),
          //                           ),
          //                           const Text(
          //                             '100',
          //                             style: TextStyle(
          //                               fontFamily: 'Space',
          //                               fontWeight: FontWeight.w600,
          //                               fontSize: 20,
          //                               // color: Colors.orangeAccent,
          //                             ),
          //                           ),
          //                         ],
          //                       ),
          //                     ],
          //                   ),
          //                 ),
          //               ),
          //               Container(
          //                 height: 40,
          //                 width: 250,
          //                 decoration: BoxDecoration(
          //                   color: Colors.grey.shade300,
          //                   borderRadius:
          //                       const BorderRadius.all(Radius.circular(30)),
          //                 ),
          //                 child: Padding(
          //                   padding: const EdgeInsets.fromLTRB(15, 10, 10, 10),
          //                   child: Row(
          //                     crossAxisAlignment: CrossAxisAlignment.center,
          //                     children: [
          //                       const Text('My Address: ',
          //                           style: TextStyle(
          //                               fontFamily: 'Space',
          //                               color: Colors.black54,
          //                               fontSize: 14)),
          //                       SizedBox(
          //                           width: 111,
          //                           child: Text(
          //                             widget.pubAddrs!,
          //                             maxLines: 1,
          //                             overflow: TextOverflow.ellipsis,
          //                             style: const TextStyle(
          //                                 fontFamily: 'Space',
          //                                 color: Colors.black54,
          //                                 fontSize: 14),
          //                           )),
          //                       SizedBox(
          //                         width: 25,
          //                         child: IconButton(
          //                             tooltip: 'Click to copy on the clipboard',
          //                             onPressed: () async {
          //                               Clipboard.setData(ClipboardData(
          //                                       text: widget.pubAddrs))
          //                                   .then((_) {
          //                                 ScaffoldMessenger.of(context)
          //                                     .showSnackBar(SnackBar(
          //                                   showCloseIcon: true,
          //                                   backgroundColor: Colors.green.shade700,
          //                                   behavior: SnackBarBehavior.floating,
          //                                   content: const Text(
          //                                     'Copied to your clipboard !',
          //                                     style: TextStyle(fontFamily: 'Space'),
          //                                   ),
          //                                 ));
          //                               });
          //                               // copied successfully
          //                             },
          //                             padding: const EdgeInsets.all(0),
          //                             icon: const Icon(
          //                               // FontAwesomeIcons.clipboard,
          //                               Icons.content_copy_rounded,
          //                               color: Colors.blue,
          //                               size: 18,
          //                             )),
          //                       )
          //                     ],
          //                   ),
          //                 ),
          //               )
          //             ],
          //           ),
          //         ),
          //       )
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
    return Container(
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
              onTap: () => ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content:
                      Text('Payment Page is Opening for ${names[index]}'))),
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
        itemCount: 4,
      ),
    );
  }
}
// ----------------------------------------------------------------
