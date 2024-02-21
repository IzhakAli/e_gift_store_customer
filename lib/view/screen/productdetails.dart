import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store/controller/productdetails_controller.dart';
import 'package:store/core/class/handlingdataview.dart';
import 'package:store/view/widget/productdetails/imageclippath.dart';

import '../../core/constant/routes.dart';
import '../../linkapi.dart';
import '../widget/productdetails/all_details.dart';

class ProductDetails extends StatelessWidget {
  const ProductDetails({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ProductDetailsControllerImp());
    return Scaffold(
        appBar: AppBar(
          title: const Text("Gift Details"),
        ),
        body: GetBuilder<ProductDetailsControllerImp>(builder: (controller) {
          return HandlingDataView(
              statusRequest: controller.statusRequest,
              widget: Column(children: <Widget>[
                ImageClipPathProductDetails("${controller.itemsModel.itemsId}",
                    "${AppLink.imageItems}/${controller.itemsModel.itemsImage}"),
                ProductAllDetails(
                  onAdd: () {
                    controller.add();
                  },
                  onRemove: () {
                    controller.remove();
                  },
                  onPressedGoToCart: () {
                    Get.toNamed(AppRoute.cart);
                  },
                )
              ]));
        }));
  }
}
