import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CalculoAceitacaoController extends GetxController {
  final recebidas = 0.obs;
  final aceitas = 0.obs;
  final resultado = ''.obs;

  final txtRecebidas = TextEditingController();
  final txtAceitas = TextEditingController();

  final recebidasNode = FocusNode();
  final aceitasNode = FocusNode();

  final messageError = ''.obs;
  final colorResp = Colors.green[100].obs;

  int get recusadas => recebidas.value - aceitas.value;
  double get percentAccpet => aceitas.value / recebidas.value;

  fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  validate() {
    if (txtAceitas.text.isEmpty || txtRecebidas.text.isEmpty) {
      Get.rawSnackbar(
        message:
            'É necessário preencher todos os campos para efetuar o cálculo.',
      );

      resultado.value = '';
      return false;
    }

    if (aceitas.value > recebidas.value) {
      Get.rawSnackbar(
        message:
            'O número de solicitações recebidas deve ser maior que o de solicitações aceitas.',
      );
      resultado.value = '';
      return false;
    }
    return true;
  }

  calcular() {
    if (validate()) {
      if (percentAccpet >= 0.8) {
        resultado.value = "Parabéns, você possui aceitação acima de 80%.";
        colorResp.value = Colors.green;
        return;
      }

      int calculo = ((recusadas * 100) ~/ 20) - recebidas.value;

      resultado.value =
          'Você precisa aceitar mais $calculo viagens para atingir 80% de aceitação.';
      colorResp.value = Colors.red;
    }
  }
}
