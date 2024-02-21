import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';

import '../core/constant/routes.dart';
import '../core/services/services.dart';

class SettingsController extends GetxController {
  MyServices myServices = Get.find();

  logout() async {
    String? userid = myServices.sharedPreferences.getString("id");
    myServices.sharedPreferences.setString("step",
        "1"); //to only go back to login without going back all the way to language and onboarding
    FirebaseMessaging.instance.unsubscribeFromTopic("users");
    FirebaseMessaging.instance.unsubscribeFromTopic("users${userid}");
    await myServices.clearPreferencesExcept("lang", "step");
    Get.offAllNamed(AppRoute.login);
  }
}
