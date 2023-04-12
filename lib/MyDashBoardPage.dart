import 'package:cryptoX/WalletCreation.dart';
import 'package:cryptoX/profilepage.dart';
import 'package:flutter/material.dart';
import 'package:cryptoX/Scan2Pay.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

List names = [
  'USER 1',
  'USER 2',
  'USER 3',
  'USER 4',
  'USER 5',
  'USER 6',
  'USER 7'
]; //For Storing all the User's Name

String usr_name = 'Aditya'; //For current User Name

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key}) {
    //Used flag for changing states, if flag = 0 means keys are not created.
    //if flag is passed as 1 by another page (ie. KeyGeneration Page) then it shows the account balance info.
  }

  @override
  State<MyHomePage> createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  bool? flag;
  String? MyAddress;
  static const String IS_CREATED = 'isWalletCreated';
  static const String PUBLICADDRESS = 'PublicKey';

  @override
  void initState() {
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
          foregroundColor: Color(0xffd6e4ef),
          // foregroundColor: Colors.white,
          // backgroundColor: Colors.white,
          // backgroundColor: Color(0xff1f1f1f),
          elevation: 1,
          shadowColor: Color(0x4dffffff),
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
                          // color: Colors.black,
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
        ),
        //-------------------- FLOATING ACTION BUTTON --------------------------------------
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
                // boxShadow: const [
                //   BoxShadow(
                //     blurRadius: 30,
                //     spreadRadius: 0,
                //     color: Colors.blueAccent,
                //   )
                // ],
              ),
            ),
          ),
        ),
        //----------------------------- BOTTOM NAVIGATION BAR ------------------------------
        bottomNavigationBar: Container(
          // color: const Color(0xfff9f9f9),
          //DARK
          // color: Color(0xff131313),
          color: const Color(0xfff3f3f3),
          // color: const Color(0xfff3f3f3),
          child: BottomAppBar(
            height: 80,
            //bottom navigation bar on scaffold
            // color: Colors.white,
            // color: Colors.black,
            //Dark
            // color: Color(0xff1f1f1f),
            shape: const CircularNotchedRectangle(),
            //shape of notch
            notchMargin: 10,
            //notch margin between floating button and bottom appbar
            child: Row(
              //children inside bottom appbar
              // mainAxisSize: MainAxisSize.min,
              // mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      IconButton(
                        tooltip: 'My Wallet',
                        icon: const Icon(
                          // FontAwesomeIcons.wallet,
                          Icons.account_balance_wallet_rounded,
                          color: Colors.blue,
                          size: 27,
                        ),
                        onPressed: () {},
                      ),
                      const Text(
                        'My Wallet',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                            fontSize: 12),
                      ),
                    ],
                  ),
                ),
                const Expanded(
                    flex: 1,
                    child: SizedBox(
                      width: 10,
                    )),
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      IconButton(
                        tooltip: 'Profile',
                        icon: const Icon(
                          Icons.account_circle_outlined,
                          // FontAwesomeIcons.addressCard,
                          color: Colors.black,
                          size: 30,
                          // color: Colors.white,
                        ),
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ProfilePage()));
                        },
                      ),
                      const Text(
                        'My Profile',
                        style: TextStyle(fontFamily: 'Poppins', fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        //---BODY--->
        body: Container(
          color: const Color(0xfff3f3f3),
          child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Container(
                  height: 777,
                  // color: Colors.transparent,
                  //New Change here---------
                  // color: const Color(0xfff9f9f9),
                  // color: const Color(0xff101010),
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    // mainAxisSize: MainAxisSize.min,
                    children: [
                      Balance(flag, MyAddress),
                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.only(bottom: 20, left: 25),
                        child: const Text(
                          'Recent Transaction',
                          style: TextStyle(
                              color: Colors.black,
                              // color: Colors.white,
                              fontFamily: 'Poppins',
                              fontSize: 20,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      const RecentTransaction(),
                    ],
                  ))),
        ));
    // body: Column(
    //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //     children: const [Text('data'), Text("data"), Text("data")]));
  }

  void isWalletCreated() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    setState(() {
      flag = sp.getBool(IS_CREATED);
      print("FLAG --------->${flag}");
      MyAddress = sp.getString(PUBLICADDRESS);
      print("PUBLIC ADDRESS --------->${MyAddress}");
    });
  }
}

class Balance extends StatefulWidget {
  bool? flag;
  String? pubAddrs;

  Balance(bool? f, String? addr, {super.key}) {
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
      width: 350,
      child: (widget.flag == true)
          ? SizedBox(
              height: 300,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    height: 180,
                    // margin: const EdgeInsets.only(top: 0),
                    child: Card(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
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
                                child:
                                    Image.asset('assets/images/ethereum.png'),
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
                  Container(
                    height: 40,
                    width: 250,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: const BorderRadius.all(Radius.circular(30)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(15, 10, 10, 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text('My Address: ',
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: Colors.black54,
                                  fontSize: 14)),
                          SizedBox(
                              width: 111,
                              child: Text(
                                widget.pubAddrs!,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontFamily: 'Poppins',
                                    color: Colors.black54,
                                    fontSize: 14),
                              )),
                          SizedBox(
                            width: 25,
                            child: IconButton(
                                tooltip: 'Click to copy on the clipboard',
                                onPressed: () async {
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
                                        style: TextStyle(fontFamily: 'Poppins'),
                                      ),
                                    ));
                                  });
                                  // copied successfully
                                },
                                padding: const EdgeInsets.all(0),
                                icon: const Icon(
                                  // FontAwesomeIcons.clipboard,
                                  Icons.content_copy_rounded,
                                  color: Colors.blue,
                                  size: 18,
                                )),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )
          : InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const WalletCreation()));
              },
              child: Container(
                height: 190,
                margin: const EdgeInsets.only(top: 20, bottom: 25),
                child: Card(
                  shape: const RoundedRectangleBorder(
                      //New changes done old radius was 15
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      side: BorderSide(
                        width: 0,
                        // color: Color(0xff9aceea)
                        color: Color(0xffc76969),
                        // color: Color(0xffffffff),
                      )),
                  elevation: 0,
                  // color: Colors.white,
                  color: const Color(0xfff1b4b4),
                  // shadowColor: const Color.fromRGBO(255, 172, 0, 0.25),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Padding(
                        padding: EdgeInsets.all(25.0),
                        child: Text(
                          'No wallet found!',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: Color(0xffd74444),
                          ),
                        ),
                      ),
                      Text(
                        'Tap to create a wallet',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                            //Previous
                            // color: Color(0xff699bcb)
                            //red
                            // color: Colors.white70
                            color: Color(0xffd74444)
                            // color: Color(0xff0f87a2),
                            ),
                      ),
                      SizedBox(
                        height: 50,
                        width: 50,
                        child: Icon(
                          Icons.add_circle_outline_rounded,
                          // color: Colors.white70,
                          color: Color(0xffd74444),
                          //previous color
                          // color: Color(0xff699bcb),
                          size: 30,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}

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
      height: 190,
      // width: 350,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
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
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 100),
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () => ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text('Payment Page is Opening for ${names[index]}'))),
            // onTap: () => setState(() {
            //   //usr_name = names[index];
            // }),
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
    );
  }
}
