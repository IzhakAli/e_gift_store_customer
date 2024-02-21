import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store/controller/checkout/checkout_controller.dart';

import '../../../data/model/cartmodel.dart'; // Import your CartModel if it's not already imported

class OrderSummarySection extends StatelessWidget {
  const OrderSummarySection({super.key});

  @override
  Widget build(BuildContext context) {
    final CheckoutController controller = Get.find();
    final shippingCost = 1000; // Define the shipping cost

    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Order Summary',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ...controller.orderdetails
                .map((CartModel item) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                              item.itemsName
                                  .toString(), // Assuming 'name' is a field in CartModel
                              style: const TextStyle(fontSize: 16)),
                          Text(
                              '${item.itemspricee} ${"2".tr}', // Assuming 'price' is a field in CartModel
                              style: const TextStyle(fontSize: 16)),
                        ],
                      ),
                    ))
                .toList(),
            if (int.parse(controller.coupondiscount) != 0)
              GetBuilder<CheckoutController>(
                  init: controller, // Initialize your controller
                  builder: (_) {
                    // Calculate the total price before shipping
                    double totalPrice = double.parse(controller.priceorders);
                    // Apply discount
                    totalPrice -= totalPrice *
                        double.parse(controller.coupondiscount) /
                        100;

                    // Display the total price after discount but before shipping
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('New Total(${controller.coupondiscount}% Off)',
                              style: TextStyle(fontSize: 16)),
                          Text('${totalPrice.toStringAsFixed(2)} ${"2".tr}',
                              style: const TextStyle(fontSize: 16)),
                        ],
                      ),
                    );
                  }),

            Obx(() => controller.selectedDeliveryMethod.value ==
                    '0' // Check if delivery is selected
                ? Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Shipping Cost',
                            style: TextStyle(fontSize: 16)),
                        Text('${shippingCost} ${"2".tr}',
                            style: const TextStyle(fontSize: 16)),
                      ],
                    ),
                  )
                : SizedBox.shrink()),
            // Don't show shipping cost if not delivery
            Obx(() {
              // Calculate the total price
              double totalPrice = double.parse(controller.priceorders);
              if (controller.selectedDeliveryMethod.value == '0') {
                // Check if delivery is selected
                totalPrice -=
                    totalPrice * double.parse(controller.coupondiscount) / 100;
                totalPrice +=
                    shippingCost; // Add shipping cost if delivery is selected
              } else {
                totalPrice -=
                    totalPrice * double.parse(controller.coupondiscount) / 100;
              }
              return Text(
                'Total: ${totalPrice.toStringAsFixed(2)} ${"2".tr}',
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    fontFamily: 'sans'),
              );
            }),
          ],
        ),
      ),
    );
  }
}
