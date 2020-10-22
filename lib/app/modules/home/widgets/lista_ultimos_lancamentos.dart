import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:tdriver2/app/BD/bd.dart';
import 'package:tdriver2/app/data/provider/api.dart';
import 'package:tdriver2/app/data/repository/home_repository.dart';
import 'package:tdriver2/app/modules/home/home_controller.dart';

import 'package:tdriver2/app/modules/home/widgets/item_ultimos_lancamentos.dart';

class ListaUltimosLancamentos extends StatelessWidget {
  ListaUltimosLancamentos({Key key}) : super(key: key);

  final controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return GetX<HomeController>(
      init: HomeController(
          repository: HomeRepository(apiClient: MyApiClient(db: BD()))),
      builder: (_) {
        return ListView.separated(
          padding: EdgeInsets.zero,
          itemCount: _.lastReleases.length, //lista.length,
          itemBuilder: (s, index) {
            return ItemUltimosLancamentos(
              model: _.lastReleases[index].toMap(),
            );
          },
          separatorBuilder: (context, index) {
            return Divider();
          },
        );
      },
    );
  }
}
