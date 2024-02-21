import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/myfavorite_controller.dart';
import '../../core/class/handlingdataview.dart';
import '../widget/myfavorite/customlistfavoriteitems.dart';

class MyFavorite extends StatelessWidget {
  const MyFavorite({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.put(MyFavoriteControllerImp());
    return Scaffold(body: GetBuilder<MyFavoriteControllerImp>(
      builder: (controller) {
        return Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: ListView(children: [
              // MyHomeSearchBar(
              //   onPressedIconFavorite: () {},
              //   onPressedSearch: () {},
              //   barHintText: 'Find Gift',
              // ),
              const SizedBox(height: 20),
              HandlingDataView(
                  statusRequest: controller.statusRequest,
                  widget: GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: controller.data.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.7,
                    ),
                    itemBuilder: (context, index) {
                      return CustomListFavoriteItems(
                          itemsModel: controller.data[index]);
                    },
                  ))
            ]));
      },
    ));
  }
}
