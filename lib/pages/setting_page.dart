import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class FourthPage extends StatefulWidget {
  const FourthPage({super.key});

  @override
  State<FourthPage> createState() => _FourthPageState();
}

class _FourthPageState extends State<FourthPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Lottie.network(
          'https://assets6.lottiefiles.com/packages/lf20_eu5gscby.json',
        ),
      ],
    );
  }
}
