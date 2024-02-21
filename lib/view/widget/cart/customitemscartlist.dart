import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store/controller/cart_controller.dart';
import 'package:store/linkapi.dart';

import '../../../core/constant/color.dart';

class CustomItemsCartList extends StatelessWidget {
  final String name;
  final String price;
  final String count;
  final String imageName;
  final void Function()? onAdd;
  final void Function()? onRemove;
  final void Function()? onApplyCoupon;
  final TextEditingController controllercoupon;

  const CustomItemsCartList({
    Key? key,
    required this.name,
    required this.price,
    required this.count,
    required this.imageName,
    required this.onAdd,
    required this.onRemove,
    required this.onApplyCoupon,
    required this.controllercoupon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildCouponField(context),
        const SizedBox(
          height: 15,
        ),
        Card(
          elevation: 2.0, // Slight shadow for depth
          margin: const EdgeInsets.symmetric(
              horizontal: 8.0,
              vertical: 4.0), // Margin for spacing between cards
          child: Padding(
            padding: const EdgeInsets.all(8.0), // Padding inside the card
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: CachedNetworkImage(
                    imageUrl: "${AppLink.imageItems}/$imageName",
                    height: 90,
                    fit: BoxFit.contain,
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: ListTile(
                    title: Text(
                      name,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium, // Use theme for text style
                    ),
                    subtitle: Text(
                      price,
                      style: const TextStyle(
                        color: AppColor.primary,
                        fontSize: 17,
                        fontWeight: FontWeight.bold, // Added bold for price
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment
                        .center, // Center the icons and count vertically
                    children: [
                      IconButton(
                        onPressed: onAdd,
                        icon: const Icon(Icons.add),
                        color: AppColor.primary, // Use primary color for icons
                      ),
                      Text(
                        count,
                        style: const TextStyle(
                          fontFamily: "sans",
                          fontSize: 16, // Consistent font size
                        ),
                      ),
                      IconButton(
                        onPressed: onRemove,
                        icon: const Icon(Icons.remove),
                        color: AppColor.primary, // Use primary color for icons
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCouponField(BuildContext context) {
    return GetBuilder<CartController>(
        builder: (controller) => controller.couponname == null
            ? Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: controllercoupon,
                        decoration: const InputDecoration(
                          labelText: 'Enter coupon if available',
                          border: OutlineInputBorder(),
                          isDense:
                              true, // Added for better UI in case of limited space
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                      width: 10), // Spacing between text field and button
                  ElevatedButton(
                    onPressed: onApplyCoupon,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                    ),
                    child: const Text('Apply'),
                  ),
                ],
              )
            : Text(
                "Coupon used : ${controller.couponname!}",
                style: const TextStyle(
                    fontWeight: FontWeight.bold, color: AppColor.grey),
              ));
  }
}
