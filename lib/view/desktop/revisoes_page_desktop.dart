import 'package:flutter/material.dart';
import 'package:performance_nos_estudos_app/view/components/revisao_card_widget.dart';
import 'package:performance_nos_estudos_app/view/components/revisoes_legenda_widget.dart';

class RevisoesPage extends StatelessWidget {
   const RevisoesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        children: const [
          RevisoesLegenda(),
          RevisaoCardWidget(),
          RevisaoCardWidget(),
          RevisaoCardWidget(),
          RevisaoCardWidget(),
          RevisaoCardWidget(),
        ],
      ),
    );
  }
}
