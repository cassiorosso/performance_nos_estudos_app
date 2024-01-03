import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:performance_nos_estudos_app/models/conteudo_model.dart';
import 'package:performance_nos_estudos_app/states/conteudo_state.dart';

import '../services/database_service.dart';

class DashboardController extends ValueNotifier<ConteudoState> {
  final _service = GetIt.I<IDatabase>();
  ValueNotifier<List<ConteudoModel>> conteudos =
      ValueNotifier<List<ConteudoModel>>([]);
  List<String> datas = [];

  DashboardController() : super(LoadingConteudoState()) {
    //getConteudos();
  }

  getConteudos() async {
    value = LoadingConteudoState();
    try {
      var response = await _service.fetchConteudos();
      conteudos.value = List.generate(
          response.length, (index) => ConteudoModel.fromJson(response[index]));
      if (conteudos.value.isNotEmpty) {
        getDataConteudo(conteudos.value[0].id!);
      } else {
        value = EmptyConteudoState();
      }
    } on Exception catch (exception) {
      value = ErrorConteudoState(errorMessage: exception.toString());
    } catch (error) {
      value = ErrorConteudoState(errorMessage: error.toString());
    }
  }

  getDataConteudo(int conteudoId) async {
    value = LoadingConteudoState();
    try {
      var response = await _service.fetchConteudo(conteudoId);
      datas =
          List.generate(response.length, (index) => response[index]["data"]);
      List<FlSpot> spots = List.generate(
          response.length,
          (index) =>
              //FlSpot(response[index]["data"], response[index]["acerto"].toDouble()));
              FlSpot(index.toDouble(), response[index]["acerto"].toDouble()));
      if (spots.isEmpty) {
        value = EmptyConteudoState();
      } else {
        value = SuccessConteudoState(conteudoSpots: spots);
      }
    } on Exception catch (exception) {
      value = ErrorConteudoState(errorMessage: exception.toString());
    } catch (error) {
      value = ErrorConteudoState(errorMessage: error.toString());
    }
  }
}
