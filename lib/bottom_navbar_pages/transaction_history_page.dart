import 'package:cryptoX/app_theme/theme.dart';
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
    return Center(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              'assets/anim/no-history-found.json',
              frameRate: FrameRate.max,
              // 'https://assets1.lottiefiles.com/packages/lf20_iikbn1ww.json',
              // 'https://assets10.lottiefiles.com/packages/lf20_xvf1dl3s.json',
              height: 250,
            ),
            Text(
              'No Transaction History Found!',
              style: TextStyle(fontFamily: 'Space', color: complementColor()),
            ),
          ],
        ),
      ),
    );
  }
}
