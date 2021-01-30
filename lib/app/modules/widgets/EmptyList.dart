import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:tdriver2/app/modules/home/home_controller.dart';

class ListaVazia extends StatelessWidget {
  ListaVazia({Key key}) : super(key: key);

  final HomeController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Center(
          child: Container(
            width: Get.width,
            height: Get.height,
            decoration: BoxDecoration(
              // borderRadius: BorderRadius.circular(20),
              color: Colors.black26,
            ),
          ),
        ),
        Obx(() => controller.newUser.value ? _newUser() : _oldUser())
      ],
    );
  }
}

_newUser() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Text("Seja bem vindo ao TDriver!",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 26)),
      Padding(
        padding: EdgeInsets.all(20),
      ),
      Text(
        "Parece que você ainda não iniciou o seu controle.",
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 26),
      ),
      Padding(
        padding: EdgeInsets.all(10),
      ),
      Lottie.asset('assets/new_user.json',
          repeat: true,
          reverse: false,
          animate: true,
          width: Get.width * 0.7,
          height: Get.height * 0.4),
      Text(
        "Bora começar ?",
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 26),
      ),
    ],
  );
}

_oldUser() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Text(
        "Parece que vc ainda não inseriu nenhum dado para o ano selecionado",
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 26),
      ),
      Padding(
        padding: EdgeInsets.all(5),
      ),
      Lottie.asset('assets/empty_list.json',
          repeat: true,
          reverse: false,
          animate: true,
          width: Get.width * 0.7,
          height: Get.height * 0.4),
      Text(
        "Não se preocupe, basta você clicar no botão abaixo e começar agora mesmo",
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 26),
      ),
    ],
  );
}
