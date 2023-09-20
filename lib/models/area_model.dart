import 'dart:convert';

AreaModel areaModelFromJson(String str) => AreaModel.fromJson(json.decode(str));

String areaModelToJson(AreaModel data) => json.encode(data.toJson());

class AreaModel {
    int id;
    String nome;

    AreaModel({
        required this.id,
        required this.nome,
    });

    factory AreaModel.fromJson(Map<String, dynamic> json) => AreaModel(
        id: json["id"],
        nome: json["nome"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nome": nome,
    };
}