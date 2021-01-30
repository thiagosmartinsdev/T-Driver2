import 'package:get/get.dart';
import 'package:tdriver2/app/database/bd.dart';
import 'package:tdriver2/app/data/provider/api.dart';
import 'package:tdriver2/app/data/repository/releases_repository.dart';
import 'package:tdriver2/app/modules/home/home_controller.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() {
      return HomeController(
          repository: ReleasesRepository(apiClient: MyApiClient(db: BD())));
    });
  }
}
