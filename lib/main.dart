import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:tdriver2/app/data/home_service.dart';
import 'package:tdriver2/app/modules/home/home_binding.dart';
import 'app/modules/home/home_page.dart';
import 'app/routes/app_pages.dart';
import 'app/theme/theme.dart';
import 'package:get/get.dart';

Future<void> main() async {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.black45,
      systemNavigationBarIconBrightness: Brightness.light));
  WidgetsFlutterBinding.ensureInitialized();

  await initServices();

  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: Routes.INITIAL,
    initialBinding: HomeBinding(),
    theme: appThemeData,
    defaultTransition: Transition.cupertino,
    getPages: AppPages.pages,
    home: HomePage(),
  ));
}

initServices() async {
  await Get.putAsync(() => HomeService().init());
}
