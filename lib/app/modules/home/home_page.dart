import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tdriver2/app/modules/home/home_controller.dart';
import 'package:tdriver2/app/modules/home/widgets/cardHome.dart';
import 'package:tdriver2/app/modules/home/widgets/lista_ultimos_lancamentos.dart';

class HomePage extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        resizeToAvoidBottomPadding: true,
        extendBody: true,
        body: SafeArea(
          top: false,
          bottom: false,
          child: Container(
            height: double.infinity,
            padding: EdgeInsets.only(top: 20),
            decoration: BoxDecoration(
                gradient: new LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                  Color.fromRGBO(183, 248, 219, 100),
                  Color.fromRGBO(80, 167, 194, 100)
                ])),
            child: Column(
              children: <Widget>[
                Container(
                  height: Get.height * 0.06,
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: Get.width * 0.06),
                        child: Icon(
                          Icons.menu,
                          size: 30,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: Get.height * 0.4,
                  child: _cards(),
                ),
                Container(
                  child: _textoUltimosLancamentos(),
                ),
                Expanded(
                  child: Container(
                    child: Stack(
                      children: [
                        _listaUltimosLancamentos(),
                        _botaoAdd(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
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

  _botaoAdd() {
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
                  colors: [Color(0xFFFF7000), Colors.orange[200]]),
              boxShadow: [
                BoxShadow(
                    color: Colors.orange[100], blurRadius: 20, spreadRadius: 1)
              ],
              border: Border.all(color: Colors.orange, width: 3),
              borderRadius: BorderRadius.circular(15)),
          child: IconButton(
              padding: EdgeInsets.zero,
              icon: Icon(
                Icons.add,
                color: Colors.white,
                size: 40,
              ),
              onPressed: () => Get.toNamed("/cadastro")),
        ),
      ),
    );
  }
}
