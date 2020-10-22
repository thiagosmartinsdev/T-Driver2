import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:tdriver2/app/data/repository/earnings_repository.dart';

class EarningsController extends GetxController {
  final EarningsRepository repository;
  EarningsController({@required this.repository}) : assert(repository != null);

  final _obj = ''.obs;
  set obj(value) => this._obj.value = value;
  get obj => this._obj.value;
}
