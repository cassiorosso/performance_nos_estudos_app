import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:performance_nos_estudos_app/controllers/dashboard_controller.dart';
import 'package:performance_nos_estudos_app/states/conteudo_state.dart';
import 'package:performance_nos_estudos_app/view/components/error_widget.dart';
import 'package:performance_nos_estudos_app/view/components/loading_widget.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class PerformanceChart extends StatelessWidget {
  final _dashboardController = GetIt.I<DashboardController>();
  final GlobalKey<State<StatefulWidget>> _printKey = GlobalKey();

  void _printScreen() {
    Printing.layoutPdf(onLayout: (PdfPageFormat format) async {
      final doc = pw.Document();

      final image = await WidgetWrapper.fromKey(
        key: _printKey,
        pixelRatio: 2.0,
      );

      doc.addPage(pw.Page(
          pageFormat: format,
          build: (pw.Context context) {
            return pw.Center(
              child: pw.Expanded(
                child: pw.Image(image),
              ),
            );
          }));

      return doc.save();
    });
  }

  PerformanceChart({super.key});

  @override
  Widget build(BuildContext context) {
    _dashboardController.getConteudos();

    Widget leftTitleWidgets(double value, TitleMeta meta) {
      const style = TextStyle(
        fontSize: 12,
      );
      return SideTitleWidget(
        axisSide: meta.axisSide,
        child: Text("${value.toString()}%", style: style),
      );
    }

    Widget bottomTitleWidgets(double value, TitleMeta meta) {
      int index = value.toInt();
      String dataString = "";
      if (value < _dashboardController.datas.length) {
        DateTime dataFormat = DateTime.parse(_dashboardController.datas[index]);
        dataString = "${dataFormat.day}/${dataFormat.month}";
      }
      const style = TextStyle(
        fontSize: 12,
      );
      return SideTitleWidget(
        axisSide: meta.axisSide,
        child: Text(dataString, style: style),
        //child: Text("Rev. ${(value + 1).round().toString()}", style: style),
      );
    }

    return Card(
      margin: const EdgeInsets.all(10),
      //color: const Color(0xfff0f2f5),
      color: Colors.white, //Colors.transparent,
      elevation: 1,
      child: RepaintBoundary(
        key: _printKey,
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(12.0),
              child: Text(
                "Desempenho por Matéria",
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              flex: 3,
              child: ValueListenableBuilder(
                  valueListenable: _dashboardController.conteudos,
                  builder: (context, value, child) {
                    if (value.isEmpty) {
                      return Container();
                    }
                    List<DropdownMenuEntry> conteudosEntry = [];
                    for (var element in value) {
                      conteudosEntry.add(DropdownMenuEntry(
                          value: element.id, label: element.nome));
                    }
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        DropdownMenu(
                            leadingIcon: const Icon(Icons.bar_chart_rounded),
                            inputDecorationTheme: const InputDecorationTheme(
                              border: OutlineInputBorder(),
                              isDense: false,
                            ),
                            initialSelection: conteudosEntry.first.value,
                            dropdownMenuEntries: conteudosEntry,
                            onSelected: (value) {
                              _dashboardController.getDataConteudo(value);
                              FocusManager.instance.primaryFocus?.unfocus();
                            }),
                        IconButton(
                            onPressed: _printScreen,
                            icon: const Icon(
                              Icons.picture_as_pdf,
                              color: Colors.red,
                            ))
                      ],
                    );
                  }),
            ),
            Expanded(
              flex: 12,
              child: ValueListenableBuilder(
                  valueListenable: _dashboardController,
                  builder: (context, value, child) {
                    if (value is LoadingConteudoState) {
                      return const LoadingWidget();
                    } else if (value is EmptyConteudoState) {
                      return const Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.bar_chart_rounded,
                            size: 100,
                          ),
                          Text("Sem dados para visualizar...")
                        ],
                      );
                    } else if (value is SuccessConteudoState) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 12, right: 20),
                        child: AspectRatio(
                          aspectRatio: 1.5,
                          child: LineChart(LineChartData(
                              gridData: FlGridData(
                                show: true,
                                drawVerticalLine: true,
                                horizontalInterval: 20,
                                verticalInterval: 1,
                                getDrawingHorizontalLine: (value) {
                                  return FlLine(
                                    color:
                                        Colors.grey[800]!, // Color(0xffcedcf2),
                                    strokeWidth: 1,
                                  );
                                },
                                getDrawingVerticalLine: (value) {
                                  return FlLine(
                                    color:
                                        Colors.grey[800]!, //Color(0xffcedcf2),
                                    strokeWidth: 1,
                                  );
                                },
                              ),
                              backgroundColor: const Color(
                                  0x0fffffff), //const Color(0xff1a2338),
                              borderData: FlBorderData(
                                show: true,
                                border: Border.all(
                                    color: Colors.grey[800]!),//const Color(0xffcedcf2)), //const Color(0xff37434d)),
                              ),
                              minX: 0,
                              maxX: value.conteudoSpots.length.toDouble(),
                              minY: 0,
                              maxY: 100,
                              titlesData: FlTitlesData(
                                show: true,
                                bottomTitles: AxisTitles(
                                    sideTitles: SideTitles(
                                        reservedSize: 50,
                                        interval: 1,
                                        showTitles: true,
                                        getTitlesWidget: bottomTitleWidgets)),
                                leftTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                    reservedSize: 45,
                                    interval: 50,
                                    showTitles: true,
                                    getTitlesWidget: leftTitleWidgets,
                                  ),
                                ),
                                topTitles: const AxisTitles(
                                  //axisNameSize: 25,
                                  //axisNameWidget: Text('Desempenho de Acertos em revisões'),
                                  sideTitles: SideTitles(showTitles: false),
                                ),
                                rightTitles: const AxisTitles(
                                  sideTitles: SideTitles(showTitles: false),
                                ),
                              ),
                              lineBarsData: [
                                LineChartBarData(
                                  belowBarData: BarAreaData(
                                      show: true,
                                      color: const Color(0xffd5e2f5)),
                                  curveSmoothness: 0.05,
                                  dotData: const FlDotData(show: true),
                                  spots: value.conteudoSpots,
                                  isCurved: true,
                                )
                              ])),
                        ),
                      );
                    } else if (value is ErrorConteudoState) {
                      return ErrorCustomWidget(
                        errorMessage: value.errorMessage,
                        indexButton: 1,
                      );
                    }
                    return Container();
                  }),
            )
          ],
        ),
      ),
    );
  }
}
