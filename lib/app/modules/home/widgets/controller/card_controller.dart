import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:tdriver2/app/data/repository/home_repository.dart';

class CardController extends GetxController {
  final HomeRepository repository;
  CardController({@required this.repository}) : assert(repository != null);

  final _obj = ''.obs;
  set obj(value) => this._obj.value = value;
  get obj => this._obj.value;
}