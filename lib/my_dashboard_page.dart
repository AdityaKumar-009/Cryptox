// PACKAGE FOR CUSTOM BOTTOM NAVBAR : AWESOME BOTTOM BAR        [ used to get rounded corners ]
import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';

// 4 BOTTOM NAVBAR PAGES
import 'package:cryptoX/bottom_navbar_pages/wallet_homepage.dart';
import 'package:cryptoX/bottom_navbar_pages/crypto_market_page.dart';
import 'package:cryptoX/bottom_navbar_pages/transaction_history_page.dart';
import 'package:cryptoX/bottom_navbar_pages/settings_page.dart';

// PROFILE PAGE
import 'package:cryptoX/profile_page.dart';

// FLUTTER UI PACKAGE
import 'package:flutter/material.dart';

// SCANNER PAGE
import 'package:cryptoX/scanner_page.dart';

// CUSTOM ICONS PACKAGE : FONT AWESOME
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// CUSTOM ANIMATION PACKAGE
import 'package:lottie/lottie.dart';

// PACKAGE FOR LOCAL STORAGE
import 'package:shared_preferences/shared_preferences.dart';

import 'package:cryptoX/app_utilities/theme.dart';

// LIST FOR STORING NAMES WHO YOU MADE TRANSACTION RECENTLY
List<String> names = [
  'Ayan Basu',
  'Prince Makkar',
  'Vidyanshu',
  'Charchit',
  'Saurabh',
  'Anuj Rane',
  'Rahul'
];

// TAB ITEMS FOR AWESOME BOTTOM BAR
const List<TabItem> navItems = [
  TabItem(
    icon: FontAwesomeIcons.wallet,
    title: 'Wallet',
  ),
  TabItem(
    icon: FontAwesomeIcons.chartLine,
    title: 'Market',
  ),
  TabItem(
      icon:
          Icons.expand_less_rounded), // EMPTY ICON IN THE MIDDLE TO GET SPACING
  TabItem(
    icon: FontAwesomeIcons.receipt,
    title: 'History',
  ),
  TabItem(
    icon: FontAwesomeIcons.gear,
    title: 'Settings',
  ),
];

//FOR STORING CURRENT USERNAME FETCHED FROM DB ( DATABASE )
String userName = 'Aditya Kumar';

//FOR STORING CURRENT USER PROFILE PHOTO FETCHED FROM DB ( DATABASE )
ImageProvider userImage = const AssetImage('assets/images/Adit.jpg');

// CURRENT SELECTED INDEX FOR NAVIGATION BAR
int currentIndex = 0;

//
String? myAddress; // MY PUBLIC ADDRESS

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key});

  final PageController pageController = PageController(initialPage: 0);

  @override
  State<MyHomePage> createState() => MyHomePageState();
}

// SINGLE TICKER IS REQUIRED FOR ANIMATION CONTROLLER CONSTRUCTOR : ( vsync : this )
class MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  // FLAG TO STORE TRUE IF WALLET CREATED
  bool isWalletCreatedFlag = false;

  static const String isCreated = 'isWalletCreated';
  static const String publicAddress = 'PublicKey';

  // THIS ANIMATION CONTROLLER USED TO STOP ANIMATION AFTER 4.5 sec [ IN FLOATING ACTION BUTTON ]
  late final AnimationController _animController = AnimationController(
    animationBehavior: AnimationBehavior.preserve,
    vsync: this,
    duration: const Duration(
      milliseconds: 4500,
    ),
  );

  @override
  void dispose() {
    // TO REMOVE MEMORY ALLOCATED FOR ANIMATION CONTROLLER WHEN PAGE IS EXITED / DESTROYED
    _animController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // DELAYED ANIMATION [ FOR LOTTIE ANIMATION USED IN FLOATING ACTION BUTTON ]
    Future.delayed(const Duration(milliseconds: 500), () {
      _animController.forward();
    });

    // TO CHECK WHETHER WALLET KEYS IS GENERATED OR NOT
    isWalletCreated();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: lightTheme(),

      //----------------------------------- APP BAR FOR MAIN DASHBOARD ---------------------------------------

      appBar: appBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        content: SizedBox(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 55, bottom: 35, left: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    text('Welcome',
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: complementColor()),
                    text(userName,
                        color: (MediaQuery.platformBrightnessOf(context) ==
                                Brightness.light)
                            ? Colors.black
                            : accentColor(),
                        fontSize: 20,
                        fontWeight: FontWeight.w600),
                  ],
                ),
              ),
              Container(
                color: Theme.of(context).scaffoldBackgroundColor,
                margin: const EdgeInsets.only(top: 30, bottom: 15, right: 10),
                child: InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ProfilePage()));
                  },
                  child: Hero(
                    tag: 'profile',
                    child: circularProfile(image: userImage, context: context),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

      // ------------------- FLOATING ACTION BUTTON ( WHICH HAS SCANNER ANIMATION )---------------------------

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: SizedBox(
        height: 77,
        width: 77,
        child: FloatingActionButton(
          tooltip: 'Scan to Pay',
          backgroundColor: (isWalletCreatedFlag == false) // LIGHT THEME
              ? ((MediaQuery.of(context).platformBrightness == Brightness.light)
                  ? const Color(0xffc9a408)
                  : complementColor())
              : ((MediaQuery.of(context).platformBrightness == Brightness.light)
                  ? accentColor2() // USED THIS ACCENT COLOR WHEN WALLET CREATED
                  : complementColor()),

          onPressed: () {
            if (isWalletCreatedFlag == true) {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => Scan2Pay(
                    scannerMode: 'scanAddress'), //NORMAL SCAN TO PAY MODE
              ));
            } else {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                backgroundColor: Colors.red.shade800,
                behavior: SnackBarBehavior.floating,
                content: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.error,
                            color: lightTheme(),
                          ),
                        ),
                        Text(
                          'Create a wallet first!',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: lightTheme(),
                              fontFamily: 'Space',
                              fontWeight: FontWeight.w600,
                              fontSize: 18),
                        ),
                      ],
                    ),
                  ],
                ),
              ));
            }
          },
          child: Lottie.asset('assets/anim/qrScanner.json',
              frameRate: FrameRate.max,
              controller:
                  _animController), // TO DELAYED AND STOP THE ANIMATION USING THE CONTROLLER
        ),
      ),

      // ----------------------------- BOTTOM NAVIGATION BAR ------------------------------

      bottomNavigationBar: Container(
        height: 85,
        padding: const EdgeInsets.only(bottom: 15, right: 15, left: 15),
        color: Theme.of(context).scaffoldBackgroundColor,
        child: BottomBarCreative(
          highlightStyle: HighlightStyle(
              background: (isWalletCreatedFlag == false)
                  ? ((MediaQuery.of(context).platformBrightness ==
                          Brightness.light)
                      ? primaryColor()
                      : const Color(0xffc9a408))
                  : ((MediaQuery.of(context).platformBrightness ==
                          Brightness.light)
                      ? primaryColor()
                      : const Color(0xffEECB6B)),
              color: (isWalletCreatedFlag == false)
                  ? ((MediaQuery.of(context).platformBrightness ==
                          Brightness.light)
                      ? primaryColor()
                      : const Color(0xffc9a408))
                  : ((MediaQuery.of(context).platformBrightness ==
                          Brightness.light)
                      ? primaryColor()
                      : const Color(0xffEECB6B))),
          borderRadius: BorderRadius.circular(16),
          items: navItems,
          backgroundColor: (isWalletCreatedFlag == false)
              ? ((MediaQuery.of(context).platformBrightness == Brightness.light)
                  ? primaryColor()
                  : const Color(0xffc9a408))
              : ((MediaQuery.of(context).platformBrightness == Brightness.light)
                  ? primaryColor()
                  : const Color(0xffEECB6B)),
          // color: const Color(0xff6a767c), // LIGHT THEME
          color: (MediaQuery.of(context).platformBrightness == Brightness.light)
              ? const Color(0xff6a767c)
              : const Color(0x881b1b1b),
          colorSelected: (isWalletCreatedFlag == false) // LIGHT THEME
              ? ((MediaQuery.of(context).platformBrightness == Brightness.dark)
                  ? primaryColor()
                  : const Color(0xffc9a408))
              : ((MediaQuery.of(context).platformBrightness == Brightness.dark)
                  ? primaryColor()
                  : const Color(0xffEECB6B)),
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

      // -------------------------------- BODY ---------------------------------

      body: PageView(
        controller: widget.pageController,
        onPageChanged: (newIndex) {
          // LOGIC FOR PAGES NAVIGATION WHEN SWIPING PAGES
          setState(() {
            // THIS LOGIC IS USED SINCE THERE IS ONLY 4 PAGES BUT 5 NAVBAR BUTTONS [ one is hidden in the middle ]
            if (newIndex > 1 && newIndex < 4) {
              currentIndex = newIndex + 1;
            } else {
              currentIndex = newIndex;
            }
          });
        },
        physics:
            const BouncingScrollPhysics(), // IPHONE LIKE ELASTIC SCROLLING EFFECT
        children: <Widget>[
          FirstPage(
            isCreated: isWalletCreatedFlag,
            publicAddress: myAddress.toString(),
            pageController: widget.pageController,
          ),
          const SecondPage(),
          const ThirdPage(),
          const FourthPage(),
        ],
      ),
    );
  }

  // LOGIC FOR CHECKING WALLET CREATION USING THE SHARED PREFERENCE
  void isWalletCreated() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    setState(() {
      isWalletCreatedFlag =
          (sp.getBool(isCreated) != null) ? sp.getBool(isCreated)! : false;
      print("IS WALLET CREATED FLAG ---------> $isWalletCreatedFlag");
      myAddress = sp.getString(publicAddress);
      print("PUBLIC ADDRESS ---------> $myAddress");
    });
  }
}
