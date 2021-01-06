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

// getId(id){
//   return apiClient.getId(id);
// }
  delete(id) {
    return apiClient.delete(id);
  }
// edit(obj){
//   return apiClient.edit( obj );
// }

}
