import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tdriver2/app/data/model/movimentacao.dart';
import 'package:tdriver2/app/data/repository/releases_repository.dart';

class DetailsController extends GetxController {
  final ReleasesRepository repository;
  DetailsController({required this.repository}) : assert(repository != null);

  var obj = Get.arguments;
  final date = DateTime.now().obs;
  final listReleases = [].obs;

  @override
  onReady() {
    loadReleases();
    super.onReady();
  }

  delete(MovimentacaoModel item, int index) async {
    try {
      repository.delete(item.idMovimentacao);

      await Future.delayed(const Duration(milliseconds: 250), () {
        listReleases.removeAt(index);
        Get.rawSnackbar(
            messageText: Text(
          'Registro removido com sucesso',
          style: TextStyle(color: Colors.white),
        ));
      });
    } on DatabaseException catch (error) {
      print("Erro ao excluir: " + error.toString());
    }
  }

  Future<void> loadReleases() async {
    listReleases.assignAll(await repository.getId(obj));
  }
}
