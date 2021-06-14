import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tdriver2/app/data/service/home_service.dart';
import 'package:tdriver2/app/modules/home/home_binding.dart';
import 'app/modules/home/home_page.dart';
import 'app/routes/app_pages.dart';
import 'app/theme/theme.dart';
import 'package:get/get.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

Future<void> main() async {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Color(0xFF546E7A),
      systemNavigationBarIconBrightness: Brightness.light));
  WidgetsFlutterBinding.ensureInitialized();

  await initServices();

  runApp(GetMaterialApp(
    initialRoute: Routes.INITIAL,
    initialBinding: HomeBinding(),
    getPages: AppPages.pages,
    defaultTransition: Transition.cupertino,
    debugShowCheckedModeBanner: false,
    theme: appThemeData,
    locale: Locale('pt', 'BR'),
    localizationsDelegates: [
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate
    ],
    supportedLocales: [Locale('pt')],
    home: HomePage(),
  ));
}

Future<void> initServices() async {
  await GetStorage.init();
  await Get.putAsync(() async => HomeService().init());
}
