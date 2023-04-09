import 'package:cryptoX/LoginPage.dart';
import 'package:cryptoX/WalletCreation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:cryptoX/Scan2Pay.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
  ));
  runApp(MyApp());
}

List names = [
  'USER 1',
  'USER 2',
  'USER 3',
  'USER 4',
  'USER 5',
  'USER 6',
  'USER 7'
];

String usr_name = 'Aditya';

class MyApp extends StatefulWidget {
  int? f;
  MyApp({int flag = 0, super.key}) {
    //for changing state if flag = 0 means keys are not created
    f = flag; //if flag is passed as 1 by another page then it shows keys are generated and walled is created successfully.
  }

  @override
  State<MyApp> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cryptox',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginPage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    //double h = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 80,
          foregroundColor: Colors.black,
          elevation: 0,
          title: SizedBox(
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 55, bottom: 35, left: 8),
                  child: Text('Hi, $usr_name',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 30,
                          fontFamily: 'Poppins',
                          // color: Color.fromARGB(255, 71, 217, 204),
                          color: Colors.black,
                          fontWeight: FontWeight.w700)),
                ),
                Container(
                  // width: 100,
                  margin: const EdgeInsets.only(top: 30, bottom: 15, right: 5),
                  child: const Card(
                    shape: CircleBorder(),
                    elevation: 3,
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
          backgroundColor: Colors.transparent,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: SizedBox(
          height: 85,
          width: 85,
          child: FloatingActionButton(
            tooltip: 'Scan to Pay',
            // splashColor: Colors.blue,
            onPressed: () {
              int page = 1;
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => Scan2Pay(page),
              ));
            },
            backgroundColor: Colors.white,
            child: Container(
              margin: const EdgeInsets.only(top: 15, bottom: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: const DecorationImage(
                    image: AssetImage('assets/images/QR_scan.png')),
                boxShadow: const [
                  BoxShadow(
                    blurRadius: 30,
                    spreadRadius: 0,
                    color: Colors.white,
                  )
                ],
              ),
            ),
          ),
        ),
        //----------------- BOTTOM NAVIGATION BAR --------------------------------------
        bottomNavigationBar: Container(
          // color: const Color(0xfff3f3f3),
          child: BottomAppBar(
            height: 80,
            //bottom navigation bar on scaffold
            color: Colors.white,
            shape: const CircularNotchedRectangle(), //shape of notch
            notchMargin:
                10, //notch margin between floating button and bottom appbar
            child: Row(
              //children inside bottom appbar
              // mainAxisSize: MainAxisSize.max,
              // mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: IconButton(
                    icon: const Icon(
                      FontAwesomeIcons.wallet,
                      color: Colors.blue,
                    ),
                    onPressed: () {},
                  ),
                ),
                const Expanded(
                    flex: 1,
                    child: SizedBox(
                      width: 10,
                    )),
                Expanded(
                  flex: 2,
                  child: IconButton(
                    icon: const Icon(
                      FontAwesomeIcons.gear,
                      color: Colors.black,
                    ),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ),
        ),
        body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Container(
                height: 777,
                // color: Colors.transparent,
                // color: const Color(0xfff3f3f3),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Balance(),
                    //--------------------------SCANNER----------------------------------->
                    // Container(
                    //   margin: const EdgeInsets.all(20),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //     children: [
                    //       InkWell(
                    //         onTap: () {
                    //           Navigator.of(context).push(MaterialPageRoute(
                    //             builder: (context) => const Scan2Pay(),
                    //           ));
                    //         },
                    //         child: Column(
                    //           children: [
                    //             Container(
                    //               height: 150,
                    //               width: 150,
                    //               margin: const EdgeInsets.only(
                    //                   top: 15, bottom: 15),
                    //               decoration: BoxDecoration(
                    //                   borderRadius: BorderRadius.circular(15),
                    //                   image: const DecorationImage(
                    //                       image: AssetImage(
                    //                           'assets/images/QR_scan.png')),
                    //                   boxShadow: const [
                    //                     BoxShadow(
                    //                       blurRadius: 30,
                    //                       spreadRadius: 0,
                    //                       color: Color(0xb8aee1f1),
                    //                     )
                    //                   ]),
                    //
                    //               // child: Image.asset('assets/images/QR_scan.png')
                    //             ),
                    //             const Text(
                    //               'Scan to Pay',
                    //               style: TextStyle(
                    //                   fontSize: 15,
                    //                   color: Colors.red,
                    //                   fontFamily: 'Poppins',
                    //                   // backgroundColor: Colors.yellow,
                    //                   fontWeight: FontWeight.w400),
                    //             ),
                    //           ],
                    //         ),
                    //       ),
                    //       // InkWell(
                    //       //   onTap: () {
                    //       //     ScaffoldMessenger.of(context)
                    //       //         .showSnackBar(const SnackBar(
                    //       //       content: Text("Receive Money Tapped! "),
                    //       //     ));
                    //       //   },
                    //       //   child: Column(
                    //       //     children: [
                    //       //       Container(
                    //       //         margin: const EdgeInsets.only(bottom: 15),
                    //       //         height: 150,
                    //       //         width: 125,
                    //       //         decoration: BoxDecoration(
                    //       //             borderRadius: BorderRadius.circular(15),
                    //       //             image: const DecorationImage(
                    //       //                 image: AssetImage(
                    //       //                     'assets/images/receive-money.png')),
                    //       //             boxShadow: const [
                    //       //               BoxShadow(
                    //       //                 blurRadius: 30,
                    //       //                 spreadRadius: 0,
                    //       //                 color: Color.fromRGBO(255, 172, 0, 0.1),
                    //       //               )
                    //       //             ]),
                    //       //
                    //       //         // child: Image.asset('assets/images/QR_scan.png')
                    //       //       ),
                    //       //       const Text(
                    //       //         'Recieve',
                    //       //         style: TextStyle(
                    //       //             fontFamily: 'Poppins',
                    //       //             fontSize: 15,
                    //       //             color: Colors.red,
                    //       //             // backgroundColor: Colors.yellow,
                    //       //             fontWeight: FontWeight.w400),
                    //       //       ),
                    //       //     ],
                    //       //   ),
                    //       // ),
                    //     ],
                    //   ),
                    // ),
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(bottom: 20, left: 25),
                      child: const Text(
                        'Recent Transaction',
                        style: TextStyle(
                            // color: Colors.black,
                            fontFamily: 'Poppins',
                            fontSize: 20,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 25.0, right: 25.0),
                      height: 190,
                      // width: 350,
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(15)),
                        border: Border.all(
                          color: const Color(0xffe0c2a4),
                          width: .5,
                        ),
                        //color: Colors.white
                        color: const Color(0xfff8e0bf),
                        // border: ,
                      ),
                      child: GridView.builder(
                        padding: const EdgeInsets.only(top: 15.0, bottom: 0),
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 100),
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () =>
                                // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(names[index])));
                                setState(() {
                              usr_name = names[index];
                            }),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(
                                  height: 50,
                                  width: 50,
                                  // child: Image.asset(
                                  //     'assets/images/user_icon_5.png')
                                  child: CircleAvatar(
                                    backgroundColor: Color(0xffe7cebc),
                                    // backgroundImage: AssetImage('assets/images/Adit.jpg'),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    names[index],
                                    style: const TextStyle(
                                        fontSize: 12,
                                        color: Colors.black54,
                                        // backgroundColor: Colors.yellow,
                                        fontWeight: FontWeight.w700),
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                        itemCount: names.length,
                      ),
                    ),
                  ],
                ))));
    // body: Column(
    //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //     children: const [Text('data'), Text("data"), Text("data")]));
  }
}

class Balance extends StatelessWidget {
  const Balance({super.key});

  @override
  build(context) {
    return InkWell(
      onTap: () {
        // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        //   content: Text("Balance Amount: ₹10,000 "),
        // ));
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const WalletCreation()));
      },
      child: Container(
        margin: const EdgeInsets.only(top: 15, bottom: 25),
        height: 180,
        width: 350,
        child: Card(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              side: BorderSide(width: 0, color: Color(0xff9aceea)
                  // color: Color(0xffffffff),
                  )),
          elevation: 0,
          // color: Colors.white,
          color: const Color(0xffd8edf5),
          // shadowColor: const Color.fromRGBO(255, 172, 0, 0.25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Available Balance',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                  // color: Color(0xff0f87a2),
                ),
              ),
              const Text(
                '₹ 10,000',
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 35,
                    fontWeight: FontWeight.w700,
                    // color: Color.fromRGBO(248, 98, 66, 1.0),
                    color: Colors.blue),
              ),
              const Text(
                'Wallet (ETH)',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  // color: Color(0xff000000),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 25,
                    child: Image.asset('assets/images/ethereum.png'),
                  ),
                  const Text(
                    '100',
                    style: TextStyle(
                      fontFamily: 'poppins',
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                      // color: Colors.orangeAccent,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
