import 'package:performance_nos_estudos_app/models/revisao_item_model.dart';

abstract class RevisaoItemState {}

class SuccessRevisaoItemState extends RevisaoItemState {
  final List<RevisaoItemModel> revisoes;

  SuccessRevisaoItemState({required this.revisoes});
}

class ErrorRevisaoItemState extends RevisaoItemState {
  final String errorMessage;

  ErrorRevisaoItemState({required this.errorMessage});

}

class LoadingRevisaoItemState extends RevisaoItemState {}
