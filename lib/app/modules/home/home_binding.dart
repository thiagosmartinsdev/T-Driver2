import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:tdriver2/app/BD/bd.dart';
import 'package:tdriver2/app/data/provider/api.dart';
import 'package:tdriver2/app/data/repository/home_repository.dart';
import 'package:tdriver2/app/modules/home/home_controller.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController(
        repository: HomeRepository(apiClient: MyApiClient(db: BD()))));
  }
}
