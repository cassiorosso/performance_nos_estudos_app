import 'package:flutter/material.dart';
import 'package:performance_nos_estudos_app/models/revisao_item_model.dart';

class RevisaoCardWidget extends StatelessWidget {
  final RevisaoItemModel revisao;
  final String area;
  const RevisaoCardWidget(
      {super.key, required this.revisao, required this.area});

  @override
  Widget build(BuildContext context) {
    String fase = "Fase";
    Color? corFase = Colors.black;
    if (revisao.acerto < 50) {
      fase = "Fase 1";
      corFase = Colors.red;
    } else if (revisao.acerto >= 50 && revisao.acerto < 80) {
      fase = "Fase 2";
      corFase = Colors.yellow[900];
    } else {
      fase = "Fase 3";
      corFase = Colors.green[700];
    }
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                flex: 3,
                child: RichText(
                  text: TextSpan(
                    text: "${revisao.conteudo.nome}\n",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    children: [
                      TextSpan(
                          text: "$area\n",
                          style: const TextStyle(
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.italic)),
                      WidgetSpan(
                          child: Container(
                        decoration: BoxDecoration(
                            color: corFase,
                            borderRadius: const BorderRadius.all(Radius.circular(20))),
                        padding: const EdgeInsets.fromLTRB(5,2,5,2),
                        margin: const EdgeInsets.only(top: 4),
                        child: Text(
                          fase,
                          style: const TextStyle(
                              fontWeight: FontWeight.w300, color: Colors.white, fontSize: 12),
                        ),
                      )),
                    ],
                  ),
                )),
            Expanded(
                flex: 3,
                child: Text(
                    "${revisao.data.day}/${revisao.data.month}/${revisao.data.year}",
                    textAlign: TextAlign.center)),
            Expanded(
                flex: 2,
                child: Text("${revisao.acerto}%", textAlign: TextAlign.center)),
            Expanded(
                flex: 3,
                child: Text(
                    "${revisao.dataProxima.day}/${revisao.dataProxima.month}/${revisao.dataProxima.year}",
                    textAlign: TextAlign.center)),
            const Expanded(
                flex: 1,
                child: Align(
                    alignment: Alignment.centerRight,
                    child: Icon(Icons.check_circle_outline_outlined))),
            const Expanded(
                flex: 1,
                child: Align(
                    alignment: Alignment.centerRight,
                    child: Icon(Icons.delete)))
          ],
        ),
      ),
    );
  }
}
