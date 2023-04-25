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
        Lottie.asset('assets/anim/no-history-found.json',
            // 'https://assets1.lottiefiles.com/packages/lf20_iikbn1ww.json',
            // 'https://assets10.lottiefiles.com/packages/lf20_xvf1dl3s.json',
            height: 250),
        Text(
          'No Transaction History Found!',
          style: TextStyle(fontFamily: 'Space', color: complementColor()),
        ),
      ],
    );
  }
}
