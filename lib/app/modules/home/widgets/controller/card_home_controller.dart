import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:tdriver2/app/data/repository/releases_repository.dart';

class CardController extends GetxController {
  final ReleasesRepository repository;
  CardController({@required this.repository}) : assert(repository != null);

  final earnings = ''.obs;
  final expensives = ''.obs;

  final _obj = ''.obs;
  set obj(value) => this._obj.value = value;
  get obj => this._obj.value;
}
