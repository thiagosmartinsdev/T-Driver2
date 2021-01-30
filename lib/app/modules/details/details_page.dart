import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tdriver2/app/modules/details/details_controller.dart';
import 'package:tdriver2/app/modules/widgets/item_ultimos_lancamentos.dart';
import 'package:tdriver2/app/modules/widgets/background_app.dart';

class DetailsPage extends GetView<DetailsController> {
  final DetailsController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.back(result: true);
        return true;
      },
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Color(0xFFFAFAFA),
          extendBody: true,
          body: SafeArea(
            bottom: false,
            top: false,
            child: Stack(
              children: [
                BackGrroundApp(),
                Container(
                  width: Get.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.only(top: Get.height * 0.05),
                        width: Get.width,
                        child: Row(
                          children: [
                            Container(
                              width: Get.width * 0.1,
                              child: IconButton(
                                icon: Icon(
                                  Icons.arrow_back,
                                  color: Colors.white,
                                  size: 35,
                                ),
                                onPressed: () => Get.back(result: true),
                              ),
                            ),
                            Container(
                              width: Get.width * 0.8,
                              alignment: Alignment.center,
                              child: Text(controller.obj.period,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.center,
                          child: SizedBox(
                            width: Get.width * 0.95,
                            height: double.infinity,
                            child: Obx(
                              () => ListView.separated(
                                itemCount: controller.listReleases.length,
                                itemBuilder: (s, index) {
                                  return Dismissible(
                                    key: Key(controller
                                        .listReleases[index].idMovimentacao
                                        .toString()),
                                    direction: DismissDirection.endToStart,
                                    background: Container(
                                        color: Colors.red,
                                        padding: EdgeInsets.only(right: 15),
                                        alignment: Alignment.centerRight,
                                        child: RichText(
                                          text: TextSpan(children: [
                                            WidgetSpan(
                                                child: Icon(Icons.delete,
                                                    size: 20,
                                                    color: Colors.white)),
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
                                          desc:
                                              'Essa operação não poderá ser revertida!',
                                          btnCancelOnPress: () {
                                            result = false;
                                          },
                                          btnOkOnPress: () async {
                                            result = true;
                                          }).show();

                                      if (result)
                                        controller.delete(
                                            controller.listReleases[index],
                                            index);

                                      return result;
                                    },
                                    child: ItemUltimosLancamentos(
                                      model: controller.listReleases[index],
                                    ),
                                  );
                                },
                                separatorBuilder: (context, index) {
                                  return Divider();
                                },
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          )),
    );
  }
}
