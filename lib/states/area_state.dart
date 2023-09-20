import '../models/area_model.dart';

abstract class AreaState {}

class SuccessAreaState extends AreaState {
  final List<AreaModel> areas;

  SuccessAreaState({required this.areas});
}

class ErrorAreaState extends AreaState {
  final String errorMessage;

  ErrorAreaState({required this.errorMessage});

}

class LoadingAreaState extends AreaState {}