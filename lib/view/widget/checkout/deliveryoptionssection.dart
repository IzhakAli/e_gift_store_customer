import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/checkout/checkout_controller.dart';
import '../../../core/constant/color.dart';
import '../../../core/constant/routes.dart';

class DeliveryOptionsSection extends StatelessWidget {
  const DeliveryOptionsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final CheckoutController controller = Get.find();
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Delivery Options',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Obx(() => ListTile(
                  title: const Text('Delivery'),
                  leading: Radio(
                    value: '0', //0 for delivery
                    groupValue: controller.selectedDeliveryMethod.value,
                    onChanged: (value) =>
                        controller.updateDeliveryMethod(value!),
                  ),
                )),
            Obx(() => Column(
                  children: [
                    ListTile(
                      title: const Text('Drive Through'),
                      leading: Radio(
                        value: '1', //1 for drive through
                        groupValue: controller.selectedDeliveryMethod.value,
                        onChanged: (value) =>
                            controller.updateDeliveryMethod(value!),
                      ),
                    ),
                  ],
                )),
            const Divider(),
            Obx(() {
              if (controller.showDeliveryAddress.isTrue) {
                if (controller.data_userAddresses.isEmpty) {
                  // No addresses, show prompt to add address
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.add_location,
                          color: AppColor.primary,
                          size: 30,
                        ),
                        const SizedBox(height: 8.0),
                        TextButton(
                          onPressed: () {
                            // Navigate to the address page
                            Get.toNamed(AppRoute
                                .addressadd); // Replace with your actual route name
                          },
                          child: const Text(
                            'We don\'t have your address yet, click here to add it now.',
                            style: TextStyle(
                                color: AppColor.primary,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  // Addresses exist, list them
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: controller.data_userAddresses.length,
                    itemBuilder: (context, index) {
                      return Obx(() => ListTile(
                            // Wrap ListTile with Obx to make it reactive
                            title: Text(
                              controller.data_userAddresses[index].addressName
                                  .toString(),
                            ),
                            subtitle: Text(
                              controller.data_userAddresses[index].addressStreet
                                  .toString(),
                            ),
                            leading: const Icon(
                              Icons.location_on,
                              color: AppColor.primary,
                            ),
                            trailing: Icon(
                              controller.selectedAddressIndex.value == index
                                  ? Icons.check_circle
                                  : Icons.radio_button_unchecked,
                              color: AppColor.primary,
                            ),
                            onTap: () {
                              controller.setSelectedAddress(index);
                            },
                          ));
                    },
                  );
                }
              } else {
                // Delivery address is not shown
                return const Text(
                    "Our location: 50th St. next to Sama Mall. Don't worry! We'll call you when its ready!");
              }
            }),
          ],
        ),
      ),
    );
  }
}
