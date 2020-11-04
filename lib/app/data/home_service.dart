import 'package:get/get.dart';
import 'package:tdriver2/app/BD/bd.dart';

class HomeService extends GetxService {
  Future<HomeService> init() async {
    await BD().initBd();
    return this;
  }
}
