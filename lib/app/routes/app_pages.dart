import 'package:get/get.dart';
import 'package:tdriver2/app/modules/details/details_binding.dart';
import 'package:tdriver2/app/modules/details/details_page.dart';
import 'package:tdriver2/app/modules/releases/releases_binding.dart';
import 'package:tdriver2/app/modules/releases/releases_page.dart';
import 'package:tdriver2/app/modules/home/home_page.dart';
part './app_routes.dart';

abstract class AppPages {
  static final pages = [
    GetPage(
      name: Routes.HOME,
      page: () => HomePage(),
    ),
    GetPage(
        name: Routes.CADASTRO,
        page: () => ReleasesPage(),
        binding: ReleasesBinding()),
    GetPage(
        name: Routes.DETAIL,
        page: () => DetailsPage(),
        binding: DetailsBinding())
  ];
}
