import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:store/controller/home_controller.dart';
import 'package:store/core/class/statusrequest.dart';
import 'package:store/core/functions/handlingdatacontroller.dart';
import 'package:store/core/services/services.dart';
import 'package:store/data/model/itemsmodel.dart';

import '../data/datasource/remote/offers_data.dart';

class OffersController extends SearchMixController {
  OfferData offerData = OfferData(Get.find());

  List<ItemsModel> data = [];

  StatusRequest statusRequest = StatusRequest.none;

  MyServices myServices = Get.find();

  getData() async {
    statusRequest = StatusRequest.loading;

    var response =
        await offerData.getData(myServices.sharedPreferences.getString("id")!);
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        print("======================================");
        List listdata2 = response['data'];
        data.addAll(listdata2.map((e) => ItemsModel.fromJson(e)));
      } else {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  @override
  void onInit() async {
    super.onInit();
    search = TextEditingController();
    await getData();
  }

  goToPageProductDetails(itemsModel) {
    Get.toNamed("productdetails", arguments: {"itemsmodel": itemsModel});
  }
}
