import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';
import 'package:tdriver2/app/BD/bd.dart';
import 'package:tdriver2/app/data/model/movimentacao.dart';
import 'package:tdriver2/app/data/repository/releases_repository.dart';
import 'package:tdriver2/app/modules/home/widgets/lista_ultimos_lancamentos.dart';

class ReleasesController extends GetxController {
  final ReleasesRepository repository;
  ReleasesController({@required this.repository}) : assert(repository != null);

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

  List<MovimentacaoModel> listaMovimentacoes = List();

  @override
  void onInit() {
    txtDate.text = DateFormat("dd/MM/yyyy").format(DateTime.now()).toString();
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

  Future save() async {
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
    try {
      repository.add(listaMovimentacoes);

      Get.defaultDialog(
          title: "Sucesso", middleText: "Registros incluídos com sucesso!");
    } on Exception catch (e) {
      print(e);
    }
  }
}
