import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:meta/meta.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tdriver2/app/data/model/card_model.dart';
import 'package:tdriver2/app/data/model/movimentacao.dart';
import 'package:tdriver2/app/data/repository/releases_repository.dart';

class HomeController extends GetxController {
  final ReleasesRepository repository;
  HomeController({required this.repository}) : assert(repository != null);

  static HomeController get i => Get.find();

  final lastReleases = [].obs;
  final releasesMontlhy = [].obs;
  final releasesWeekly = [].obs;

  var currentYear = DateTime.now().year.obs;
  var newUser = true.obs;

  @override
  Future<void> onInit() async {
    final checkUser = GetStorage();

    checkUser.read('newUser') ?? checkUser.write('newUser', true);

    newUser.value = false; // checkUser.read('newUser');
    ever(currentYear, (value) => resetHome());
    super.onInit();
  }

  resetHome() async {
    lastReleases.clear();
    releasesMontlhy.clear();
    releasesWeekly.clear();

    await loadReleases();
  }

  Future<void> loadReleases() async {
    var result = await repository.getAll(currentYear);
    if (result != null) {
      if (result['releases'] != null) {
        result['releases'].forEach((element) {
          lastReleases.add(element);
        });

        result['monthly'].forEach((element) {
          releasesMontlhy.add(element);
        });
        // releasesMontlhy.clear();

        result['weekly'].forEach((element) {
          releasesWeekly.add(element);
        });
        // releasesWeekly.clear();
      }
    }

    update();
  }

  delete(MovimentacaoModel item, int index) async {
    try {
      await repository.delete(item.idMovimentacao);

      for (int x = 0; x < releasesMontlhy.length; x++) {
        if (item.data.month == int.parse(releasesMontlhy[x].numMes)) {
          item.idTipoMovimentacao == 1
              ? releasesMontlhy[x].earnings -= item.valor
              : releasesMontlhy[x].expensive -= item.valor;
        }
      }

      for (int x = 0; x < releasesWeekly.length; x++) {
        if (item.data.isAfter(releasesWeekly[x].dataInicial) &&
            item.data.isBefore(releasesWeekly[x].dataFinal)) {
          item.idTipoMovimentacao == 1
              ? releasesWeekly[x].earnings -= item.valor
              : releasesWeekly[x].expensive -= item.valor;
        }
      }

      update();

      await Future.delayed(const Duration(milliseconds: 250), () {
        lastReleases.removeAt(index);
      });

      Get.rawSnackbar(
          messageText: Text(
        'Registro removido com sucesso',
        style: TextStyle(color: Colors.white),
      ));
    } on DatabaseException catch (error) {
      print("Erro ao excluir : " + error.toString());
    }
  }
}
