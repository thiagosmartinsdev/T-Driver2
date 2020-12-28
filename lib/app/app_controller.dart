import 'package:get/get.dart';
import 'package:meta/meta.dart';

import 'data/repository/releases_repository.dart';

class AppController extends GetxController {
  final ReleasesRepository repository;
  AppController({@required this.repository}) : assert(repository != null);

  final _obj = ''.obs;
  set obj(value) => this._obj.value = value;
  get obj => this._obj.value;
}
