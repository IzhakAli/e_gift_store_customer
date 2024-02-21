import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store/controller/favorite_controller.dart';
import 'package:store/controller/offers_controller.dart';
import 'package:store/core/class/handlingdataview.dart';

import '../../core/constant/routes.dart';
import '../widget/searchbar.dart';
import 'home.dart';
import 'offers/customitemsoffers.dart';

class OffersView extends StatelessWidget {
  const OffersView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(OffersController());
    Get.put(FavoriteControllerImp());

    return GetBuilder<OffersController>(
      builder: (controller) => Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
        ),
        child: ListView(
          children: [
            CustomAppBar(
              mycontroller: controller.search!,
              barHintText: "Find Gift",
              onPressedIconFavorite: () {
                Get.toNamed(AppRoute.myFavorite);
              },
              onPressedSearch: () {
                controller.onSearchItems();
              },
              onChanged: (String val) {
                controller.checkSearch(val);
              },
            ),
            const SizedBox(
              height: 15,
            ),
            !controller.isSearch
                ? HandlingDataView(
                    statusRequest: controller.statusRequest,
                    widget: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: controller.data.length,
                      itemBuilder: (context, index) => CustomListItemsOffers(
                          itemsModel: controller.data[index]),
                    ))
                : ListItemsSearch(listdatamodel: controller.listdata)
          ],
        ),
      ),
    );
  }
}
