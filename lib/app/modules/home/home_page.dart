import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tdriver2/app/modules/home/home_controller.dart';
import 'package:tdriver2/app/modules/home/widgets/lista_ultimos_lancamentos.dart';
import 'package:tdriver2/app/modules/home/widgets/swipper_cards.dart';
import 'package:tdriver2/app/modules/widgets/EmptyLIst.dart';
import 'package:tdriver2/app/modules/widgets/background_app.dart';
import 'package:flutter_datepicker_single/flutter_datepicker_single.dart';

class HomePage extends GetView<HomeController> {
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        resizeToAvoidBottomPadding: true,
        backgroundColor: Color(0xFFFAFAFA),
        extendBody: true,
        key: _drawerKey,
        drawer: Drawer(
            // key: _drawerKey,
            child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              child: Text("TDriver"),
              decoration: BoxDecoration(color: Colors.white38),
            ),
            ListTile(
              title: Text("Taxa de  Aceitação"),
            )
          ],
        )),
        body: SafeArea(
          top: false,
          bottom: false,
          child: Obx(
            () => Stack(children: [
              BackGrroundApp(),
              controller.lastReleases.isEmpty
                  ? ListaVazia()
                  : Container(
                      height: double.infinity,
                      padding: EdgeInsets.only(top: Get.height * 0.09),
                      child: Column(
                        children: <Widget>[
                          Container(
                            height: Get.height * 0.4,
                            child: _cards(),
                          ),
                          Container(
                            child: _textLasReleases(),
                          ),
                          Expanded(
                            child: Container(
                              width: Get.width,
                              child: Stack(
                                children: [
                                  _listLastReleases(),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
              Container(
                  padding: EdgeInsets.only(top: Get.height * 0.03),
                  height: Get.height * 0.09,
                  child: _menuAndYear()),
              _buttomAdd(),
            ]),
          ),
        ));
  }

  _menuAndYear() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding:
              EdgeInsets.only(top: Get.height * 0.01, left: Get.width * 0.06),
          child: IconButton(
            onPressed: () => _drawerKey.currentState.openDrawer(),
            icon: Icon(
              Icons.menu,
              size: 30,
            ),
            color: Colors.white,
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
    return SizedBox(height: Get.height * 0.40, child: SwipperCards());
  }

  _textLasReleases() {
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

  _listLastReleases() {
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
                var refresh = await Get.toNamed("/cadastro");
                if (refresh) controller.resetHome();
              }),
        ),
      ),
    );
  }
}
