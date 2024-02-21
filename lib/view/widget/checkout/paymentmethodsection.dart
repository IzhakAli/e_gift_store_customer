import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/checkout/checkout_controller.dart';

class PaymentMethodSection extends StatelessWidget {
  const PaymentMethodSection({super.key});

  @override
  Widget build(BuildContext context) {
    final CheckoutController controller = Get.find();

    return Card(
      margin: EdgeInsets.all(8.0),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Payment Method',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Obx(() => ListTile(
                  title: const Text('Cash'),
                  leading: Radio(
                    value: '0', //0 is for cash
                    groupValue: controller.selectedPaymentMethod.value,
                    onChanged: (value) =>
                        controller.updatePaymentMethod(value!),
                  ),
                )),
            Obx(() => ListTile(
                  title: const Text('E-wallet'),
                  leading: Radio(
                    value: '1', //1 is for e-wallet
                    groupValue: controller.selectedPaymentMethod.value,
                    onChanged: (value) =>
                        controller.updatePaymentMethod(value!),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
