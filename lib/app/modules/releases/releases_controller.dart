import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';
import 'package:tdriver2/app/data/model/movimentacao.dart';
import 'package:tdriver2/app/data/repository/releases_repository.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:tdriver2/app/modules/home/home_controller.dart';

class ReleasesController extends GetxController {
  final ReleasesRepository repository;
  ReleasesController({@required this.repository}) : assert(repository != null);

  final HomeController homeController = Get.find();
  final oppened = true.obs;

  final formKey = GlobalKey<FormState>();

  final txtDate = TextEditingController();
  final selectedDate = DateTime.now().obs;

  final txtUber = TextEditingController();
  final txtCabify = TextEditingController();
  final txt99Pop = TextEditingController();
  final txtParticular = TextEditingController();
  final txtCombustivel = TextEditingController();
  final txtAlimentacao = TextEditingController();
  final txtManutencao = TextEditingController();

  final uberNode = FocusNode();
  final cabifyNode = FocusNode();
  final popNode = FocusNode();
  final particularNode = FocusNode();

  final combustivelNode = FocusNode();
  final alimentacaoNode = FocusNode();
  final manutencaoNode = FocusNode();

  final visible = true.obs;

  List<MovimentacaoModel> listaMovimentacoes = List();

  // HomeController homeControl = Get.find();

  @override
  void onInit() {
    txtDate.text = DateFormat("dd/MM/yyyy").format(DateTime.now()).toString();
    super.onInit();
  }

  fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  validator(value) {
    if (value.isNotEmpty) {
      String _onlyDigits = value.replaceAll(RegExp('[^0-9]'), "");

      if (double.parse(_onlyDigits) == 0.0) {
        return 'Valor inválido';
      }
    }
    return null;
  }

  double convertStringToDouble(String value) {
    return double.parse(value.replaceAll(RegExp('[^0-9]'), "")) / 100;
  }

  resetForm() {
    listaMovimentacoes.clear();

    txtUber.clear();
    txt99Pop..clear();
    txtCabify.clear();
    txtParticular.clear();
    txtCombustivel.clear();
    txtAlimentacao.clear();
    txtManutencao.clear();

    oppened.value = true;
  }

  Future save() async {
    if (!formKey.currentState.validate()) {
      return false;
    } else {
      if (txtUber.text.isNotEmpty)
        listaMovimentacoes.add(MovimentacaoModel(null, 1, 1, null,
            convertStringToDouble(txtUber.text), selectedDate.value));

      if (txtCabify.text.isNotEmpty)
        listaMovimentacoes.add(MovimentacaoModel(null, 1, 2, null,
            convertStringToDouble(txtCabify.text), selectedDate.value));

      if (txt99Pop.text.isNotEmpty)
        listaMovimentacoes.add(MovimentacaoModel(null, 1, 3, null,
            convertStringToDouble(txt99Pop.text), selectedDate.value));

      if (txtParticular.text.isNotEmpty)
        listaMovimentacoes.add(MovimentacaoModel(null, 1, 4, null,
            convertStringToDouble(txtParticular.text), selectedDate.value));

      if (txtCombustivel.text.isNotEmpty)
        listaMovimentacoes.add(MovimentacaoModel(null, 2, null, 1,
            convertStringToDouble(txtCombustivel.text), selectedDate.value));

      if (txtAlimentacao.text.isNotEmpty)
        listaMovimentacoes.add(MovimentacaoModel(null, 2, null, 2,
            convertStringToDouble(txtAlimentacao.text), selectedDate.value));

      if (txtManutencao.text.isNotEmpty)
        listaMovimentacoes.add(MovimentacaoModel(null, 2, null, 3,
            convertStringToDouble(txtManutencao.text), selectedDate.value));

      if (listaMovimentacoes.isEmpty) {
        Get.rawSnackbar(
            messageText: Text(
          'É necessário preencher pelo menos um campo para salvar',
          style: TextStyle(color: Colors.white),
        ));
        return;
      }

      try {
        repository.add(listaMovimentacoes);

        var user = GetStorage();
        if (user.read('newUser')) {
          user.write('newUser', false);
        }
        homeController.newUser.value = false;

        AwesomeDialog(
            context: Get.context,
            animType: AnimType.SCALE,
            headerAnimationLoop: true,
            dialogType: DialogType.SUCCES,
            title: 'Sucesso',
            desc: 'Registros salvos com sucesso!',
            autoHide: Duration(milliseconds: 2500),
            onDissmissCallback: () {
              resetForm();
            })
          ..show();
      } on Exception catch (e) {
        print(e);
      }
    }
  }
}
