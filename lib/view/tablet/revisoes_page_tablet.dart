import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../controllers/revisoes_controller.dart';
import '../../states/revisao_item_state.dart';
import '../../stores/area_store.dart';
import '../components/revisao_card_widget.dart';

class RevisoesPageTablet extends StatelessWidget {
  final revisoesController = GetIt.I<RevisoesController>();
  final areaStore = GetIt.I<AreaStore>();
  RevisoesPageTablet({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<RevisaoItemState>(
        valueListenable: revisoesController,
        builder: (child, value, context) {
          if (value is SuccessRevisaoItemState) {
            return ListView.builder(
              itemCount: value.revisoes.length,
              itemBuilder: (context, index){
                    String area = areaStore.areas.firstWhere((element) => element.id == value.revisoes[index].conteudo.areaId).nome;
                    return RevisaoCardWidget(revisao: value.revisoes[index], area: area,);
                  }
            );
          } else
            return Container();
        });
  }
}