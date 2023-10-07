import 'package:flutter/material.dart';

class RevisoesLegenda extends StatelessWidget {
  const RevisoesLegenda({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(flex: 3, child: Text("Matéria")),
          Expanded(flex: 3, child: Text("Data última\nrevisão", textAlign: TextAlign.center,)),
          Expanded(flex: 3, child: Text("Acerto (%)",textAlign: TextAlign.center)),
          Expanded(flex: 4, child: Text("Data Próxima\nrevisão", textAlign: TextAlign.center)),
        ],
      ),
    );
  }
}
