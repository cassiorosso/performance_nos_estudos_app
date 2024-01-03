import 'package:flutter/material.dart';
import 'package:performance_nos_estudos_app/view/components/performance_chart.dart';
import 'package:performance_nos_estudos_app/view/components/revisoes_dashboard_widget.dart';

class DashboardPageDesktop extends StatelessWidget {
  const DashboardPageDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView(
      scrollDirection: Axis.vertical,
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      children: [
        PerformanceChart(),
        const RevisoesDashboardWidget(),
      ],
    );
  }
}
