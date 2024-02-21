import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store/controller/favorite_controller.dart';

import '../../controller/items_controller.dart';
import '../../core/class/handlingdataview.dart';
import '../../core/constant/routes.dart';
import '../../data/model/itemsmodel.dart';
import '../widget/items/customlistitems.dart';
import '../widget/items/listcategoriesitems.dart';
import '../widget/searchbar.dart';
import 'home.dart';

class Items extends StatelessWidget {
  const Items({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ItemsControllerImp controller = Get.put(ItemsControllerImp());
    FavoriteControllerImp controllerFav = Get.put(FavoriteControllerImp());
    return Scaffold(
        body: Container(
      padding: const EdgeInsets.all(15),
      child: ListView(children: [
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
        const SizedBox(height: 20),
        const ListCategoriesItems(),
        GetBuilder<ItemsControllerImp>(
            builder: (controller) => HandlingDataView(
                statusRequest: controller.statusRequest,
                widget: !controller.isSearch
                    ? GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: controller.data.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.7,
                        ),
                        itemBuilder: (BuildContext context, index) {
                          controllerFav.isFavorite[controller.data[index]
                                  ['items_id']] =
                              controller.data[index]['favorite'];
                          return CustomListItems(
                            itemsModel:
                                ItemsModel.fromJson(controller.data[index]),
                          );
                        },
                      )
                    : ListItemsSearch(listdatamodel: controller.listdata)))
      ]),
    ));
  }
}
