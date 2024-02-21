import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/myfavorite_controller.dart';
import '../../../core/constant/color.dart';
import '../../../core/functions/translatefatabase.dart';
import '../../../data/model/myfavoritemodel.dart';
import '../../../linkapi.dart';

class CustomListFavoriteItems extends GetView<MyFavoriteControllerImp> {
  final MyFavoriteModel itemsModel;

  const CustomListFavoriteItems({Key? key, required this.itemsModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // controller.goToPageProductDetails(itemsModel);
      },
      child: Card(
        elevation: 2.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildItemImage(),
              const SizedBox(height: 10),
              _buildItemName(),
              const SizedBox(height: 5),
              _buildRatingRow(),
              const SizedBox(height: 5),
              _buildPriceRow(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildItemImage() {
    return CachedNetworkImage(
      imageUrl: "${AppLink.imageItems}/${itemsModel.itemsImage!}",
      height: 100,
      fit: BoxFit.cover,
      placeholder: (context, url) => const CircularProgressIndicator(),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }

  Widget _buildItemName() {
    return Text(
      translateDatabase(itemsModel.itemsNameAr, itemsModel.itemsName),
      style: const TextStyle(
        color: AppColor.black,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildRatingRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Rating 3.5",
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600], // Added color for better readability
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(
            5,
            (index) => const Icon(
              Icons.star,
              size: 16,
              color: Colors.amber,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPriceRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "${itemsModel.itemsPrice} ${"currency".tr}",
          style: const TextStyle(
            color: AppColor.primary,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        IconButton(
          onPressed: () {
            final controller = Get.find<MyFavoriteControllerImp>();
            controller.deleteFromFavorite(itemsModel.favoriteId!);
          },
          icon: const Icon(
            Icons.delete_outline_outlined,
            color: AppColor.secondary,
          ),
        ),
      ],
    );
  }
}
