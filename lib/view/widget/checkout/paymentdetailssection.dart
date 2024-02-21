import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/checkout/checkout_controller.dart';

class PaymentDetailsSection extends StatelessWidget {
  const PaymentDetailsSection({super.key});

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
            const Text('Bank Account Details',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text(
              controller.bankAccountDetails,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            const Divider(),
            const Text(
                "Note: To confirm your order, Send transaction proof to Whatsapp to this number : 777971925")
          ],
        ),
      ),
    );
  }
}
