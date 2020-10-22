import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:tdriver2/app/data/model/movimentacao.dart';
import 'package:tdriver2/app/data/provider/api.dart';
import 'package:tdriver2/app/data/repository/home_repository.dart';

class HomeController extends GetxController {
  final HomeRepository repository;
  HomeController({@required this.repository}) : assert(repository != null);

  var lastReleases = List<MovimentacaoModel>().obs;

  @override
  onInit() async {
    List lista = await repository.getAll();

    lista.forEach((element) {
      lastReleases.add(element);
    });
    
  }

  final _obj = ''.obs;
  set obj(value) => this._obj.value = value;
  get obj => this._obj.value;
}
