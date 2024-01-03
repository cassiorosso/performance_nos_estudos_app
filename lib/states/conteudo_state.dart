import 'package:fl_chart/fl_chart.dart';

abstract class ConteudoState {}

class SuccessConteudoState extends ConteudoState {
  final List<FlSpot> conteudoSpots;

  SuccessConteudoState({required this.conteudoSpots});
}

class ErrorConteudoState extends ConteudoState {
  final String errorMessage;

  ErrorConteudoState({required this.errorMessage});

}

class EmptyConteudoState extends ConteudoState {}

class LoadingConteudoState extends ConteudoState {}