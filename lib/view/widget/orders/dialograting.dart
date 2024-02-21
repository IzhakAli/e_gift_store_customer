import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rating_dialog/rating_dialog.dart';
import 'package:store/controller/orders/archive_controller.dart';
import 'package:store/core/constant/imageasset.dart';

import '../../../core/constant/color.dart';

void showRatingDialog(BuildContext context, String ordersid) {
  // show the dialog
  showDialog(
    context: context,
    barrierDismissible: true, // set to false if you want to force a rating
    builder: (context) => RatingDialog(
      initialRating: 4.0,
      // your app's name?
      title: const Text(
        'Rate eGift!',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
      ),
      // encourage your user to leave a high rating?
      message: const Text(
        'We would love to hear your feedback.',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 15),
      ),
      // your app's logo?
      image: Image.asset(
        AppImageAsset.logo,
        width: 80,
        height: 80,
      ),
      submitButtonText: 'Submit',
      submitButtonTextStyle:
          const TextStyle(color: AppColor.primary, fontWeight: FontWeight.bold),
      commentHint: 'I like the product!',
      onCancelled: () => print('cancelled'),
      onSubmitted: (response) {
        OrdersArchiveController controller = Get.find();
        controller.submitRating(ordersid, response.rating, response.comment);
        // print('rating: ${response.rating}, comment: ${response.comment}');

        // TODO: add your own logic
        // if (response.rating < 3.0) {
        //   // send their comments to your email or anywhere you wish
        //   // ask the user to contact you instead of leaving a bad review
        // } else {
        //   _rateAndReviewApp();
        // }
      },
    ),
  );
}
