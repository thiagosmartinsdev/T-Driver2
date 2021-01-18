import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tdriver2/app/modules/home/home_controller.dart';
import 'package:tdriver2/app/modules/home/widgets/cardHome.dart';
import 'package:tdriver2/app/modules/home/widgets/lista_ultimos_lancamentos.dart';
import 'package:tdriver2/app/modules/widgets/backGroundApp.dart';
import 'package:flutter_datepicker_single/flutter_datepicker_single.dart';

class HomePage extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        resizeToAvoidBottomPadding: true,
        backgroundColor: Color(0xFFFAFAFA),
        extendBody: true,
        body: SafeArea(
          top: false,
          bottom: false,
          child: Stack(children: [
            BackGrroundApp(),
            Container(
              height: double.infinity,
              padding: EdgeInsets.only(top: 20),
              child: Column(
                children: <Widget>[
                  Container(height: Get.height * 0.08, child: _menuAndYear()),
                  Container(
                    height: Get.height * 0.4,
                    child: _cards(),
                  ),
                  Container(
                    child: _textoUltimosLancamentos(),
                  ),
                  Expanded(
                    child: Container(
                      width: Get.width,
                      child: Stack(
                        children: [
                          _listaUltimosLancamentos(),
                          _buttomAdd(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ]),
        ));
  }

  _menuAndYear() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding:
              EdgeInsets.only(top: Get.height * 0.01, left: Get.width * 0.06),
          child: Icon(
            Icons.menu,
            size: 30,
          ),
        ),
        Padding(
            padding: EdgeInsets.only(
                top: Get.height * 0.01, right: Get.width * 0.06),
            child: MaterialButton(
              highlightElevation: 10,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              elevation: 10,
              color: Color(0xFF607D8B),
              animationDuration: Duration(seconds: 1),
              onPressed: () async {
                final dateSelected = await showYearPicker(
                  context: Get.context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.utc(2014, 1, 1),
                  lastDate: DateTime.now(),
                );

                if (dateSelected != null) {
                  controller.currentYear.value = dateSelected.year;
                }
              },
              child: Obx(
                () => Text(controller.currentYear.value.toString(),
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold)),
              ),
            )),
      ],
    );
  }

  _cards() {
    return SizedBox(
        height: Get.height * 0.40,
        child: Column(
          children: <Widget>[
            CardHome(cardMensal: false),
            CardHome(cardMensal: true),
          ],
        ));
  }

  _textoUltimosLancamentos() {
    return Container(
      width: Get.width,
      height: Get.height * 0.067,
      alignment: Alignment.center,
      child: Text("Últimos lançamentos",
          style: TextStyle(
              color: Color(0xFF636363),
              fontWeight: FontWeight.bold,
              fontSize: 20)),
    );
  }

  _listaUltimosLancamentos() {
    return Center(
      child: Container(
        width: Get.width * 0.95,
        child: ListaUltimosLancamentos(),
      ),
    );
  }

  _buttomAdd() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Card(
        elevation: 10,
        child: Container(
          alignment: Alignment.center,
          width: Get.width * 0.15,
          height: Get.width * 0.15,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  colors: [
                    Color(0xFF263238),
                    Color(0xFF90A4AE)
                  ]), //Colors.orange[200]]),
              boxShadow: [
                BoxShadow(
                    color: Color(0xFF263238), blurRadius: 10, spreadRadius: 1)
              ],
              border: Border.all(color: Color(0xFF90A4AE), width: 3),
              borderRadius: BorderRadius.circular(15)),
          child: IconButton(
              padding: EdgeInsets.zero,
              icon: Icon(
                Icons.add,
                color: Colors.white,
                size: 40,
              ),
              onPressed: () async {
                await Get.toNamed("/cadastro");
                controller.resetHome();
              }),
        ),
      ),
    );
  }
}
