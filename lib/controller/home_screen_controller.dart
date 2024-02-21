import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:store/view/screen/offers.dart';

import '../view/screen/home.dart';
import '../view/screen/notification.dart';
import '../view/screen/settings.dart';

abstract class HomeScreenController extends GetxController {
  changePage(int currentpage);
}

class HomeScreenControllerImp extends HomeScreenController {
  int currentpage = 0;

  List<Widget> listPage = [
    const HomePage(),
    const NotificationView(),
    const OffersView(),
    const Settings()
  ];

  List bottomappbar = [
    {"title": "Home", "icon": Icons.home_outlined},
    {"title": "Notifications", "icon": Icons.notifications_active_outlined},
    {"title": "Offers", "icon": Icons.local_offer_outlined},
    {"title": "Settings", "icon": Icons.settings_outlined},
  ];
  //
  // List<IconData> iconBottomAppBar = [
  //   Icons.home_outlined,
  //   Icons.favorite_border_outlined,
  //   Icons.person_outline,
  //   Icons.settings,
  // ];

  @override
  changePage(int i) {
    currentpage = i;
    update();
  }
}
