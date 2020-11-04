import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:tdriver2/app/data/model/card_model.dart';
import 'package:tdriver2/app/data/model/movimentacao.dart';
import 'package:tdriver2/app/data/repository/home_repository.dart';

class HomeController extends GetxController {
  final HomeRepository repository;
  HomeController({@required this.repository}) : assert(repository != null);

  var lastReleases = List<MovimentacaoModel>().obs;
  var releasesMontlhy = List<CardModel>().obs;
  var releasesWeekly = List<CardModel>().obs;

  @override
  Future<void> onInit() async {
    print(">>>>>>>>>>>>>>>>>>>ON INIT<<<<<<<<<<<<<");
    await repository.getAll().then((response) {
      response['releases'].forEach((element) {
        lastReleases.add(element);
      });

      response['monthly'].forEach((element) {
        releasesMontlhy.add(element);
      });

      response['weekly'].forEach((element) {
        releasesWeekly.add(element);
      });
    });

    super.onInit();
  }

  final _obj = ''.obs;
  set obj(value) => this._obj.value = value;
  get obj => this._obj.value;
}
