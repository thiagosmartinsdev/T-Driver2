import 'package:get/get.dart';
import 'package:tdriver2/app/modules/earnings/earnings_page.dart';
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
      page: () => EarningsPage()
    )

  ];
}
