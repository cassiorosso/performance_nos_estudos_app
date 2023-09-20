import 'package:hasura_connect/hasura_connect.dart';
import 'package:performance_nos_estudos_app/models/conteudo_model.dart';
import 'package:performance_nos_estudos_app/models/revisao_model.dart';

abstract class IDatabase {
  Future fetchRevisoesEmAndamento(
      {required int usuarioId, required int offset});
  Future<Map> createConteudoRevisao(
      {required RevisaoModel revisao, required ConteudoModel conteudo});
  Future createRevisao({required RevisaoModel revisao});
  Future<bool> editConteudoName({required int id, required String name});
  Future<bool> editConteudoArea({required int id, required int areaId});
  Future<bool> concludeRevisao({required int revisaoId});
  Future<bool> editAcertoRevisao({required int revisaoId, required int acerto});
  Future<bool> deleteConteudoRevisoes({required int conteudoId});
  
  Future fetchAreas();
}

class HasuraService implements IDatabase {
  final HasuraConnect _hasuraConnect;
  final _hasuraRequisitions = HasuraRequisitions();

  HasuraService(this._hasuraConnect);

  @override
  Future fetchRevisoesEmAndamento(
      {required int usuarioId, required int offset}) async {
    var response = await _hasuraConnect.query(
        _hasuraRequisitions.queryRevisoesEmAndamento,
        variables: {"usuario_id": usuarioId, "offset": offset});
    return response["data"]["revisoes"] as List;
  }

  @override
  Future<Map> createConteudoRevisao(
      {required RevisaoModel revisao, required ConteudoModel conteudo}) async {
    var response = await _hasuraConnect
        .mutation(_hasuraRequisitions.insertConteudoRevisao, variables: {
      "area_id": conteudo.areaId,
      "nome": conteudo.nome,
      "acerto": revisao.acerto,
      "concluida": revisao.concluida,
      "data":
          "${revisao.data.year.toString().padLeft(4, '0')}-${revisao.data.month.toString().padLeft(2, '0')}-${revisao.data.day.toString().padLeft(2, '0')}",
      "data_proxima":
          "${revisao.dataProxima.year.toString().padLeft(4, '0')}-${revisao.dataProxima.month.toString().padLeft(2, '0')}-${revisao.dataProxima.day.toString().padLeft(2, '0')}",
      "usuario_id": revisao.usuarioId,
    });
    Map<String, int> idMap = {
      "conteudoId": response["data"]["insert_conteudos_one"]["id"],
      "revisaoId": response["data"]["insert_conteudos_one"]["revisoes"][0]["id"]
    };
    return idMap;
  }

  @override
  Future<int> createRevisao({required RevisaoModel revisao}) async {
    var response = await _hasuraConnect
        .mutation(_hasuraRequisitions.createRevisao, variables: {
      "acerto": revisao.acerto,
      "concluida": revisao.concluida,
      "conteudo_id": revisao.conteudoId,
      "data":
          "${revisao.data.year.toString().padLeft(4, '0')}-${revisao.data.month.toString().padLeft(2, '0')}-${revisao.data.day.toString().padLeft(2, '0')}",
      "data_proxima":
          "${revisao.dataProxima.year.toString().padLeft(4, '0')}-${revisao.dataProxima.month.toString().padLeft(2, '0')}-${revisao.dataProxima.day.toString().padLeft(2, '0')}",
      "usuario_id": revisao.usuarioId,
    });
    return response["data"]["insert_revisoes_one"]["id"];
  }

  @override
  Future<bool> editConteudoName({required int id, required String name}) async {
    var response = await _hasuraConnect.mutation(
        _hasuraRequisitions.editConteudoName,
        variables: {"id": id, "nome": name});
    if (response["data"]["update_conteudos"]["affected_rows"] == 1) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<bool> editConteudoArea({required int id, required int areaId}) async {
    var response = await _hasuraConnect.mutation(
        _hasuraRequisitions.editConteudoArea,
        variables: {"id": id, "area_id": areaId});
    if (response["data"]["update_conteudos"]["affected_rows"] == 1) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<bool> concludeRevisao({required int revisaoId}) async {
    var response = await _hasuraConnect.mutation(
        _hasuraRequisitions.concludeRevisao,
        variables: {"id": revisaoId});
    if (response["data"]["update_revisoes"]["affected_rows"] == 1) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<bool> editAcertoRevisao(
      {required int revisaoId, required int acerto}) async {
    var response = await _hasuraConnect.mutation(
        _hasuraRequisitions.editAcertoRevisao,
        variables: {"id": revisaoId, "acerto": acerto});
    if (response["data"]["update_revisoes"]["affected_rows"] == 1) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<bool> deleteConteudoRevisoes({required int conteudoId}) async {
    var response = await _hasuraConnect.mutation(
        _hasuraRequisitions.deleteConteudoRevisoes,
        variables: {"id": conteudoId});
    if (response["data"]["delete_conteudos_by_pk"]["id"] == conteudoId) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future fetchAreas() async {
    var response = await _hasuraConnect.query(_hasuraRequisitions.queryAreas);
    return response["data"]["areas"] as List;
  }
}

class HasuraRequisitions {
  final String queryRevisoesEmAndamento = """
      query QueryRevisoesEmAndamento(\$usuario_id: Int!, \$offset: Int!) {
        revisoes(order_by: {data_proxima: asc}, offset: \$offset, where: {usuario_id: {_eq: \$usuario_id}, concluida: {_eq: false}}, limit: 40) {
          acerto
          concluida
          conteudo_id
          data_proxima
          data
          id
          usuario_id
          conteudo {
            id
            nome
            area_id
          }
        }
      }
""";

  final insertConteudoRevisao = """
        mutation insertConteudoRevisao(\$area_id: Int!, \$nome: String!, \$acerto: numeric!, \$concluida: Boolean!, \$data: date!, \$data_proxima: date!, \$usuario_id: Int!) {
          insert_conteudos_one(object: {area_id: \$area_id, nome: \$nome, usuario_id: \$usuario_id, revisoes: {data: {usuario_id: \$usuario_id, data_proxima: \$data_proxima, data: \$data, concluida: \$concluida, acerto: \$acerto}}}) {
            id
            revisoes {
              id
            }
          }
        }
  """;

  final String createConteudo = """
      mutation createConteudo(\$area_id: Int!, \$nome: String!, \$usuario_id: Int!) {
        insert_conteudos_one(object: {area_id: \$area_id, nome: \$nome, usuario_id: \$usuario_id}) {
          id
        }
      }
  """;

  final String createRevisao = """
      mutation createRevisao(\$acerto: numeric!, \$concluida: Boolean!, \$conteudo_id: Int!, \$data: date!, \$data_proxima: date!, \$usuario_id: Int! ) {
        insert_revisoes_one(object: {acerto: \$acerto, concluida: \$concluida, conteudo_id: \$conteudo_id, data_proxima: \$data_proxima, data: \$data, usuario_id: \$usuario_id}) {
          id
        }
      }
  """;

  final String editConteudoName = """
      mutation editConteudoName(\$id: Int!, \$nome: String!) {
        update_conteudos(where: {id: {_eq: \$id}}, _set: {nome: \$nome}) {
          affected_rows
        }
      }
""";

  final String editConteudoArea = """
      mutation editConteudoArea(\$id: Int!, \$area_id: Int!) {
        update_conteudos(where: {id: {_eq: \$id}}, _set: {area_id: \$area_id}) {
          affected_rows
        }
      }
""";

  final String concludeRevisao = """
    mutation concludeRevisao(\$revisao_id: Int!) {
      update_revisoes(where: {id: {_eq: \$revisao_id}}, _set: {concluida: true}) {
        affected_rows
      }
    }
  """;

  final String editAcertoRevisao = """
      mutation editAcertoRevisao(\$acerto: numeric!) {
        update_revisoes(where: {id: {_eq: 1}}, _set: {acerto: \$acerto}) {
          affected_rows
        }
      }
  """;

  final String deleteRevisao = """
    mutation deleteRevisao(\$conteudo_id: Int!) {
      delete_revisoes(where: {conteudo_id: {_eq: \$conteudo_id}}) {
        affected_rows
      }
    }
  """;

  final String deleteConteudo = """
    mutation deleteConteudo(\$conteudo_id: Int!) {
      delete_conteudos(where: {id: {_eq: \$conteudo_id}}) {
        affected_rows
      }
    }
  """;

  final String deleteConteudoRevisoes = """
      mutation deleteConteudoRevisoes(\$id: Int!) {
        delete_revisoes(where: {conteudo_id: {_eq: \$id}}) {
        affected_rows
      }
      delete_conteudos_by_pk(id: \$id) {
        id
      }
    }
  """;

  final String queryAreas = """
        query queryAreas {
          areas {
            id
            nome
          }
        }
  """;
}
