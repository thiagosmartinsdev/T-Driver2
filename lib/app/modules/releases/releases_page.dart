import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tdriver2/app/modules/releases/releases_controller.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:tdriver2/app/modules/widgets/backGroundApp.dart';

class ReleasesPage extends GetView<ReleasesController> {
  final durationAni = Duration(milliseconds: 300);

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
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: Get.width * 0.4,
                              height: Get.height * 0.07,
                              alignment: Alignment.center,
                              child: TextField(
                                style: TextStyle(
                                    fontSize: 25,
                                    color: Color(0xFFFAFAFA),
                                    fontWeight: FontWeight.bold),
                                controller: controller.txtDate,
                                decoration: new InputDecoration(
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                ),
                                readOnly: true,
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: Colors.blueGrey,
                                  boxShadow: [
                                    BoxShadow(
                                        color: Color(0xFFCFD8DC),
                                        blurRadius: 5,
                                        spreadRadius: 3)
                                  ],
                                  borderRadius: BorderRadius.circular(100)),
                              child: IconButton(
                                icon: Icon(Icons.calendar_today_outlined,
                                    color: Color(0xFFFAFAFA)),
                                onPressed: () async {
                                  final dateSelected = await showDatePicker(
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime.now()
                                          .subtract(Duration(days: 365)),
                                      lastDate: DateTime.now()
                                          .add(Duration(days: 365)),
                                      context: Get.context);

                                  if (dateSelected != null &&
                                      dateSelected !=
                                          controller.selectedDate.value) {
                                    controller.selectedDate.value =
                                        dateSelected;

                                    controller.txtDate.text =
                                        DateFormat('dd/MM/yyyy')
                                            .format(dateSelected.toLocal())
                                            .toString();
                                  }
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: Get.height * 0.02),
                      ),
                      Container(
                          height: Get.height * 0.7,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GetX<ReleasesController>(
                                builder: (_) {
                                  return GestureDetector(
                                    onTap: () =>
                                        _.oppened.value = !_.oppened.value,
                                    child: Center(
                                      child: Form(
                                        key: controller.formKey,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            AnimatedContainer(
                                              decoration: BoxDecoration(
                                                  boxShadow: [
                                                    BoxShadow(
                                                        color: _.oppened.value
                                                            ? Color(0xFF546E7A)
                                                            : Colors.white,
                                                        blurRadius: 12)
                                                  ],
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  border: Border.all(
                                                      color: Colors.blueGrey),
                                                  color: _.oppened.value
                                                      ? Colors.white
                                                      : Colors.blueGrey),
                                              width: Get.width * 0.8,
                                              height: _.oppened.value
                                                  ? Get.height * 0.45
                                                  : Get.height * 0.20,
                                              duration: durationAni,
                                              child: AnimatedSwitcher(
                                                duration: durationAni,
                                                child: !_.oppened.value
                                                    ? Center(
                                                        child: Text(
                                                        "Ganhos",
                                                        style: TextStyle(
                                                            fontSize: 30,
                                                            color:
                                                                Colors.white),
                                                      ))
                                                    : SingleChildScrollView(
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceEvenly,
                                                              children: [
                                                                Text(
                                                                  "Ganhos",
                                                                  style: TextStyle(
                                                                      color: Color(
                                                                          0xFF37474F),
                                                                      fontSize:
                                                                          25),
                                                                ),
                                                              ],
                                                            ),
                                                            Container(
                                                                width: Get
                                                                        .context
                                                                        .width *
                                                                    0.7,
                                                                child:
                                                                    _cardGains())
                                                          ],
                                                        ),
                                                      ),
                                              ),
                                            ),
                                            Divider(),
                                            AnimatedContainer(
                                              decoration: BoxDecoration(
                                                boxShadow: [
                                                  BoxShadow(
                                                      color: Color(0xFF546E7A),
                                                      blurRadius: 12)
                                                ],
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                border: Border.all(
                                                    color: Colors.blueGrey),
                                                color: _.oppened.value
                                                    ? Colors.blueGrey
                                                    : Colors.white,
                                              ),
                                              width: Get.width * 0.8,
                                              height: !_.oppened.value
                                                  ? Get.height * 0.45
                                                  : Get.height * 0.20,
                                              duration: durationAni,
                                              child: AnimatedSwitcher(
                                                duration: durationAni,
                                                child: _.oppened.value
                                                    ? Center(
                                                        child: Text(
                                                        "Gastos",
                                                        style: TextStyle(
                                                            fontSize: 30,
                                                            color:
                                                                Colors.white),
                                                      ))
                                                    : SingleChildScrollView(
                                                        child: Column(
                                                          children: [
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceEvenly,
                                                              children: [
                                                                Text(
                                                                  "Gastos",
                                                                  style: TextStyle(
                                                                      color: Color(
                                                                          0xFF37474F),
                                                                      fontSize:
                                                                          25),
                                                                ),
                                                              ],
                                                            ),
                                                            Container(
                                                                width: Get
                                                                        .context
                                                                        .width *
                                                                    0.7,
                                                                child:
                                                                    _cardExpensives())
                                                          ],
                                                        ),
                                                      ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          )),
                      _buttonSave()
                    ],
                  ),
                ),
              ),
            ]),
          )),
    );
  }

  _cardGains() {
    return Column(
      children: [
        TextFormField(
          controller: controller.txtUber,
          decoration: InputDecoration(labelText: "Uber"),
          textInputAction: TextInputAction.next,
          focusNode: controller.uberNode,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp('[0-9]')),
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
            FilteringTextInputFormatter.allow(RegExp('[0-9]')),
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
            FilteringTextInputFormatter.allow(RegExp('[0-9]')),
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
            FilteringTextInputFormatter.allow(RegExp('[0-9]')),
            RealInputFormatter(centavos: true)
          ],
          keyboardType: TextInputType.numberWithOptions(decimal: true),
          validator: (value) => controller.validator(value),
        ),
      ],
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
            FilteringTextInputFormatter.allow(RegExp('[0-9]')),
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
            FilteringTextInputFormatter.allow(RegExp('[0-9]')),
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
            FilteringTextInputFormatter.allow(RegExp('[0-9]')),
            RealInputFormatter(centavos: true)
          ],
          keyboardType: TextInputType.numberWithOptions(decimal: true),
          validator: (value) => controller.validator(value),
        ),
      ],
    );
  }

  _buttonSave() {
    return Container(
      width: Get.width * 0.5,
      decoration: BoxDecoration(
          color: Color(0xFF90A4AE),
          gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              colors: [Color(0xFF37474F), Color(0xFF90A4AE)]),
          boxShadow: [
            BoxShadow(color: Color(0xFF263238), blurRadius: 10, spreadRadius: 1)
          ],
          border: Border.all(color: Color(0xFF90A4AE), width: 3),
          borderRadius: BorderRadius.circular(15)),
      child: FlatButton(
          child: Text(
            "Salvar",
            style: TextStyle(fontSize: 20, color: Color(0xFFECEFF1)),
          ),
          // color: Color(0xFF546E7A),
          onPressed: () {
            controller.save();
          }),
    );
  }
}
