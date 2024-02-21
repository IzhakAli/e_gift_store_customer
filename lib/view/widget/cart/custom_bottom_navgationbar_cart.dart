import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store/controller/cart_controller.dart';

import '../../../core/constant/color.dart';
import 'buttoncart.dart';

class BottomNavgationBarCart extends GetView<CartController> {
  final String price;
  // final String shipping;
  final String discount;
  final String totalprice;
  // final TextEditingController controllercoupon;
  // final void Function()? onApplyCoupon;

  const BottomNavgationBarCart({
    Key? key,
    required this.price,
    // required this.shipping,
    required this.totalprice,
    required this.discount,
    // required this.controllercoupon,
    // required this.onApplyCoupon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          const EdgeInsets.all(16.0), // Consistent padding for the container
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // _buildCouponField(context),
          _buildInfoRow(context, "Price", "$price ${"2".tr}"),
          // _buildInfoRow(context, "Shipping", "$shipping ${"2".tr}"),
          _buildInfoRow(context, "Discount", "$discount %"),
          const Divider(
              height: 22.0), // Added height for spacing around the divider
          _buildTotalPriceRow(context),
          const SizedBox(height: 5), // Increased space before the button
          CustomButtonCart(
            textbutton: "Place Order",
            onPressed: () {
              controller.goToPageCheckout();
            },
          ),
          const SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }

  // Widget _buildCouponField(BuildContext context) {
  //   return Row(
  //     children: [
  //       Expanded(
  //         child: TextFormField(
  //           decoration: const InputDecoration(
  //             labelText: 'Enter coupon if available',
  //             border: OutlineInputBorder(),
  //             isDense: true, // Added for better UI in case of limited space
  //             contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
  //           ),
  //         ),
  //       ),
  //       const SizedBox(width: 10), // Spacing between text field and button
  //       ElevatedButton(
  //         onPressed: onApplyCoupon,
  //         style: ElevatedButton.styleFrom(
  //             padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
  //             backgroundColor: AppColor.primary),
  //         child: const Text('Apply'),
  //       ),
  //     ],
  //   );
  // }

  Widget _buildInfoRow(BuildContext context, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          vertical: 8.0), // Added padding for spacing between rows
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: Theme.of(context).textTheme.titleMedium),
          Text(value, style: Theme.of(context).textTheme.titleMedium),
        ],
      ),
    );
  }

  Widget _buildTotalPriceRow(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          vertical: 8.0), // Added padding for spacing between rows
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Total Price",
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColor.primary,
                ),
          ),
          Text(
            "$totalprice ${"2".tr}",
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColor.primary,
                ),
          ),
        ],
      ),
    );
  }
}
