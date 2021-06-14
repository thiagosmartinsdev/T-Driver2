import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:tdriver2/app/modules/home/home_controller.dart';

class ListaVazia extends StatelessWidget {
  ListaVazia();

  final HomeController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (builder, constraints) {
      return Stack(
        children: <Widget>[
          Center(
            child: Container(
              width: constraints.maxWidth,
              height: constraints.maxHeight,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [Color(0xFF546E7A), Color(0xFF35454d)])),
            ),
          ),
          Center(
            child: Container(
                padding: EdgeInsets.all(40),
                alignment: Alignment.center,
                width: constraints.maxWidth,
                height: constraints.maxHeight * 0.8,
                child: Obx(() => controller.newUser.value
                    ? _newUser(constraints)
                    : _oldUser())),
          )
        ],
      );
    });
  }
}

_newUser(BoxConstraints constraints) {
  return Container(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        AutoSizeText("Seja bem vindo ao TDriver!",
            // minFontSize: 18,
            maxLines: 1,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 35,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            )),
        Padding(
          padding: EdgeInsets.all(20),
        ),
        AutoSizeText(
          "Parece que você ainda não iniciou o seu controle.",
          maxLines: 2,
          minFontSize: 18,
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 30),
        ),
        Padding(
          padding: EdgeInsets.all(10),
        ),
        AspectRatio(
          aspectRatio: 1.0,
          child: Lottie.asset(
            'assets/new_user.json',
            repeat: true,
            reverse: false,
            animate: true,
          ),
        ),
        AutoSizeText(
          "Bora começar ?",
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 26),
        ),
      ],
    ),
  );
}

_oldUser() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      AutoSizeText(
        "Parece que vc ainda não inseriu nenhum dado para o ano selecionado",
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
      ),
      Padding(
        padding: EdgeInsets.all(5),
      ),
      // AspectRatio(
      //   aspectRatio: 1.5,
      //   child: Lottie.asset('assets/empty_list.json',
      //       repeat: true,
      //       reverse: false,
      //       animate: true,
      //       width: Get.width * 0.7,
      //       height: Get.height * 0.4),
      // ),
      AutoSizeText(
        "Não se preocupe, basta clicar no botão abaixo e começar agora mesmo",
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
      ),
    ],
  );
}
