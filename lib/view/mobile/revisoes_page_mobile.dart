import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../controllers/revisoes_controller.dart';
import '../../states/revisao_item_state.dart';
import '../../stores/area_store.dart';
import '../components/error_widget.dart';
import '../components/loading_widget.dart';
import '../components/new_button_widget.dart';
import '../components/revisao_card_widget.dart';
import '../components/revisoes_legenda_widget.dart';

class RevisoesPageMobile extends StatefulWidget {

  const RevisoesPageMobile({super.key});

  @override
  State<RevisoesPageMobile> createState() => _RevisoesPageMobileState();
}

class _RevisoesPageMobileState extends State<RevisoesPageMobile> {
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
    return SingleChildScrollView(
      child: Column(
        children: [
          const NewButtonWidget(),
          const RevisoesLegenda(),
          ValueListenableBuilder<RevisaoItemState>(
              valueListenable: revisoesController,
              builder: (child, value, context) {
                if (value is LoadingRevisaoItemState) {
                  return const LoadingWidget();
                } else if (value is SuccessRevisaoItemState) {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    controller: _scrollController,
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
                } else if (value is ErrorRevisaoItemState) {
                      return ErrorCustomWidget(errorMessage: value.errorMessage, indexButton: 0,);
                    }
                    return Container();
              }),
        ],
      ),
    );
  }
}
