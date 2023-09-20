

import '../models/usuario_model.dart';

abstract class UsuarioState {}

class SuccessUsuarioState extends UsuarioState {
  final List<UsuarioModel> revisoes;

  SuccessUsuarioState({required this.revisoes});
}

class ErrorUsuarioState extends UsuarioState {
  final String errorMessage;

  ErrorUsuarioState({required this.errorMessage});

}

class LoadingUsuarioState extends UsuarioState {}