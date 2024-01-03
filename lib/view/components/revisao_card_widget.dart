import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:performance_nos_estudos_app/models/revisao_item_model.dart';
import 'package:performance_nos_estudos_app/view/components/confirmation_dialog.dart';
import 'package:performance_nos_estudos_app/view/components/edit_name_dialog.dart';
import 'package:performance_nos_estudos_app/view/components/edita_acerto_dialog.dart';
import 'package:performance_nos_estudos_app/view/components/nova_revisao_dialog.dart';

import '../../controllers/revisoes_controller.dart';

class RevisaoCardWidget extends StatelessWidget {
  final RevisaoItemModel revisao;
  final revisoesController = GetIt.I<RevisoesController>();
  final String area;
  RevisaoCardWidget({super.key, required this.revisao, required this.area});

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
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(revisao.conteudo.nome,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14)),
                    Text(area,
                        style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.italic)),
                    Container(
                      decoration: BoxDecoration(
                          color: corFase,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20))),
                      padding: const EdgeInsets.fromLTRB(5, 2, 5, 2),
                      margin: const EdgeInsets.only(top: 4),
                      child: Text(
                        fase,
                        style: const TextStyle(
                            fontWeight: FontWeight.w300,
                            color: Colors.white,
                            fontSize: 12),
                      ),
                    )
                  ],
                )),
            Expanded(
                flex: 3,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                      "${revisao.data.day}/${revisao.data.month}/${revisao.data.year.toString().substring(2)}",
                      textAlign: TextAlign.center),
                )),
            Expanded(
                flex: 3,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Text(
                        "${revisao.acerto}%",
                        style: const TextStyle(color: Colors.black),
                      ),
                    ),
                    FittedBox(
                      fit: BoxFit.contain,
                      child: InkWell(
                        onTap: () => showDialog(
                            context: context,
                            builder: (context) {
                              return DialogEditAcerto(revisaoId: revisao.id);
                            }),
                        child: Icon(
                          Icons.edit,
                          size: 12,
                          color: Colors.grey[400],
                        ),
                      ),
                    )
                  ],
                )),
            Expanded(
                flex: 4,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(),
                        PopupMenuButton(
                            child: Icon(
                              Icons.more_horiz,
                              color: Colors.grey[400],
                            ),
                            onSelected: (value) {
                              switch (value) {
                                case 'edit':
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return DialogEditName(
                                            conteudoId: revisao.conteudoId);
                                      });
                                case 'delete':
                                  showDialog(
                                      context: context,
                                      builder: (context) => ConfirmationDialog(
                                          conteudoId: revisao.conteudoId));
                              }
                            },
                            itemBuilder: (BuildContext context) {
                              return const [
                                PopupMenuItem(
                                  value: 'edit',
                                  child: Text("Editar nome de conteúdo"),
                                ),
                                PopupMenuItem(
                                  value: 'delete',
                                  child: Text("Deletar conteúdo"),
                                )
                              ];
                            })
                      ],
                    ),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                          "${revisao.dataProxima.day}/${revisao.dataProxima.month}/${revisao.dataProxima.year.toString()}",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    ElevatedButton(
                        onPressed: () => showDialog(
                            context: context,
                            builder: (context) =>
                                NovaRevisaoDialog(revisao: revisao)),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green[800]),
                        child: const FittedBox(
                          fit: BoxFit.cover,
                          child: Text(
                            "Concluir\nRevisão",
                            style: TextStyle(color: Colors.white, fontSize: 12),
                            textAlign: TextAlign.center,
                          ),
                        ))
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
