import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tdriver2/app/modules/home/home_controller.dart';
import 'package:tdriver2/app/modules/home/widgets/lista_ultimos_lancamentos.dart';
import 'package:tdriver2/app/modules/home/widgets/swipper_cards.dart';
import 'package:tdriver2/app/modules/home/widgets/year_date_picker.dart';
import 'package:tdriver2/app/modules/widgets/EmptyLIst.dart';
import 'package:tdriver2/app/modules/widgets/background_app.dart';

class HomePage extends GetView<HomeController> {
  final GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (builder, constraints) {
      return Scaffold(
          resizeToAvoidBottomInset: false,
          // resizeToAvoidBottomPadding: true,
          backgroundColor: Color(0xFFFAFAFA),
          extendBody: true,
          key: _drawerKey,
          drawer: Drawer(
              child: Container(
                  color: Colors.black12,
                  child: Stack(
                    children: [
                      BackGrroundApp(),
                      ListView(
                        padding: EdgeInsets.zero,
                        children: [
                          Container(
                            height: Get.height * 0.2,
                            child: DrawerHeader(
                              child: Center(
                                  child: Text(
                                "TDriver",
                                style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: Get.width * 0.1),
                              )),
                              decoration: BoxDecoration(color: Colors.white38),
                            ),
                          ),
                          ListTile(
                              leading: Text(
                                '%',
                                style: TextStyle(
                                    color: Color(0xFFFAFAFA),
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                              title: Text(
                                "Taxa de  Aceitação",
                                style: TextStyle(
                                    color: Color(0xFFFAFAFA),
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                              onTap: () async {
                                final accpetance =
                                    await Get.toNamed('/acceptance');
                                if (accpetance) Get.back();
                              }),
                        ],
                      ),
                    ],
                  ))),
          body: SafeArea(
            top: false,
            bottom: false,
            child: Obx(() => Stack(children: [
                  BackGrroundApp(),
                  controller.lastReleases.isEmpty
                      ? ListaVazia()
                      : Container(
                          height: double.infinity,
                          width: constraints.maxWidth,
                          padding: EdgeInsets.only(top: Get.height * 0.11),
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
                  Padding(
                    padding: EdgeInsets.only(top: 8.0),
                    child: Container(
                        padding: EdgeInsets.only(top: Get.height * 0.03),
                        height: Get.height * 0.09,
                        child: _menuAndYear()),
                  ),
                  _buttomAdd(),
                ])),
          ));
    });
  }

  _menuAndYear() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.only(left: Get.width * 0.06),
          child: IconButton(
            onPressed: () => _drawerKey.currentState!.openDrawer(),
            icon: Icon(
              Icons.menu,
              size: 30,
            ),
            color: Colors.white,
          ),
        ),
        Padding(
            padding: EdgeInsets.only(right: Get.width * 0.06),
            child: MaterialButton(
              highlightElevation: 10,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              elevation: 10,
              color: Color(0xFF607D8B),
              animationDuration: Duration(seconds: 1),
              onPressed: () async {
                final dateSelected = await showYearPicker(
                  title: Text("Selecione o ano"),
                  context: Get.context!,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.utc(2014, 1, 1),
                  lastDate: DateTime.now(), titlePadding: EdgeInsetsGeometry.infinity,
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
    return Container(height: Get.height * 0.40, child: SwipperCards());
  }

  _textLasReleases() {
    return Container(
      width: Get.width,
      height: Get.height * 0.067,
      alignment: Alignment.center,
      padding: EdgeInsets.only(bottom: Get.height * 0.01),
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
        child: ListaUltimosLancamentos()
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
