import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:tdriver2/app/BD/bd.dart';
import 'package:tdriver2/app/data/provider/api.dart';
import 'package:tdriver2/app/data/repository/releases_repository.dart';
import 'package:tdriver2/app/modules/home/home_controller.dart';

import 'package:tdriver2/app/modules/home/widgets/item_ultimos_lancamentos.dart';

class ListaUltimosLancamentos extends StatelessWidget {
  ListaUltimosLancamentos({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetX<HomeController>(
      init: HomeController(
          repository: ReleasesRepository(apiClient: MyApiClient(db: BD()))),
      builder: (_) {
        return ListView.separated(
          padding: EdgeInsets.zero,
          itemCount: _.lastReleases.length, //lista.length,
          itemBuilder: (s, index) {
            return Dismissible(
              key: Key(_.lastReleases[index].idMovimentacao.toString()),
              direction: DismissDirection.endToStart,
              background: Container(
                  color: Colors.red,
                  padding: EdgeInsets.only(right: 15),
                  alignment: Alignment.centerRight,
                  child: RichText(
                    text: TextSpan(children: [
                      WidgetSpan(
                          child: Icon(Icons.delete,
                              size: 20, color: Colors.white)),
                      TextSpan(
                          text: " APAGAR",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          )),
                    ]),
                  )),
              confirmDismiss: (direction) async {
                var result;

                await AwesomeDialog(
                    context: s,
                    dismissOnTouchOutside: false,
                    dialogType: DialogType.WARNING,
                    headerAnimationLoop: false,
                    animType: AnimType.TOPSLIDE,
                    title: 'Atenção',
                    desc: 'Essa operação não poderá ser revertida!',
                    btnCancelOnPress: () {
                      result = false;
                    },
                    btnOkOnPress: () async {
                      await _.delete(_.lastReleases[index].idMovimentacao);
                      _.lastReleases.removeAt(index);
                      result = true;
                    }).show();

                return result;
              },
              child: ItemUltimosLancamentos(
                model: _.lastReleases[index],
              ),
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
