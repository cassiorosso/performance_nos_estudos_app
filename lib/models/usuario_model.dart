import 'dart:convert';

UsuarioModel usuarioModelFromJson(String str) => UsuarioModel.fromJson(json.decode(str));

String usuarioModelToJson(UsuarioModel data) => json.encode(data.toJson());

class UsuarioModel {
    final String email;
    final String id;
    final String nome;
    final bool? emailVerified;
    final int? instituicaoId;
    final dynamic subscriptionDate;
    final dynamic telefone;
    final DateTime? trialDate;

    UsuarioModel({
        required this.email,
        required this.id,
        required this.nome,
        this.emailVerified,
        this.instituicaoId,
        this.subscriptionDate,
        this.telefone,
        this.trialDate,
    });

    factory UsuarioModel.fromJson(Map<String, dynamic> json) => UsuarioModel(
        email: json["email"],
        id: json["id"],
        nome: json["nome"],
        emailVerified: json["email_verified"],
        instituicaoId: json["instituicao_id"],
        subscriptionDate: json["subscription_date"],
        telefone: json["telefone"],
        trialDate: json["trial_date"] == null ? null : DateTime.parse(json["trial_date"]),
    );

    Map<String, dynamic> toJson() => {
        "email": email,
        "id": id,
        "nome": nome,
        "email_verified": emailVerified,
        "instituicao_id": instituicaoId,
        "subscription_date": subscriptionDate,
        "telefone": telefone,
        "trial_date": "${trialDate!.year.toString().padLeft(4, '0')}-${trialDate!.month.toString().padLeft(2, '0')}-${trialDate!.day.toString().padLeft(2, '0')}",
    };
}
