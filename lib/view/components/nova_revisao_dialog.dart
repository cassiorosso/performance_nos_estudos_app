import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:performance_nos_estudos_app/models/revisao_item_model.dart';
import 'package:performance_nos_estudos_app/models/revisao_model.dart';

import '../../controllers/revisoes_controller.dart';

class NovaRevisaoDialog extends StatefulWidget {
  final RevisaoItemModel revisao;
  const NovaRevisaoDialog({super.key, required this.revisao});

  @override
  State<NovaRevisaoDialog> createState() => _NovaRevisaoDialogState();
}

class _NovaRevisaoDialogState extends State<NovaRevisaoDialog> {
  final revisoesController = GetIt.I<RevisoesController>();
  final TextEditingController _controllerDate = TextEditingController();
  late DateTime data;
  String acerto = "";
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: Icon(
              Icons.add,
            ),
          ),
          Flexible(
            child: Text(
              "Nova revisão",
              style: TextStyle(fontSize: 15),
              textAlign: TextAlign.left,
            ),
          ),
        ],
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Flexible(
                child: Text("\nData de conclusão")),
            TextField(
              controller: _controllerDate,
              readOnly: true,
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                    locale: const Locale('pt', 'BR'),
                    context: context,
                    initialEntryMode: DatePickerEntryMode.calendarOnly,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2023),
                    lastDate: DateTime(2035));
                if (pickedDate != null) {
                  setState(() {
                    _controllerDate.text =
                        revisoesController.formattedDate(pickedDate);
                    data = pickedDate;
                  });
                }
              },
              decoration: InputDecoration(
                hintText: "Ex.: 12/12/2022",
                helperText:
                    "Data recomendada: ${revisoesController.formattedDate(widget.revisao.dataProxima)}",
                border: const OutlineInputBorder(),
              ),
            ),
            const Flexible(
                child: Text("\nPorcentagem de acerto")),
            TextField(
              decoration: const InputDecoration(
                hintText: "Ex.: 50%",
                border: OutlineInputBorder(),
                suffix: Text("%"),
                isDense: true,
              ),
              inputFormatters: [
                FilteringTextInputFormatter.allow((RegExp("[0-9]")))
              ],
              onChanged: (value) {
                setState(() {
                  if (double.parse(value) > 100 || double.parse(value) < 1) {
                    acerto = "";
                  } else {
                    acerto = value;
                  }
                });
              },
            )
          ],
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style:
                  ElevatedButton.styleFrom(backgroundColor: Colors.blue[800]),
              child: const Text("Cancelar",
                  style: TextStyle(color: Colors.white))),
        ),
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: ElevatedButton(
              onPressed: _controllerDate.text == ""
                  ? null
                  : acerto == ""
                      ? null
                      : () {
                          int acertoInt = double.parse(acerto).round();
                          DateTime dataProxima = revisoesController
                              .calculateDate(date: data, acerto: acertoInt);
                          RevisaoModel novaRevisao = RevisaoModel(
                              acerto: acertoInt,
                              concluida: false,
                              conteudoId: widget.revisao.conteudoId,
                              data: data,
                              dataProxima: dataProxima,
                              usuarioId: widget.revisao.usuarioId);
                          revisoesController.createRevisao(
                              conteudo: widget.revisao.conteudo,
                              revisao: novaRevisao,
                              lastRevisaoId: widget.revisao.id);
                          Navigator.pop(context);
                        },
              style:
                  ElevatedButton.styleFrom(backgroundColor: Colors.blue[800]),
              child: const Text(
                "Confirmar",
                style: TextStyle(color: Colors.white),
              )),
        )
      ],
    );
  }
}
