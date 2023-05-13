import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:just_audio/just_audio.dart';
import 'package:lottie/lottie.dart';
import 'package:web3dart/web3dart.dart';
import 'app_utilities/theme.dart';

class TransactionPage extends StatefulWidget {
  EthereumAddress? publicAddress; // IN THE FORM OF ETHEREUM ADDRESS
  String page = 'payment';
  TransactionPage({super.key, required EthereumAddress pubAddress}) {
    publicAddress = pubAddress;
    // TO USE IT AS STRING [ use method   ->    publicAddress.toString()  or use it as a raw  ]
  }

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage>
    with SingleTickerProviderStateMixin {
  // TWO PAGES states 'payment' & 'confirmation'

  static AudioPlayer player = AudioPlayer();

  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(
      milliseconds: 1700,
    ),
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  playTune() async {
    await player.setAsset(
        'assets/tunes/success.mp3'); // Load a URL  // Schemes: (https: | file: | asset: )
    player.play();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //

      appBar: titledAppBar(
          context: context,
          title: 'Payment',
          putLeading: true,
          leadingContent: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(
                FontAwesomeIcons.xmark,
              ))),

      //

      body: SafeArea(
        child: (widget.page == 'payment')
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Card(
                      shape: const CircleBorder(),
                      elevation: 20,
                      child: CircleAvatar(
                        backgroundColor: Theme.of(context).cardColor,
                        backgroundImage:
                            const AssetImage('assets/images/Adit.jpg'),
                        radius: 50,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: text(
                      'USER NAME',
                      textAlign: TextAlign.center,
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  text(
                    'public address....',
                    textAlign: TextAlign.center,
                    fontSize: 12,
                    color: complementColor(),
                    fontWeight: FontWeight.w400,
                  ),
                  Container(
                    padding: const EdgeInsets.all(20.0),
                    child: inputField(
                      autofocus: true,
                      inputFormatters: [
                        // FilteringTextInputFormatter.allow('.'),
                        FilteringTextInputFormatter.deny(
                            RegExp(r'[a-z]|[A-Z]')),
                        LengthLimitingTextInputFormatter(8),
                      ],
                      fontSize: 60,
                      fontWeight: FontWeight.w700,
                      // backgroundColor: Colors.transparent,
                      keyboardType: TextInputType.number,
                      // textAlign: TextAlign.center,
                      context: context,
                      shadowColor: Colors.transparent,
                      hintText: '0',
                      prefix: SizedBox(
                        width: 80,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          // crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            // text('₹',
                            //     fontWeight: FontWeight.w700,
                            //     fontSize: 60,
                            //     color: accentColor()),
                            Icon(
                              Icons.currency_rupee_rounded,
                              size: 40,
                              color: accentColor(),
                            ),
                            Container(
                              height: 50,
                              width: 1,
                              color: Theme.of(context).dividerColor,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 100,
                    child: button(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Payment Processing Logic')));
                        setState(() {
                          widget.page = 'confirmation';
                          _controller.forward();
                          playTune();
                        });
                      },
                      content: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            text('Send',
                                fontSize: 18, fontWeight: FontWeight.w600),
                            const Icon(Icons.send_rounded)
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              )
            : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 30),
                      width: 85,
                      child: Lottie.asset('assets/anim/success.json',
                          frameRate: FrameRate.max, controller: _controller),
                    ),
                    Container(
                        margin: const EdgeInsets.only(bottom: 15),
                        child: text('PAYMENT INITIATED!',
                            textAlign: TextAlign.center,
                            fontSize: 20,
                            color: green(),
                            fontWeight: FontWeight.w600)),
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: text(
                        'Transaction has been initiated by our end. Check on ETHERSCAN for more details.',
                        textAlign: TextAlign.center,
                        fontSize: 12,
                        color: complementColor(),
                        fontWeight: FontWeight.w400,
                      ),
                    )
                  ],
                ),
              ),
      ),
    );
  }
}
