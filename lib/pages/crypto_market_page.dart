import 'package:cryptoX/apptheme/theme.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ThirdPage extends StatefulWidget {
  const ThirdPage({super.key});

  @override
  State<ThirdPage> createState() => _ThirdPageState();
}

class _ThirdPageState extends State<ThirdPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Lottie.network(
            // 'assets/anim/market.lottie',
            'https://assets1.lottiefiles.com/packages/lf20_yMpiqXia1k.json', //STOCKS
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
