import 'package:flutter/material.dart';
import 'package:performance_nos_estudos_app/view/components/desempenho_widget.dart';
import 'package:performance_nos_estudos_app/view/components/frases_widget.dart';
import 'package:performance_nos_estudos_app/view/components/proximas_revisoes_widget.dart';

class DashboardPageDesktop extends StatelessWidget {
  const DashboardPageDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView(
        scrollDirection: Axis.vertical,
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        children: const [
          ProximasRevisoesWidget(),
          DesempenhoWidget(),
          FrasesWidget()
        ],
      ),
    );
  }
}