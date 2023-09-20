import 'dart:convert';

import 'package:performance_nos_estudos_app/models/conteudo_model.dart';

RevisaoItemModel revisaoItemModelFromJson(String str) => RevisaoItemModel.fromJson(json.decode(str));

String revisaoItemModelToJson(RevisaoItemModel data) => json.encode(data.toJson());

class RevisaoItemModel {
    int acerto;
    bool concluida;
    int conteudoId;
    DateTime dataProxima;
    DateTime data;
    int id;
    int usuarioId;
    ConteudoModel conteudo;

    RevisaoItemModel({
        required this.acerto,
        required this.concluida,
        required this.conteudoId,
        required this.dataProxima,
        required this.data,
        required this.id,
        required this.usuarioId,
        required this.conteudo,
    });

    factory RevisaoItemModel.fromJson(Map<String, dynamic> json) => RevisaoItemModel(
        acerto: json["acerto"],
        concluida: json["concluida"],
        conteudoId: json["conteudo_id"],
        dataProxima: DateTime.parse(json["data_proxima"]),
        data: DateTime.parse(json["data"]),
        id: json["id"],
        usuarioId: json["usuario_id"],
        conteudo: ConteudoModel.fromJson(json["conteudo"]),
    );

    Map<String, dynamic> toJson() => {
        "acerto": acerto,
        "concluida": concluida,
        "conteudo_id": conteudoId,
        "data_proxima": "${dataProxima.year.toString().padLeft(4, '0')}-${dataProxima.month.toString().padLeft(2, '0')}-${dataProxima.day.toString().padLeft(2, '0')}",
        "data": "${data.year.toString().padLeft(4, '0')}-${data.month.toString().padLeft(2, '0')}-${data.day.toString().padLeft(2, '0')}",
        "id": id,
        "usuario_id": usuarioId,
        "conteudo": conteudo.toJson(),
    };
}