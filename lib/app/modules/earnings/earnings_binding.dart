import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:tdriver2/app/BD/bd.dart';
import 'package:tdriver2/app/data/provider/api.dart';
import 'package:tdriver2/app/data/repository/earnings_repository.dart';
import 'package:tdriver2/app/modules/earnings/earnings_controller.dart';

class EarningsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EarningsController>(() => EarningsController(
        repository: EarningsRepository(apiClient: MyApiClient(db: BD()))));
  }
}
