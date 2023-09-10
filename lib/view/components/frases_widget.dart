import 'package:flutter/material.dart';

class FrasesWidget extends StatelessWidget {
  const FrasesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
        //width: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.grey[300],
        ),
        child: const Text("• Estude para alcançar uma vida melhor •", textAlign: TextAlign.center),
      ),
    );
  }
}