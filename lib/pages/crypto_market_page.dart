import 'package:cryptoX/apptheme/theme.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SecondPage extends StatefulWidget {
  const SecondPage({super.key});

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Lottie.asset('assets/anim/market.json',
            // 'https://assets1.lottiefiles.com/packages/lf20_yMpiqXia1k.json', //STOCKS
            // 'https://assets9.lottiefiles.com/private_files/lf30_jspeqlsz.json', //CRYPTO LOADING
            // 'https://assets10.lottiefiles.com/packages/lf20_pmyyjcm7.json', //Crypto Stocks
            width: 250),
        Text(
          'Fetching Current Prices...',
          style: TextStyle(fontFamily: 'Space', color: complementColor()),
        )
      ],
    );
  }
}
