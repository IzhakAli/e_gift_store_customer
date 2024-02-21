import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store/controller/home_controller.dart';
import 'package:store/core/constant/routes.dart';
import 'package:store/view/widget/home/category_list.dart';
import 'package:store/view/widget/home/custom_title_home.dart';

import '../../core/class/handlingdataview.dart';
import '../../data/model/itemsmodel.dart';
import '../../linkapi.dart';
import '../widget/home/items_list.dart';
import '../widget/home/promo_banner.dart';
import '../widget/searchbar.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(HomeControllerImp());
    return GetBuilder<HomeControllerImp>(
      builder: (controller) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
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
              HandlingDataView(
                  statusRequest: controller.statusRequest,
                  widget: !controller.isSearch
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            PromoBanner(
                              title: "${controller.titleHomeCard}",
                              body: "${controller.bodyHomeCard}",
                            ),
                            const CustomTitleHome(title: "Categories"),
                            const MyCategoryList(),
                            const CustomTitleHome(title: "Top Selling"),
                            MyItemsListHome(
                              items: controller.items,
                              listdatamodel: controller.listdata,
                            ),
                            // const CustomTitleHome(title: "Free Delivery"),
                            // MyItemsListHome(items: controller.items),
                          ],
                        )
                      : ListItemsSearch(listdatamodel: controller.listdata))
            ],
          ),
        );
      },
    );
  }
}

class ListItemsSearch extends GetView<HomeControllerImp> {
  final List<ItemsModel> listdatamodel;
  const ListItemsSearch({Key? key, required this.listdatamodel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: listdatamodel.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              controller.goToPageProductDetails(listdatamodel[index]);
            },
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 20),
              child: Card(
                  child: Container(
                padding: EdgeInsets.all(10),
                child: Row(
                  children: [
                    Container(
                      height: Get.height * 0.17,
                      child: CachedNetworkImage(
                          imageUrl:
                              "${AppLink.imageItems}/${listdatamodel[index].itemsImage}"),
                    ),
                    Expanded(
                        flex: 2,
                        child: ListTile(
                          title: Text(listdatamodel[index].itemsName!),
                          subtitle: Text(listdatamodel[index].categoriesName!),
                        )),
                  ],
                ),
              )),
            ),
          );
        });
  }
}
