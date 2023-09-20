import 'package:get_it/get_it.dart';
import 'package:performance_nos_estudos_app/models/area_model.dart';

import '../services/database_service.dart';

class AreaStore {
  final _service = GetIt.I<IDatabase>();
  List<AreaModel> areas = [];

  Future fetchAreas() async {
      var response = await _service.fetchAreas();
      areas = List.generate(
          response.length, (index) => AreaModel.fromJson(response[index]));
  }
}
