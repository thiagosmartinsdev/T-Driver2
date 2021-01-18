import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tdriver2/app/modules/details/details_controller.dart';
import 'package:tdriver2/app/modules/home/widgets/item_ultimos_lancamentos.dart';
import 'package:tdriver2/app/modules/widgets/backGroundApp.dart';

class DetailsPage extends GetView<DetailsController> {
  DetailsController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                              onPressed: () => Get.back(),
                            ),
                          ),
                          Container(
                            width: Get.width * 0.8,
                            alignment: Alignment.center,
                            child: Text(
                                controller.obj.name ?? controller.obj.period,
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
                                return ItemUltimosLancamentos(
                                  model: controller.listReleases[index],
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
        ));
  }
}
