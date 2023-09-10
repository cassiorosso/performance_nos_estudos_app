import 'package:flutter/material.dart';

import '../components/revisao_card_widget.dart';
import '../components/revisoes_legenda_widget.dart';

class RevisoesPageTablet extends StatelessWidget {
  const RevisoesPageTablet({super.key});

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