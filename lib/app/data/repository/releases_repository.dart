import 'package:meta/meta.dart';
import 'package:tdriver2/app/data/provider/api.dart';

class ReleasesRepository {
  final MyApiClient apiClient;

  ReleasesRepository({@required this.apiClient}) : assert(apiClient != null);

  getAll(year) {
    return apiClient.getAll(year);
  }

  add(obj) {
    return apiClient.add(obj);
  }

  getId(obj) {
    return apiClient.getId(obj);
  }

  delete(id) {
    return apiClient.delete(id);
  }
}
