import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:tdriver2/app/data/model/card_model.dart';
import 'package:tdriver2/app/data/model/movimentacao.dart';
import 'package:tdriver2/app/data/repository/releases_repository.dart';

class HomeController extends GetxController {
  final ReleasesRepository repository;
  HomeController({@required this.repository}) : assert(repository != null);

  final lastReleases = List<MovimentacaoModel>().obs;
  var releasesMontlhy = List<CardModel>().obs;
  var releasesWeekly = List<CardModel>().obs;

  @override
  Future<void> onInit() async {
    loadReleases();
    super.onInit();
  }

  resetHome() {
    lastReleases.clear();
    releasesMontlhy.clear();
    releasesWeekly.clear();

    loadReleases();
  }

  Future<void> loadReleases() async {
    await repository.getAll().then((response) {
      if (response['releases'] != null) {
        response['releases'].forEach((element) {
          lastReleases.add(element);
        });

        response['monthly'].forEach((element) {
          releasesMontlhy.add(element);
        });

        response['weekly'].forEach((element) {
          releasesWeekly.add(element);
        });
      }
    });
  }

  del() {
    // var db = BD();
    // db.apagarRegistro(45);
  }

  final _obj = ''.obs;
  set obj(value) => this._obj.value = value;
  get obj => this._obj.value;
}
