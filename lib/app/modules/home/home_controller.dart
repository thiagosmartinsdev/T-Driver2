import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tdriver2/app/data/model/card_model.dart';
import 'package:tdriver2/app/data/model/movimentacao.dart';
import 'package:tdriver2/app/data/repository/releases_repository.dart';

class HomeController extends GetxController {
  final ReleasesRepository repository;
  HomeController({@required this.repository}) : assert(repository != null);

  final lastReleases = List<MovimentacaoModel>().obs;
  var releasesMontlhy = List<CardModel>().obs;
  var releasesWeekly = List<CardModel>().obs;

  var currentYear = DateTime.now().year.obs;

  @override
  onInit() {
    super.onInit();

    ever(currentYear, (value) => resetHome());
  }

  @override
  onReady() {
    loadReleases();
  }

  resetHome() {
    lastReleases.clear();
    releasesMontlhy.clear();
    releasesWeekly.clear();

    loadReleases();
  }

  Future<void> loadReleases() async {
    await repository.getAll(currentYear).then((response) {
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

  delete(int idMovimentacao, int index) async {
    try {
      repository.delete(idMovimentacao);
      Get.rawSnackbar(
          messageText: Text(
        'Registro removido com sucesso',
        style: TextStyle(color: Colors.white),
      ));

      await Future.delayed(const Duration(milliseconds: 250), () {
        lastReleases.removeAt(index);
      });

      resetHome();
    } on DatabaseException catch (error) {
      print("Erro ao excluir : " + error.toString());
    }
  }
}
