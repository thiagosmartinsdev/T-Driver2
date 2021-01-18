import 'package:get/get.dart';
import 'package:tdriver2/app/BD/bd.dart';
import 'package:tdriver2/app/data/provider/api.dart';
import 'package:tdriver2/app/data/repository/releases_repository.dart';
import 'package:tdriver2/app/modules/details/details_controller.dart';

class DetailsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailsController>(() {
      return DetailsController(
          repository: ReleasesRepository(apiClient: MyApiClient(db: BD())));
    });
  }
}
