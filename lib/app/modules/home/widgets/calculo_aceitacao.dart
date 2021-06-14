import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:flutter/material.dart';
import 'package:tdriver2/app/modules/home/widgets/controller/calculo_aceitacao_controller.dart';
import 'package:tdriver2/app/modules/widgets/background_app.dart';

class CalculoAceitacaoPage extends GetView<CalculoAceitacaoController> {
  final CalculoAceitacaoController controller =
      Get.put(CalculoAceitacaoController());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.back(result: true);
        return true;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Color(0xFFFAFAFA),
        body: SafeArea(
          top: false,
          bottom: false,
          child: Stack(children: [
            BackGrroundApp(),
            Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      height: Get.height * 0.06,
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                top: Get.height * 0.01, left: Get.width * 0.06),
                            child: IconButton(
                              icon: Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                                size: 35,
                              ),
                              onPressed: () => Get.back(result: true),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: Get.height * 0.8,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            width: Get.width,
                            height: Get.height * 0.07,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Cálculo da taxa de aceitação",
                                  style: TextStyle(
                                      fontSize: Get.width * 0.05,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: Get.width * 0.8,
                            height: Get.height * 0.45,
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      color: Color(0xFF546E7A), blurRadius: 12)
                                ],
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.blueGrey),
                                color: Colors.white),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: Get.width * .7,
                                  child: TextFormField(
                                    controller: controller.txtRecebidas,
                                    decoration: InputDecoration(
                                        labelText: "Solicitações recebidas"),
                                    textInputAction: TextInputAction.next,
                                    focusNode: controller.recebidasNode,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(
                                          RegExp('[0-9]')),
                                    ],
                                    onFieldSubmitted: (term) {
                                      controller.fieldFocusChange(
                                          Get.context!,
                                          controller.recebidasNode,
                                          controller.aceitasNode);
                                    },
                                    keyboardType:
                                        TextInputType.numberWithOptions(),
                                    keyboardAppearance: Brightness.light,
                                    validator: (value) => controller.validate(),
                                    onChanged: (value) => controller
                                        .recebidas.value = int.parse(value),
                                  ),
                                ),
                                SizedBox(
                                  width: Get.width * 0.7,
                                  child: TextFormField(
                                    controller: controller.txtAceitas,
                                    decoration: InputDecoration(
                                        labelText: "Solicitações aceitas"),
                                    textInputAction: TextInputAction.done,
                                    focusNode: controller.aceitasNode,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(
                                          RegExp('[0-9]')),
                                    ],
                                    keyboardType:
                                        TextInputType.numberWithOptions(),
                                    keyboardAppearance: Brightness.light,
                                    validator: (value) => controller.validate(),
                                    onChanged: (value) => controller
                                        .aceitas.value = int.parse(value),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.only(top: Get.height * 0.07),
                                  child: SizedBox(
                                      width: Get.width * 0.7,
                                      height: Get.height * 0.1,
                                      child: Container(
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  width: 1,
                                                  color: Color(0xFF263238)),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Obx(
                                            () => Text(
                                              controller.resultado.value,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: controller
                                                      .colorResp.value,
                                                  fontSize: 15),
                                            ),
                                          ))),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                        width: Get.width * 0.5,
                        decoration: BoxDecoration(
                            color: Color(0xFF90A4AE),
                            gradient: LinearGradient(
                                begin: Alignment.bottomLeft,
                                end: Alignment.topRight,
                                colors: [Color(0xFF37474F), Color(0xFF90A4AE)]),
                            boxShadow: [
                              BoxShadow(
                                  color: Color(0xFF263238),
                                  blurRadius: 10,
                                  spreadRadius: 1)
                            ],
                            border:
                                Border.all(color: Color(0xFF90A4AE), width: 3),
                            borderRadius: BorderRadius.circular(15)),
                        child: FlatButton(
                          onPressed: () => controller.calcular(),
                          child: Text(
                            "Calcular",
                            style: TextStyle(
                                fontSize: 20, color: Color(0xFFECEFF1)),
                          ),
                          // color: Color(0xFF546E7A),
                        ))
                  ],
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
