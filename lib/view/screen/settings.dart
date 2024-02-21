import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../controller/settings_controller.dart';
import '../../core/constant/color.dart';
import '../../core/constant/imageasset.dart';
import '../../core/constant/routes.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    SettingsController controller = Get.put(SettingsController());
    return Container(
      child: ListView(
        children: [
          Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                Container(height: Get.width / 3, color: AppColor.primary),
                Positioned(
                    top: Get.width / 4.5,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(100)),
                      child: CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.grey[100],
                        backgroundImage: const AssetImage(AppImageAsset.logo),
                      ),
                    )),
              ]),
          const SizedBox(height: 75),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Card(
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                // ListTile(
                //   // onTap: () {},
                //   trailing: Switch(onChanged: (val) {}, value: true),
                //   title: const Text("Disable Notifications"),
                // ),
                ListTile(
                  onTap: () {
                    Get.toNamed(AppRoute.orderspending);
                  },
                  trailing: const Icon(Icons.shopping_cart_outlined),
                  title: const Text("Orders"),
                ),
                ListTile(
                  onTap: () {
                    Get.toNamed(AppRoute.ordersarchive);
                  },
                  trailing: const Icon(Icons.archive),
                  title: const Text("Previous Orders"),
                ),
                ListTile(
                  onTap: () {
                    Get.toNamed(AppRoute.addressview);
                  },
                  trailing: const Icon(Icons.location_on_outlined),
                  title: const Text("Address"),
                ),
                ListTile(
                  onTap: () async {
                    await launchUrl(Uri.parse("https://calendar.google.com/"));
                  },
                  trailing: const Icon(Icons.calendar_month),
                  title: const Text("Calendar"),
                ),
                ListTile(
                  onTap: () {
                    Get.toNamed(AppRoute.aboutus);
                  },
                  trailing: const Icon(Icons.help_outline_rounded),
                  title: const Text("About us"),
                ),
                ListTile(
                  onTap: () async {
                    await launchUrl(Uri.parse("tel:777971925"));
                  },
                  trailing: const Icon(Icons.phone_callback_outlined),
                  title: const Text("Contact us"),
                ),
                ListTile(
                  onTap: () {
                    controller.logout();
                  },
                  title: const Text("Logout"),
                  trailing: const Icon(Icons.exit_to_app),
                ),
              ]),
            ),
          )
        ],
      ),
    );
  }
}
