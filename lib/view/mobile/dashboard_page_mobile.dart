import 'package:flutter/material.dart';
import 'package:performance_nos_estudos_app/view/components/desempenho_widget.dart';
import 'package:performance_nos_estudos_app/view/components/frases_widget.dart';
import 'package:performance_nos_estudos_app/view/components/proximas_revisoes_widget.dart';

class DashboardPageMobile extends StatelessWidget {
  const DashboardPageMobile ({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GridView(
        scrollDirection: Axis.vertical,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1),
        children: const [
          ProximasRevisoesWidget(),
          DesempenhoWidget(),
          FrasesWidget()
        ],
      ),
    );
  }
}