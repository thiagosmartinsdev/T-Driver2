import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:tdriver2/app/modules/home/home_controller.dart';

import 'package:tdriver2/app/modules/widgets/item_ultimos_lancamentos.dart';

class ListaUltimosLancamentos extends StatelessWidget {
  ListaUltimosLancamentos({Key? key}) : super(key: key);

  final HomeController _ = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ListView.separated(
        padding: EdgeInsets.zero,
        itemCount: _.lastReleases.length, //lista.length,
        itemBuilder: (s, index) {
          return Dismissible(
            key: Key(_.lastReleases[index].idMovimentacao.toString()),
            direction: DismissDirection.endToStart,
            background: Container(
                decoration: BoxDecoration(
                    color: Colors.red, borderRadius: BorderRadius.circular(10)),
                padding: EdgeInsets.only(right: 15),
                alignment: Alignment.centerRight,
                child: RichText(
                  text: TextSpan(children: [
                    WidgetSpan(
                        child:
                            Icon(Icons.delete, size: 20, color: Colors.white)),
                    TextSpan(
                        text: " APAGAR",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
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
                    result = true;
                  }).show();

              if (result) _.delete(_.lastReleases[index], index);

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
      ),
    );
    //   },
    // );
  }
}
