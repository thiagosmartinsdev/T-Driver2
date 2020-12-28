import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tdriver2/app/modules/releases/releases_controller.dart';
import 'package:brasil_fields/brasil_fields.dart';

class ReleasesPage extends GetView<ReleasesController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        resizeToAvoidBottomPadding: true,
        body: SafeArea(
          child: Container(
              height: Get.height,
              decoration: BoxDecoration(
                  gradient: new LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                    Color.fromRGBO(183, 248, 219, 100),
                    Color.fromRGBO(80, 167, 194, 100)
                  ])),
              child: Column(
                children: [
                  GetX<ReleasesController>(
                    builder: (_) {
                      return GestureDetector(
                        onTap: () => _.oppened.value = !_.oppened.value,
                        child: Center(
                          child: Form(
                            key: controller.formKey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: Get.width * 0.7,
                                  height: Get.height * 0.1,
                                  color: Colors.green,
                                  child: TextField(
                                      controller: controller.txtDate,
                                      readOnly: true,
                                      onTap: () async {
                                        final dateSelected =
                                            await showDatePicker(
                                                initialDate: DateTime.now(),
                                                firstDate: DateTime.now()
                                                    .subtract(
                                                        Duration(days: 365)),
                                                lastDate: DateTime.now()
                                                    .add(Duration(days: 365)),
                                                context: Get.context);

                                        if (dateSelected != null &&
                                            dateSelected !=
                                                controller.selectedDate.value) {
                                          controller.selectedDate.value =
                                              dateSelected;

                                          controller.txtDate.text = DateFormat(
                                                  'dd/MM/yyyy')
                                              .format(dateSelected.toLocal())
                                              .toString();
                                        }
                                      }),
                                ),
                                AnimatedContainer(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: _.oppened.value
                                        ? Color(0xFFFF7000)
                                        : Color(0xFF788993),
                                  ),
                                  width: Get.width * 0.8,
                                  height: _.oppened.value
                                      ? Get.height * 0.4
                                      : Get.height * 0.2,
                                  duration: Duration(milliseconds: 300),
                                  child: Container(
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Text(
                                              "Ganhos",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20),
                                            ),
                                          ],
                                        ),
                                        Container(
                                            width: Get.context.width * 0.7,
                                            child: _cardGains()),
                                      ],
                                    ),
                                  ),
                                ),
                                Divider(),
                                AnimatedContainer(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: _.oppened.value
                                        ? Color(0xFF788993)
                                        : Color(0xFFFF7000),
                                  ),
                                  width: Get.width * 0.8,
                                  height: _.oppened.value
                                      ? Get.height * 0.2
                                      : Get.height * 0.4,
                                  duration: Duration(milliseconds: 300),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                                top: Get.height * 0.05),
                                            child: Text(
                                              "Gastos",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Container(
                                          width: Get.context.width * 0.7,
                                          child: _cardExpensives())
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  FlatButton(
                      child: Text("Gravar"),
                      color: Colors.blueGrey,
                      onPressed: () {
                        if (controller.formKey.currentState.validate()) {
                          controller.save();
                        }
                      })
                ],
              )),
        ));
  }

  _cardGains() {
    return Flexible(
      child: Column(
        children: [
          TextFormField(
            controller: controller.txtUber,
            decoration: InputDecoration(labelText: "Uber"),
            textInputAction: TextInputAction.next,
            focusNode: controller.uberNode,
            inputFormatters: [
              WhitelistingTextInputFormatter.digitsOnly,
              RealInputFormatter(centavos: true)
            ],
            onFieldSubmitted: (term) {
              controller.fieldFocusChange(
                  Get.context, controller.uberNode, controller.popNode);
            },
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            validator: (value) => controller.validator(value),
          ),
          TextFormField(
            controller: controller.txt99Pop,
            decoration: InputDecoration(labelText: "99 Pop"),
            textInputAction: TextInputAction.next,
            focusNode: controller.popNode,
            inputFormatters: [
              WhitelistingTextInputFormatter.digitsOnly,
              RealInputFormatter(centavos: true)
            ],
            onFieldSubmitted: (term) {
              controller.fieldFocusChange(
                  Get.context, controller.popNode, controller.cabifyNode);
            },
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            validator: (value) => controller.validator(value),
          ),
          TextFormField(
            controller: controller.txtCabify,
            decoration: InputDecoration(labelText: "Cabify"),
            textInputAction: TextInputAction.next,
            focusNode: controller.cabifyNode,
            inputFormatters: [
              WhitelistingTextInputFormatter.digitsOnly,
              RealInputFormatter(centavos: true)
            ],
            onFieldSubmitted: (term) {
              controller.fieldFocusChange(
                  Get.context, controller.popNode, controller.particularNode);
            },
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            validator: (value) => controller.validator(value),
          ),
          TextFormField(
            controller: controller.txtParticular,
            decoration: InputDecoration(labelText: "Particular"),
            textInputAction: TextInputAction.done,
            focusNode: controller.particularNode,
            inputFormatters: [
              WhitelistingTextInputFormatter.digitsOnly,
              RealInputFormatter(centavos: true)
            ],
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            validator: (value) => controller.validator(value),
          ),
        ],
      ),
    );
  }

  _cardExpensives() {
    return Column(
      children: [
        TextFormField(
          controller: controller.txtCombustivel,
          decoration: InputDecoration(labelText: "Combustível"),
          textInputAction: TextInputAction.next,
          focusNode: controller.combustivelNode,
          inputFormatters: [
            WhitelistingTextInputFormatter.digitsOnly,
            RealInputFormatter(centavos: true)
          ],
          onFieldSubmitted: (term) {
            controller.fieldFocusChange(Get.context, controller.combustivelNode,
                controller.alimentacaoNode);
          },
          keyboardType: TextInputType.numberWithOptions(decimal: true),
          validator: (value) => controller.validator(value),
        ),
        TextFormField(
          controller: controller.txtAlimentacao,
          decoration: InputDecoration(labelText: "Alimentação"),
          textInputAction: TextInputAction.next,
          focusNode: controller.alimentacaoNode,
          inputFormatters: [
            WhitelistingTextInputFormatter.digitsOnly,
            RealInputFormatter(centavos: true)
          ],
          onFieldSubmitted: (term) {
            controller.fieldFocusChange(Get.context, controller.alimentacaoNode,
                controller.manutencaoNode);
          },
          keyboardType: TextInputType.numberWithOptions(decimal: true),
          validator: (value) => controller.validator(value),
        ),
        TextFormField(
          controller: controller.txtManutencao,
          decoration: InputDecoration(labelText: "Manutenção"),
          textInputAction: TextInputAction.done,
          focusNode: controller.manutencaoNode,
          inputFormatters: [
            WhitelistingTextInputFormatter.digitsOnly,
            RealInputFormatter(centavos: true)
          ],
          keyboardType: TextInputType.numberWithOptions(decimal: true),
          validator: (value) => controller.validator(value),
        ),
      ],
    );
  }
}
