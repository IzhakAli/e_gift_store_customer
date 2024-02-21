import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store/controller/favorite_controller.dart';
import 'package:store/controller/offers_controller.dart';
import 'package:store/core/functions/translatefatabase.dart';

import '../../../core/constant/color.dart';
import '../../../data/model/itemsmodel.dart';
import '../../../linkapi.dart';

class CustomListItemsOffers extends GetView<OffersController> {
  final ItemsModel itemsModel;
  const CustomListItemsOffers({
    Key? key,
    required this.itemsModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        controller.goToPageProductDetails(itemsModel);
      },
      child: Card(
        elevation: 2.0, // Added some elevation for better UI
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(10), // Rounded corners for the card
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              buildItemImage(),
              const SizedBox(height: 10),
              buildItemName(),
              const SizedBox(height: 5),
              // buildRatingRow(),
              // const SizedBox(height: 5),
              buildPriceRow(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildItemImage() {
    // Ensure we have non-null values for price and discount price
    final int originalPrice = itemsModel.itemsPrice ?? 0;
    final int discountPrice = itemsModel.itemsPriceDiscount ?? 0;
    final bool hasDiscount =
        originalPrice > 0 && discountPrice > 0 && discountPrice < originalPrice;

    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Hero(
          tag: "${itemsModel.itemsId}",
          child: CachedNetworkImage(
            imageUrl: "${AppLink.imageItems}/${itemsModel.itemsImage!}",
            height: 100,
            width: double.infinity,
            fit: BoxFit.contain,
            placeholder: (context, url) => const CircularProgressIndicator(),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        ),
        if (hasDiscount)
          Positioned(
            top: -4,
            right: -5,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    spreadRadius: 1,
                    blurRadius: 1,
                    offset: Offset(0, 1),
                  ),
                ],
              ),
              child: Text(
                "-${((1 - (discountPrice / originalPrice)) * 100).toStringAsFixed(0)}% OFF", // Calculates the discount percentage
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget buildItemName() {
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

  Widget buildRatingRow() {
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
              color: Colors.amber, // Added color for stars
            ),
          ),
        ),
      ],
    );
  }

  Widget buildPriceRow() {
    final bool hasDiscount =
        itemsModel.itemsPrice != itemsModel.itemsPriceDiscount;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // if (hasDiscount)
              Text(
                "${itemsModel.itemsPrice} ${"2".tr}",
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                  decoration: TextDecoration.lineThrough,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                "${itemsModel.itemsPriceDiscount} ${"2".tr}",
                style: TextStyle(
                  color: hasDiscount ? AppColor.secondary : AppColor.primary,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        GetBuilder<FavoriteControllerImp>(
          builder: (controller) {
            return IconButton(
              onPressed: () {
                if (controller.isFavorite[itemsModel.itemsId].toString() ==
                    "1") {
                  controller.setFavorite(itemsModel.itemsId, "0");
                  controller.removeFavorite(itemsModel.itemsId.toString());
                } else {
                  controller.setFavorite(itemsModel.itemsId, "1");
                  controller.addFavorite(itemsModel.itemsId.toString());
                }
              },
              icon: Icon(
                controller.isFavorite[itemsModel.itemsId].toString() == "1"
                    ? Icons.favorite
                    : Icons.favorite_border_outlined,
                color: AppColor.primary,
              ),
            );
          },
        )
      ],
    );
  }
}
