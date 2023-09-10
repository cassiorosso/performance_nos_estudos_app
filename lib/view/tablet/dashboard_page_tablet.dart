import 'package:flutter/material.dart';

import '../components/desempenho_widget.dart';
import '../components/frases_widget.dart';
import '../components/proximas_revisoes_widget.dart';

class DashboardPageTablet extends StatelessWidget {
  const DashboardPageTablet({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: GridView(
        scrollDirection: Axis.vertical,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2),
        children: const [
          ProximasRevisoesWidget(),
          DesempenhoWidget(),
          FrasesWidget()
        ],
      ),
    );
  }
}