import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:performance_nos_estudos_app/models/area_model.dart';
import 'package:performance_nos_estudos_app/models/conteudo_model.dart';
import 'package:performance_nos_estudos_app/models/revisao_item_model.dart';
import 'package:performance_nos_estudos_app/models/revisao_model.dart';
import 'package:performance_nos_estudos_app/services/database_service.dart';
import 'package:performance_nos_estudos_app/states/revisao_item_state.dart';
import 'package:performance_nos_estudos_app/stores/area_store.dart';

class RevisoesController extends ValueNotifier<RevisaoItemState> {
  final _service = GetIt.I<IDatabase>();
  final areaStore = GetIt.I<AreaStore>();
  List<AreaModel> areas = GetIt.I<AreaStore>().areas;
  List<RevisaoItemModel> revisoes = [];
  int usuarioId = 1; //PROVISÓRIO
  int offset = 0;

  RevisoesController() : super(LoadingRevisaoItemState()) {
    listRevisoes();
  }

  Future listRevisoes() async {
    value = LoadingRevisaoItemState();
    try {
      areaStore.fetchAreas();
      var response = await _service.fetchRevisoesEmAndamento(
          usuarioId: usuarioId, offset: offset);
      revisoes = List.generate(response.length,
          (index) => RevisaoItemModel.fromJson(response[index]));

      value = SuccessRevisaoItemState(revisoes: revisoes);
    } on Exception catch (exception) {
      value = ErrorRevisaoItemState(errorMessage: exception.toString());
    } catch (error) {
      value = ErrorRevisaoItemState(errorMessage: error.toString());
    }
  }

  Future createConteudoRevisao(
      {required ConteudoModel conteudo, required RevisaoModel revisao}) async {
    value = LoadingRevisaoItemState();
    try {
      var responseConteudoId = await _service.createConteudoRevisao(
          revisao: revisao, conteudo: conteudo);
      conteudo.id = responseConteudoId["conteudoId"];
      revisao.conteudoId = responseConteudoId["conteudoId"];
      revisao.id = responseConteudoId["revisaoId"];
      revisoes.add(RevisaoItemModel(
          acerto: revisao.acerto,
          concluida: revisao.concluida,
          conteudoId: revisao.conteudoId,
          dataProxima: revisao.dataProxima,
          data: revisao.data,
          id: revisao.id!,
          usuarioId: usuarioId,
          conteudo: conteudo));
      value = SuccessRevisaoItemState(revisoes: revisoes);
    } on Exception catch (exception) {
      value = ErrorRevisaoItemState(errorMessage: exception.toString());
    } catch (error) {
      value = ErrorRevisaoItemState(errorMessage: error.toString());
    }
  }

  Future createRevisao(
      {required ConteudoModel conteudo,
      required RevisaoModel revisao,
      required lastRevisaoId}) async {
    try {
      int revisaoId = await _service.createRevisao(revisao: revisao);
      revisao.id = revisaoId;
      if (await _service.concludeRevisao(revisaoId: lastRevisaoId) == true) {
        int oldRevisaoIndex =
            revisoes.indexWhere((element) => element.id == lastRevisaoId);
        revisoes[oldRevisaoIndex] = RevisaoItemModel(
            acerto: revisao.acerto,
            concluida: revisao.concluida,
            conteudoId: revisao.conteudoId,
            dataProxima: revisao.dataProxima,
            data: revisao.data,
            id: revisao.id!,
            usuarioId: usuarioId,
            conteudo: conteudo);
      }
      value = SuccessRevisaoItemState(revisoes: revisoes);
    } on Exception catch (exception) {
      value = ErrorRevisaoItemState(errorMessage: exception.toString());
    } catch (error) {
      value = ErrorRevisaoItemState(errorMessage: error.toString());
    }
  }

  int calculateAcerto(
      {required int questoesCertas, required int totalQuestoes}) {
    return (questoesCertas / totalQuestoes).round();
  }

  DateTime calculateDate({required DateTime date, required int acerto}) {
    DateTime dataProximaRevisao;
    if (acerto < 0.5) {
      dataProximaRevisao = date.add(const Duration(days: 3));
    } else if (acerto < 0.8 && acerto >= 0.5) {
      dataProximaRevisao = date.add(const Duration(days: 14));
    } else {
      dataProximaRevisao = date.add(const Duration(days: 32));
    }
    return dataProximaRevisao;
  }

  editConteudoName({required String name, required int conteudoId}) async {
    try {
      if (await _service.editConteudoName(id: conteudoId, name: name) == true) {
        revisoes
            .firstWhere((element) => element.conteudoId == conteudoId)
            .conteudo
            .nome = name;
        value = SuccessRevisaoItemState(revisoes: revisoes);
      }
    } on Exception catch (exception) {
      value = ErrorRevisaoItemState(errorMessage: exception.toString());
    } catch (error) {
      value = ErrorRevisaoItemState(errorMessage: error.toString());
    }
  }

  editAcertoRevisao({required int acerto, required int revisaoId}) async {
    try {
      if (await _service.editAcertoRevisao(
              acerto: acerto, revisaoId: revisaoId) ==
          true) {
        revisoes.firstWhere((element) => element.id == revisaoId).acerto =
            acerto;
        value = SuccessRevisaoItemState(revisoes: revisoes);
      }
    } on Exception catch (exception) {
      value = ErrorRevisaoItemState(errorMessage: exception.toString());
    } catch (error) {
      value = ErrorRevisaoItemState(errorMessage: error.toString());
    }
  }

  deleteConteudoRevisao({required int conteudoId}) async {
    try {
      if (await _service.deleteConteudoRevisoes(conteudoId: conteudoId) ==
          true) {
        revisoes.removeWhere((element) => element.conteudoId == conteudoId);
        value = SuccessRevisaoItemState(revisoes: revisoes);
      }
    } on Exception catch (exception) {
      value = ErrorRevisaoItemState(errorMessage: exception.toString());
    } catch (error) {
      value = ErrorRevisaoItemState(errorMessage: error.toString());
    }
  }

  editArea({required int id, required int areaId}) async {
    try {
      if (await _service.editConteudoArea(areaId: areaId, id: id) == true) {
        revisoes
            .firstWhere((element) => element.conteudo.id == id)
            .conteudo
            .areaId = areaId;
        value = SuccessRevisaoItemState(revisoes: revisoes);
      }
    } on Exception catch (exception) {
      value = ErrorRevisaoItemState(errorMessage: exception.toString());
    } catch (error) {
      value = ErrorRevisaoItemState(errorMessage: error.toString());
    }
  }
}
