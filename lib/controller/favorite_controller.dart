import 'package:get/get.dart';
import 'package:store/core/class/statusrequest.dart';
import 'package:store/core/services/services.dart';
import 'package:store/data/datasource/remote/favorite_data.dart';

import '../core/functions/handlingdatacontroller.dart';

abstract class FavoriteController extends GetxController {
  setFavorite(id, val);
  addFavorite(String itemsid);
  removeFavorite(String itemsid);
}

class FavoriteControllerImp extends FavoriteController {
  late StatusRequest statusRequest;
  MyServices myServices = Get.find();
  FavoriteData favoriteData = FavoriteData(Get.find());
  List data = [];

  Map isFavorite = {};
  //key => id of item
  //value =>1 OR 0 (1 means is favorite and 0 means is not)

  @override
  setFavorite(id, val) {
    isFavorite[id] = val;
    update();
  }

  @override
  addFavorite(String itemsid) async {
    data.clear();
    statusRequest = StatusRequest.loading;
    var response = await favoriteData.addFavorite(
        myServices.sharedPreferences.getString("id").toString(), itemsid);
    print("=============================== Controller $response ");
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      // Start backend
      if (response['status'] == "success") {
        Get.rawSnackbar(
            title: "Added", message: "Item added to your favorites");
        // data.addAll(response['data']);
      } else {
        statusRequest = StatusRequest.failure;
      } // End
    }
  }

  @override
  removeFavorite(itemsid) async {
    statusRequest = StatusRequest.loading;
    var response = await favoriteData.removeFavorite(
        myServices.sharedPreferences.getString("id")!, itemsid);
    print("=============================== Controller $response ");
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      // Start backend
      if (response['status'] == "success") {
        Get.rawSnackbar(
            title: "Removed", message: "Item removed from your favorite");
        // data.addAll(response['data']);
      } else {
        statusRequest = StatusRequest.failure;
      }
      // End
    }
  }
}
