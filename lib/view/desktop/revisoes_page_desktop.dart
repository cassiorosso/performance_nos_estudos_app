import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:performance_nos_estudos_app/controllers/revisoes_controller.dart';
import 'package:performance_nos_estudos_app/states/revisao_item_state.dart';
import 'package:performance_nos_estudos_app/stores/area_store.dart';
import 'package:performance_nos_estudos_app/view/components/loading_widget.dart';
import 'package:performance_nos_estudos_app/view/components/new_button_widget.dart';
import 'package:performance_nos_estudos_app/view/components/revisao_card_widget.dart';
import 'package:performance_nos_estudos_app/view/components/revisoes_legenda_widget.dart';

import '../components/error_widget.dart';

class RevisoesPage extends StatefulWidget {
  const RevisoesPage({super.key});

  @override
  State<RevisoesPage> createState() => _RevisoesPageState();
}

class _RevisoesPageState extends State<RevisoesPage> {
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(infiniteScrolling);
  }

  infiniteScrolling() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      revisoesController.listRevisoes();
    }
  }

  final revisoesController = GetIt.I<RevisoesController>();

  final areaStore = GetIt.I<AreaStore>();

  late final ScrollController _scrollController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const NewButtonWidget(),
        const RevisoesLegenda(),
        ValueListenableBuilder<RevisaoItemState>(
            valueListenable: revisoesController,
            builder: (child, value, context) {
              if (value is LoadingRevisaoItemState) {
                return const LoadingWidget();
              } else if (value is SuccessRevisaoItemState) {
                return Expanded(
                  child: ListView.builder(
                    controller: _scrollController,
                    physics: const ScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: value.revisoes.length,
                    itemBuilder: (context, index) {
                      String area = areaStore.areas
                          .firstWhere((element) =>
                              element.id ==
                              value.revisoes[index].conteudo.areaId)
                          .nome;
                      return RevisaoCardWidget(
                        revisao: value.revisoes[index],
                        area: area,
                      );
                    },
                  ),
                );
              } else if (value is ErrorRevisaoItemState) {
                return ErrorCustomWidget(errorMessage: value.errorMessage, indexButton: 0,);
              }
              return Container();
            }),
      ],
    );
  }
}
