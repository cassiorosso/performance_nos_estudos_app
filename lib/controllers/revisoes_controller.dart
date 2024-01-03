import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:performance_nos_estudos_app/models/area_model.dart';
import 'package:performance_nos_estudos_app/models/conteudo_model.dart';
import 'package:performance_nos_estudos_app/models/event_model.dart';
import 'package:performance_nos_estudos_app/models/revisao_item_model.dart';
import 'package:performance_nos_estudos_app/models/revisao_model.dart';
import 'package:performance_nos_estudos_app/services/database_service.dart';
import 'package:performance_nos_estudos_app/states/revisao_item_state.dart';
import 'package:performance_nos_estudos_app/stores/area_store.dart';
import 'package:performance_nos_estudos_app/stores/user_store.dart';
import 'package:table_calendar/table_calendar.dart';

class RevisoesController extends ValueNotifier<RevisaoItemState> {
  final _service = GetIt.I<IDatabase>();
  final areaStore = GetIt.I<AreaStore>();
  final usuarioStore = GetIt.I<UsuarioStore>();
  List<AreaModel> areas = GetIt.I<AreaStore>().areas;
  List<RevisaoItemModel> revisoes = [];
  int offset = 0;
  int limit = 40;

  RevisoesController() : super(LoadingRevisaoItemState()) {
    listRevisoes();
  }

  Future listRevisoes() async {
    if (revisoes.length == offset) {
      value = LoadingRevisaoItemState();
      try {
        areaStore.fetchAreas();
        var response = await _service.fetchRevisoesEmAndamento(
            usuarioId: usuarioStore.user.id, offset: offset, limit: limit);
        List<RevisaoItemModel> listFromDatabase = [];
        listFromDatabase = List.generate(response.length,
            (index) => RevisaoItemModel.fromJson(response[index]));
        if (listFromDatabase.length == 40) {
          offset = offset + 40;
        }
        revisoes.addAll(listFromDatabase);
        value = SuccessRevisaoItemState(revisoes: revisoes);
      } on Exception catch (exception) {
        value = ErrorRevisaoItemState(errorMessage: exception.toString());
      } catch (error) {
        value = ErrorRevisaoItemState(errorMessage: error.toString());
      }
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
      revisoes.insert(
          0,
          RevisaoItemModel(
              acerto: revisao.acerto,
              concluida: revisao.concluida,
              conteudoId: revisao.conteudoId!,
              dataProxima: revisao.dataProxima,
              data: revisao.data,
              id: revisao.id!,
              usuarioId: usuarioStore.user.id,
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
    value = LoadingRevisaoItemState();
    try {
      int revisaoId = await _service.createRevisao(revisao: revisao);
      revisao.id = revisaoId;
      if (await _service.concludeRevisao(revisaoId: lastRevisaoId) == true) {
        int oldRevisaoIndex =
            revisoes.indexWhere((element) => element.id == lastRevisaoId);
        revisoes[oldRevisaoIndex] = RevisaoItemModel(
            acerto: revisao.acerto,
            concluida: revisao.concluida,
            conteudoId: revisao.conteudoId!,
            dataProxima: revisao.dataProxima,
            data: revisao.data,
            id: revisao.id!,
            usuarioId: usuarioStore.user.id,
            conteudo: conteudo);
      }
      value = SuccessRevisaoItemState(revisoes: revisoes);
    } on Exception catch (exception) {
      value = ErrorRevisaoItemState(errorMessage: exception.toString());
    } catch (error) {
      value = ErrorRevisaoItemState(errorMessage: error.toString());
    }
  }

  String formattedDate(DateTime date) {
    return "${date.day}/${date.month}/${date.year}".toString();
  }

  int calculateAcerto(
      {required int questoesCertas, required int totalQuestoes}) {
    return (questoesCertas / totalQuestoes).round();
  }

  DateTime calculateDate({required DateTime date, required int acerto}) {
    DateTime dataProximaRevisao;
    if (acerto < 40) {
      dataProximaRevisao = date.add(const Duration(days: 3));
    } else if (acerto < 60 && acerto >= 40) {
      dataProximaRevisao = date.add(const Duration(days: 10));
    } else if (acerto < 80 && acerto >= 60) {
      dataProximaRevisao = date.add(const Duration(days: 21));
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

  LinkedHashMap<DateTime, List<EventModel>> calendarRevisoesFormat() {
    Map<DateTime, List<EventModel>> formatCalendar = {};

    for (var element in revisoes) {
      if (formatCalendar.containsKey(element.dataProxima)) {
        formatCalendar[element.dataProxima]
            ?.add(EventModel(element.conteudo.nome));
      } else {
        formatCalendar[element.dataProxima] = [
          EventModel(element.conteudo.nome)
        ];
      }
    }

    return LinkedHashMap<DateTime, List<EventModel>>(
      equals: isSameDay,
      hashCode: getHashCode,
    )..addAll(formatCalendar);
  }

  int getHashCode(DateTime key) {
    return key.day * 1000000 + key.month * 10000 + key.year;
  }
}
