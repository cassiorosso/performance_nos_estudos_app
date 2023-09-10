import 'package:flutter/material.dart';

import '../components/revisao_card_widget.dart';
import '../components/revisoes_legenda_widget.dart';

class RevisoesPageMobile extends StatelessWidget {
  const RevisoesPageMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        RevisoesLegenda(),
        RevisaoCardWidget(),
        RevisaoCardWidget(),
        RevisaoCardWidget(),
        RevisaoCardWidget(),
        RevisaoCardWidget(),
      ],
    );
  }
}