import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:performance_nos_estudos_app/controllers/revisoes_controller.dart';
import 'package:performance_nos_estudos_app/states/revisao_item_state.dart';
import 'package:performance_nos_estudos_app/stores/area_store.dart';
import 'package:performance_nos_estudos_app/view/components/revisao_card_widget.dart';
import 'package:performance_nos_estudos_app/view/components/revisoes_legenda_widget.dart';

class RevisoesPage extends StatelessWidget {
  final revisoesController = GetIt.I<RevisoesController>();
  final areaStore = GetIt.I<AreaStore>();
  RevisoesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ListView(
      children: [
        const RevisoesLegenda(),
        ValueListenableBuilder<RevisaoItemState>(
            valueListenable: revisoesController,
            builder: (child, value, context) {
              if (value is LoadingRevisaoItemState) {
                return const CircularProgressIndicator();
              } else if (value is SuccessRevisaoItemState) {
                return ListView.builder(
                  physics: const ScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: value.revisoes.length,
                  itemBuilder: (context, index) {
                    String area = areaStore.areas
                        .firstWhere((element) =>
                            element.id == value.revisoes[index].conteudo.areaId)
                        .nome;
                    return RevisaoCardWidget(
                      revisao: value.revisoes[index],
                      area: area,
                    );
                  },
                );
              }
              return Container();
            })
      ],
    ));
  }
}
