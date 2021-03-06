import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tdriver2/app/modules/releases/releases_controller.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:tdriver2/app/modules/widgets/background_app.dart';

class ReleasesPage extends GetView<ReleasesController> {
  final durationAni = Duration(milliseconds: 300);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (builder, constraints) {
      return WillPopScope(
        onWillPop: () async {
          if (await controller.canPop()) {
            Get.back(result: true);
            return true;
          } else {
            return false;
          }
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
                          height:
                              constraints.maxWidth * 0.15, //Get.height * 0.06,
                          child: Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    top: constraints.maxHeight * 0.02,
                                    left: constraints.maxWidth * 0.06),
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
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: constraints.maxWidth * 0.5,
                                height: constraints.maxHeight * 0.07,
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
                                        context: Get.context!,
                                        locale: Locale('pt'),
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime.now()
                                            .subtract(Duration(days: 365)),
                                        lastDate: DateTime.now()
                                            .add(Duration(days: 730)),
                                        
                                        
                                          // builder:
                                          //     (BuildContext context, Widget child) {
                                          //   return Theme(
                                          //     data: ThemeData.light().copyWith(
                                          //       colorScheme:
                                          //           ColorScheme.light().copyWith(
                                          //         primary: Colors.blueGrey,
                                          //       ),
                                          //     ),
                                          //     child: child,
                                          //   );
                                          // },
                                        );

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
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              bottom: constraints.maxHeight * 0.04),
                        ),
                        Container(
                            height: Get.height * 0.7,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [_containerCads(constraints)],
                            )),
                        _buttonSave()
                      ],
                    ),
                  ),
                ),
              ]),
            )),
      );
    });
  }

  _containerCads(BoxConstraints constraints) {
    return GetX<ReleasesController>(
      builder: (_) {
        return GestureDetector(
          onTap: () => _.oppened.value = !_.oppened.value,
          child: Center(
            child: Form(
              key: controller.formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedContainer(
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(color: Colors.white70, blurRadius: 12)
                        ],
                        gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: !_.oppened.value
                                ? [Color(0xFF546E7A), Color(0xFF35454d)]
                                : [Colors.white, Colors.white]),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.blueGrey),
                        color:
                            _.oppened.value ? Colors.white70 : Colors.blueGrey),
                    width: constraints.maxWidth * 0.9,
                    height:
                        _.oppened.value ? Get.height * 0.45 : Get.height * 0.20,
                    duration: durationAni,
                    child: AnimatedSwitcher(
                      duration: durationAni,
                      child: !_.oppened.value
                          ? Center(
                              child: Text(
                              "Ganhos",
                              style:
                                  TextStyle(fontSize: 30, color: Colors.white),
                            ))
                          : SingleChildScrollView(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        "Ganhos",
                                        style: TextStyle(
                                            color: Color(0xFF37474F),
                                            fontSize: 25),
                                      ),
                                    ],
                                  ),
                                  Container(
                                      color: Colors.transparent,
                                      width: Get.context!.width * 0.8,
                                      child: _cardGains())
                                ],
                              ),
                            ),
                    ),
                  ),
                  Divider(),
                  AnimatedContainer(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(color: Colors.white70, blurRadius: 12)
                      ],
                      gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: _.oppened.value
                              ? [Color(0xFF546E7A), Color(0xFF35454d)]
                              : [Colors.white, Colors.white]),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.blueGrey),
                      color: _.oppened.value ? Colors.blueGrey : Colors.white70,
                    ),
                    width: constraints.maxWidth * 0.9,
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
                              style:
                                  TextStyle(fontSize: 30, color: Colors.white),
                            ))
                          : SingleChildScrollView(
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        "Gastos",
                                        style: TextStyle(
                                            color: Color(0xFF37474F),
                                            fontSize: 25),
                                      ),
                                    ],
                                  ),
                                  Container(
                                      width: Get.context!.width * 0.8,
                                      child: _cardExpensives())
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
                Get.context!, controller.uberNode, controller.popNode);
          },
          keyboardType: TextInputType.numberWithOptions(decimal: true),
          keyboardAppearance: Brightness.light,
          validator: (value) => controller.validator(value),
          onChanged: (value) => controller.preventPop.value = true,
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
                Get.context!, controller.popNode, controller.cabifyNode);
          },
          keyboardType: TextInputType.numberWithOptions(decimal: true),
          validator: (value) => controller.validator(value),
          onChanged: (value) => controller.preventPop.value = true,
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
                Get.context!, controller.popNode, controller.particularNode);
          },
          keyboardType: TextInputType.numberWithOptions(decimal: true),
          validator: (value) => controller.validator(value),
          onChanged: (value) => controller.preventPop.value = true,
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
          onChanged: (value) => controller.preventPop.value = true,
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
            controller.fieldFocusChange(Get.context!, controller.combustivelNode,
                controller.alimentacaoNode);
          },
          keyboardType: TextInputType.numberWithOptions(decimal: true),
          validator: (value) => controller.validator(value),
          onChanged: (value) => controller.preventPop.value = true,
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
            controller.fieldFocusChange(Get.context!, controller.alimentacaoNode,
                controller.manutencaoNode);
          },
          keyboardType: TextInputType.numberWithOptions(decimal: true),
          validator: (value) => controller.validator(value),
          onChanged: (value) => controller.preventPop.value = true,
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
          onChanged: (value) => controller.preventPop.value = true,
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
          onPressed: () {
            controller.save();
          }),
    );
  }
}
