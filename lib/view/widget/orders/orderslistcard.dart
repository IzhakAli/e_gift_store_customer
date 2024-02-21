import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';

import '../../../controller/orders/pending_controller.dart';
import '../../../core/constant/color.dart';
import '../../../core/constant/routes.dart';
import '../../../data/model/ordersmodel.dart';

class CardOrdersList extends GetView<OrdersPendingController> {
  final OrdersModel listdata;
  const CardOrdersList({Key? key, required this.listdata}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text("Order Number : #${listdata.ordersId}",
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold)),
                  const Spacer(),
                  // Text(listdata.ordersDatetime!), , "yyyy-MM-dd"
                  Text(
                    Jiffy.parse(listdata.ordersDatetime!).fromNow(),
                    style: const TextStyle(
                        color: AppColor.primary, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const Divider(),
              Text(
                  "Order Type : ${controller.printOrderType(listdata.ordersType!.toString())}"),
              Text("Order Price : ${listdata.ordersPrice} \$"),
              Text("Delivery Price : ${listdata.ordersPricedelivery} \$ "),
              Text(
                  "Payment Method : ${controller.printPaymentMethod(listdata.ordersPaymentmethod!.toString())} "),
              Text(
                  "Order Status : ${controller.printOrderStatus(listdata.ordersStatus!.toString())} "),
              const Divider(),
              Row(
                children: [
                  Text("Total Price : ${listdata.ordersTotalprice} \$ ",
                      style: const TextStyle(
                          color: AppColor.primary,
                          fontWeight: FontWeight.bold)),
                  const Spacer(),
                  MaterialButton(
                    onPressed: () {
                      Get.toNamed(AppRoute.ordersdetails,
                          arguments: {"ordersmodel": listdata});
                    },
                    color: AppColor.lightPrimary,
                    textColor: AppColor.secondary,
                    child: const Text("Details"),
                  ),
                  const SizedBox(width: 10),
                  if (listdata.ordersStatus! == 0)
                    MaterialButton(
                      onPressed: () {
                        controller.deleteOrder(listdata.ordersId!.toString());
                      },
                      color: AppColor.thirdColor,
                      textColor: AppColor.secondary,
                      child: const Text("Delete"),
                    ),
                  if (listdata.ordersStatus! == 3)
                    MaterialButton(
                      onPressed: () {
                        controller.goToPageTracking(listdata);
                      },
                      color: AppColor.primary,
                      textColor: AppColor.black,
                      child: const Text("Track"),
                    ),
                ],
              ),
            ],
          )),
    );
  }
}
