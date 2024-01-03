import 'dart:convert';

ConteudoModel conteudoModelFromJson(String str) => ConteudoModel.fromJson(json.decode(str));

String conteudoModelToJson(ConteudoModel data) => json.encode(data.toJson());

class ConteudoModel {
    int? id;
    int? areaId;
    String nome;
    String usuarioId;

    ConteudoModel({
        this.id,
        this.areaId,
        required this.nome,
        required this.usuarioId,
    });

    factory ConteudoModel.fromJson(Map<String, dynamic> json) => ConteudoModel(
        id: json["id"],
        areaId: json["area_id"],
        nome: json["nome"],
        usuarioId: json["usuario_id"], 
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "area_id": areaId,
        "nome": nome,
       "usuario_id": usuarioId,
    };
}