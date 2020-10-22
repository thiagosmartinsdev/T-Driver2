import 'package:meta/meta.dart';
import 'package:tdriver2/app/data/provider/api.dart';

class HomeRepository {

final MyApiClient apiClient;

HomeRepository({@required this.apiClient}) : assert(apiClient != null);

getAll(){
  return apiClient.getAll();
}
// getId(id){
//   return apiClient.getId(id);
// }
// delete(id){
//   return apiClient.delete(id);
// }
// edit(obj){
//   return apiClient.edit( obj );
// }
// add(obj){
//     return apiClient.add( obj );
// }

}