import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:tdriver2/app/data/model/movimentacao.dart';
import 'package:tdriver2/app/data/repository/releases_repository.dart';

class DetailsController extends GetxController {
  final ReleasesRepository repository;
  DetailsController({@required this.repository}) : assert(repository != null);

  var obj = Get.arguments;
  final date = DateTime.now().obs;
  final listReleases = List<MovimentacaoModel>().obs;

  @override
  onReady() {
    loadReleases();
    super.onReady();
  }

  Future<void> loadReleases() async {
    listReleases.value = await repository.getId(obj);
  }
}
