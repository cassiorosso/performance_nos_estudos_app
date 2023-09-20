import 'dart:convert';

UsuarioModel usuarioModelFromJson(String str) => UsuarioModel.fromJson(json.decode(str));

String usuarioModelToJson(UsuarioModel data) => json.encode(data.toJson());

class UsuarioModel {
    int id;
    int instituicaoId;
    String telefone;
    String nome;
    String email;

    UsuarioModel({
        required this.id,
        required this.instituicaoId,
        required this.telefone,
        required this.nome,
        required this.email,
    });

    factory UsuarioModel.fromJson(Map<String, dynamic> json) => UsuarioModel(
        id: json["id"],
        instituicaoId: json["instituicao_id"],
        telefone: json["telefone"],
        nome: json["nome"],
        email: json["email"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "instituicao_id": instituicaoId,
        "telefone": telefone,
        "nome": nome,
        "email": email,
    };
}