import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store/bindings/binding.dart';
import 'package:store/core/localization/changelocal.dart';
import 'package:store/core/localization/translation.dart';
import 'package:store/core/services/services.dart';
import 'package:store/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialServices();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    LocaleController controller = Get.put(LocaleController());
    return GetMaterialApp(
      translations: MyTranslation(),
      debugShowCheckedModeBanner: false,
      title: 'eGift',
      locale: controller.appLanguage,
      theme: controller.appTheme,
      // home: // Test(),

      initialBinding: MyBinding(),
      // routes: routes,
      getPages: routes,
    );
  }
}
