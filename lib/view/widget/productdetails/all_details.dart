import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store/controller/productdetails_controller.dart';

import '../../../core/constant/color.dart';
import '../../../core/functions/translatefatabase.dart';

class ProductAllDetails extends GetView<ProductDetailsControllerImp> {
  //Counter add and remove quantity
  final void Function()? onAdd;
  final void Function()? onRemove;
  //select size function
  // final void Function(String?)? onChangedSize;
  // final void Function(String?)? onChangedColor;
  //Add to cart logic
  final void Function()? onPressedGoToCart;
  //select color function
  const ProductAllDetails({
    Key? key,
    this.onAdd,
    this.onRemove,
    // this.onChangedSize,
    // this.onChangedColor,
    this.onPressedGoToCart,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
            Text(
              "${translateDatabase("${controller.itemsModel.itemsNameAr}", "${controller.itemsModel.itemsName}")}",
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            // Price text
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${controller.itemsModel.itemsPriceDiscount} ${"2".tr}", // Assuming price is a double
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                        icon: const Icon(Icons.remove), onPressed: onRemove),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 3),
                      decoration: BoxDecoration(
                          border: Border.all(color: AppColor.grey2)),
                      child: Text(
                        '${controller.countitems}',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                    IconButton(icon: const Icon(Icons.add), onPressed: onAdd),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              "${translateDatabase(controller.itemsModel.itemsDescAr, controller.itemsModel.itemsDesc)}",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            // const SizedBox(height: 16),
            // Text(
            //   'Select Size',
            //   style: Theme.of(context).textTheme.titleMedium,
            // ),
            // DropdownButton<String>(
            //   isExpanded: true,
            //   items: ['S', 'M', 'L', 'XL'].map((String value) {
            //     return DropdownMenuItem<String>(
            //       value: value,
            //       child: Text(value),
            //     );
            //   }).toList(),
            //   onChanged: (_) {
            //     onChangedSize;
            //   },
            // ),
            // const SizedBox(height: 16),
            // Text(
            //   'Select Color',
            //   style: Theme.of(context).textTheme.titleMedium,
            // ),
            // DropdownButton<String>(
            //   isExpanded: true,
            //   items: ['Red', 'Green', 'Blue', 'Black'].map((String value) {
            //     return DropdownMenuItem<String>(
            //       value: value,
            //       child: Text(value),
            //     );
            //   }).toList(),
            //   onChanged: (_) {
            //     onChangedColor;
            //   },
            // ),
            const SizedBox(height: 24),
            // Quantity selector

            const SizedBox(height: 24),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: AppColor.primary, // foreground
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                textStyle: const TextStyle(fontSize: 18),
              ),
              onPressed: onPressedGoToCart,
              child: const Text('Go to Cart'),
            ),
          ],
        ),
      ),
    );
  }
}
