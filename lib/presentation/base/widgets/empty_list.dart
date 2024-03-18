import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class EmptyList extends StatelessWidget {
  const EmptyList(this.text, {super.key});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Lottie.asset('assets/lottie/empty.json', repeat: false),
        const SizedBox(height: 10),
        Text(
          text,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 100),
      ],
    );
  }
}
