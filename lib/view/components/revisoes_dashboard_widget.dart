import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:performance_nos_estudos_app/view/components/loading_widget.dart';

import '../../controllers/revisoes_controller.dart';
import '../../states/revisao_item_state.dart';

class RevisoesDashboardWidget extends StatelessWidget {
  const RevisoesDashboardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final revisoesController = GetIt.I<RevisoesController>();
    return Card(
      margin: const EdgeInsets.all(10),
      color: Colors.white, //Colors.transparent,
      elevation: 1,
      //color: const Color(0xfff0f2f5),
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(12.0),
            child: Text(
              "Próximas Revisões",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
            ),
          ),
          ValueListenableBuilder<RevisaoItemState>(
              valueListenable: revisoesController,
              builder: (child, value, context) {
                if (value is LoadingRevisaoItemState) {
                  return const LoadingWidget();
                } else if (value is SuccessRevisaoItemState) {
                  if (value.revisoes.isEmpty) {
                    return const Text(
                      "\n\nNenhuma revisão em andamento!",
                      style: TextStyle(
                          fontSize: 17, fontStyle: FontStyle.italic),
                    );
                  }
                  return Expanded(
                    child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount:
                          value.revisoes.length > 8 ? 8 : value.revisoes.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(left: 50),
                          child: Text(
                            "\n• ${value.revisoes[index].conteudo.nome} - ${value.revisoes[index].dataProxima.day}/${value.revisoes[index].dataProxima.month}/${value.revisoes[index].dataProxima.year}",
                            style: const TextStyle(
                                fontSize: 17, fontStyle: FontStyle.italic),
                          ),
                        );
                      },
                    ),
                  );
                }
                return Container();
              }),
          const Padding(
            padding: EdgeInsets.only(bottom:15),
            child: Text("\n“Sucesso é o acúmulo de pequenos esforços repetidos dia a dia”", style: TextStyle(fontStyle: FontStyle.italic, fontSize: 15), textAlign: TextAlign.center,),
          )    
        ],
      ),
    );
  }
}
