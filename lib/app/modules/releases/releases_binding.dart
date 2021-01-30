import 'package:get/get.dart';
import 'package:tdriver2/app/database/bd.dart';
import 'package:tdriver2/app/data/provider/api.dart';
import 'package:tdriver2/app/data/repository/releases_repository.dart';
import 'package:tdriver2/app/modules/releases/releases_controller.dart';

class ReleasesBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReleasesController>(() => ReleasesController(
        repository: ReleasesRepository(apiClient: MyApiClient(db: BD()))));
  }
}
