import 'package:get/get.dart';
import 'package:tdriver2/app/data/provider/api.dart';
import 'package:tdriver2/app/data/repository/releases_repository.dart';
import 'package:tdriver2/app/database/bd.dart';
import 'package:tdriver2/app/modules/home/home_controller.dart';

class HomeService extends GetxService {
  Future<HomeService> init() async {
    print(">>>>>>>>>>>>>>>>>>>>>>>>>>>> SERVICE INIT");
    await BD().initBd();
    await Get.put(HomeController(
            repository: ReleasesRepository(apiClient: MyApiClient(db: BD()))))
        .loadReleases();
    print(">>>>>>>>>>>>>>>>>>>>>>>>>>>> SERVICE END");
    return this;
  }
}
