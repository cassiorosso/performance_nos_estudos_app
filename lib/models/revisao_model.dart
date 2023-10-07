import 'dart:convert';

RevisaoModel revisaoModelFromJson(String str) => RevisaoModel.fromJson(json.decode(str));

String revisaoModelToJson(RevisaoModel data) => json.encode(data.toJson());

class RevisaoModel {
    int acerto;
    bool concluida;
    int? conteudoId;
    DateTime data;
    DateTime dataProxima;
    int? id;
    int usuarioId;

    RevisaoModel({
        required this.acerto,
        required this.concluida,
        this.conteudoId,
        required this.data,
        required this.dataProxima,
        this.id,
        required this.usuarioId,
    });

    factory RevisaoModel.fromJson(Map<String, dynamic> json) => RevisaoModel(
        acerto: json["acerto"],
        concluida: json["concluida"],
        conteudoId: json["conteudo_id"],
        data: DateTime.parse(json["data"]),
        dataProxima: DateTime.parse(json["data_proxima"]),
        id: json["id"],
        usuarioId: json["usuario_id"],
    );

    Map<String, dynamic> toJson() => {
        "acerto": acerto,
        "concluida": concluida,
        "conteudo_id": conteudoId,
        "data": "${data.year.toString().padLeft(4, '0')}-${data.month.toString().padLeft(2, '0')}-${data.day.toString().padLeft(2, '0')}",
        "data_proxima": "${dataProxima.year.toString().padLeft(4, '0')}-${dataProxima.month.toString().padLeft(2, '0')}-${dataProxima.day.toString().padLeft(2, '0')}",
        "id": id,
        "usuario_id": usuarioId,
    };
}