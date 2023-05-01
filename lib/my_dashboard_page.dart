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

import 'app_theme/theme.dart';

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

  String? myAddress;

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
      backgroundColor: lightTheme(),

      //----------------------------------- APP BAR FOR MAIN DASHBOARD ---------------------------------------

      appBar: appBar(
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
                        color: complementColor(),
                        fontSize: 12,
                        fontWeight: FontWeight.w600),
                    text(userName,
                        color: primaryColor(), fontWeight: FontWeight.w600),
                  ],
                ),
              ),
              Container(
                color: lightTheme(),
                margin: const EdgeInsets.only(top: 30, bottom: 15, right: 10),
                child: InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ProfilePage()));
                  },
                  child: Hero(
                    tag: 'profile',
                    child: circularProfile(image: userImage),
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
          // splashColor: Colors.blue,
          // elevation: 0,
          // backgroundColor: Colors.white,
          backgroundColor: (isWalletCreatedFlag == false)
              ? const Color(0xffc9a408)
              : accentColor2(), // USED THIS ACCENT COLOR WHEN WALLET CREATED
          // backgroundColor: accentColor(),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => Scan2Pay(
                  scannerMode: 'scanAddress'), //NORMAL SCAN TO PAY MODE
            ));
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
        color: lightTheme(),
        child: BottomBarCreative(
          highlightStyle:
              HighlightStyle(background: primaryColor(), color: primaryColor()),
          borderRadius: BorderRadius.circular(16),
          items: navItems,
          backgroundColor: primaryColor(),
          color: const Color(0xff6a767c),
          colorSelected: (isWalletCreatedFlag == false)
              ? const Color(0xffc9a408)
              : const Color(0xffEECB6B),
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
