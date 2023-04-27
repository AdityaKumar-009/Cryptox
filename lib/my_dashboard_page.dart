import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:cryptoX/pages/crypto_market_page.dart';
import 'package:cryptoX/pages/setting_page.dart';
import 'package:cryptoX/pages/transaction_history_page.dart';
import 'package:cryptoX/pages/wallet_homepage.dart';
import 'package:cryptoX/profilepage.dart';
import 'package:flutter/material.dart';
import 'package:cryptoX/Scan2Pay.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'apptheme/theme.dart';

List<String> names = [
  'Ayan Basu',
  'Prince Makkar',
  'Vidyanshu',
  'Charchit',
  'Saurabh',
  'Anuj Rane',
  'Rahul'
]; //For Storing all the User's Name

const List<TabItem> navItems = [
  TabItem(
    icon: FontAwesomeIcons.wallet,
    title: 'Wallet',
  ),
  TabItem(
    icon: FontAwesomeIcons.chartLine,
    title: 'Market',
  ),
  TabItem(icon: Icons.expand_less_rounded),
  TabItem(
    icon: FontAwesomeIcons.receipt,
    title: 'History',
  ),
  TabItem(
    icon: FontAwesomeIcons.gear,
    title: 'Settings',
  ),
];

String userName = 'Aditya Kumar'; //For current User Name fetched from DataBase

int currentIndex = 0;

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key}) {
    //Used flag for changing states, if flag = 0 means keys are not created.
    //if flag is passed as 1 by another page (ie. KeyGeneration Page) then it shows the account balance info.
  }
  PageController pageController = PageController(initialPage: 0);
  @override
  State<MyHomePage> createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  bool flag = false;
  String? myAddress;
  static const String IS_CREATED = 'isWalletCreated';
  static const String PUBLICADDRESS = 'PublicKey';
  late final AnimationController _animController = AnimationController(
    animationBehavior: AnimationBehavior.preserve,
    vsync: this,
    duration: const Duration(
      milliseconds: 4500,
    ),
  );

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 500), () {
      _animController.forward();
    });
    isWalletCreated();
    super.initState();
  }

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
                color: Colors.white,
                // width: 100,
                margin: const EdgeInsets.only(top: 30, bottom: 15, right: 10),
                child: InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ProfilePage()));
                  },
                  child: const Hero(
                    tag: 'profile',
                    child: CircleAvatar(
                      backgroundColor: Color.fromARGB(100, 0, 90, 100),
                      // backgroundColor: Colors.transparent,
                      backgroundImage: AssetImage('assets/images/Adit.jpg'),
                      maxRadius: 25,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      // -------------------- FLOATING ACTION BUTTON --------------------------------------
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
              controller: _animController),
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
      // ----------------------------- BOTTOM NAVIGATION BAR ------------------------------

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
          items: navItems,
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
          indexSelected: currentIndex,
          onTap: (newIndex) => setState(() {
            if (newIndex > 1 && newIndex < 4) {
              newIndex = 2;
            } else if (newIndex == 4) {
              newIndex = 3;
            }
            widget.pageController.animateToPage(newIndex,
                duration: const Duration(milliseconds: 500),
                curve: Curves.ease);
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
      body: Container(
        color: Colors.white,
        // color: primaryColor(),
        child: PageView(
          controller: widget.pageController,
          onPageChanged: (newIndex) {
            setState(() {
              if (newIndex > 1 && newIndex < 4) {
                currentIndex = newIndex + 1;
              } else {
                currentIndex = newIndex;
              }
            });
          },
          physics: const BouncingScrollPhysics(),
          children: [
            FirstPage(
              flag,
              myAddress,
              pc: widget.pageController,
            ),
            const SecondPage(),
            const ThirdPage(),
            const FourthPage(),
          ],
        ),
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
      myAddress = sp.getString(PUBLICADDRESS);
      print("PUBLIC ADDRESS --------->$myAddress");
    });
  }
}
