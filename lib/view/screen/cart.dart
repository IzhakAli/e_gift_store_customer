import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store/controller/cart_controller.dart';
import 'package:store/core/class/handlingdataview.dart';
import 'package:store/core/functions/translatefatabase.dart';

import '../../core/constant/color.dart';
import '../widget/cart/custom_bottom_navgationbar_cart.dart';
import '../widget/cart/customitemscartlist.dart';
import '../widget/cart/topcardcart.dart';

class Cart extends StatelessWidget {
  const Cart({super.key});

  @override
  Widget build(BuildContext context) {
    CartController cartController = Get.put(CartController());
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColor.backGroundColor,
          title: const Text(
            "My Cart",
          ),
          centerTitle: true,
        ),
        bottomNavigationBar: GetBuilder<CartController>(builder: (controller) {
          return BottomNavgationBarCart(
            price: "${cartController.priceorders}",
            // shipping: "1000",
            discount: "${controller.discountcoupon}",
            totalprice: "${cartController.getTotalPrice()}",
            // onApplyCoupon: () {},
            // couponController: null,
          );
        }),
        body: GetBuilder<CartController>(
          builder: (controller) {
            return HandlingDataView(
                statusRequest: controller.statusRequest,
                widget: ListView(
                  children: [
                    // const TopAppbarCart(
                    //   title: 'My Cart',
                    // ),
                    TopCardCart(
                        message:
                            "You Have ${controller.totalcountitems} Items in Your List"),
                    Container(
                      padding: const EdgeInsets.only(
                          bottom: 10, right: 10, left: 10),
                      child: Column(
                        children: [
                          ...List.generate(
                            controller.data.length,
                            (index) => CustomItemsCartList(
                              controllercoupon: controller.controllercoupon!,
                              onApplyCoupon: () {
                                controller.checkcoupon();
                              },
                              imageName: controller.data[index].itemsImage!,
                              name: translateDatabase(
                                  controller.data[index].itemsNameAr,
                                  controller.data[index].itemsName),
                              price: translateDatabase(
                                  "${controller.data[index].itemspricee} ${"2".tr}"
                                      .toString(),
                                  "${controller.data[index].itemspricee} ${"2".tr}"),
                              count:
                                  controller.data[index].countitems.toString(),
                              onAdd: () async {
                                await controller.add(
                                    controller.data[index].itemsId.toString());
                                controller.refreshPage();
                              },
                              onRemove: () async {
                                await controller.delete(
                                    controller.data[index].itemsId.toString());
                                controller.refreshPage();
                              },
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ));
          },
        ));
  }
}
