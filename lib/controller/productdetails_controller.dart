import 'package:get/get.dart';

import '../core/class/statusrequest.dart';
import '../core/functions/handlingdatacontroller.dart';
import '../core/services/services.dart';
import '../data/datasource/remote/cart_data.dart';
import '../data/model/itemsmodel.dart';

abstract class ProductDetailsController extends GetxController {
  initialData();
  // onAdd(); //to add quantity of a certain product
  // onRemove(); //to decrease the quantity of a certain product
}

class ProductDetailsControllerImp extends ProductDetailsController {
  // CartController cartController = Get.put(CartController());
  late StatusRequest statusRequest = StatusRequest.none;
  late ItemsModel itemsModel;
  MyServices myServices = Get.find();
  CartData cartData = CartData(Get.find());

  // int quantity = 1;
  int countitems = 0;

  @override
  void onInit() {
    initialData();
    super.onInit();
  }

  @override
  initialData() async {
    statusRequest = StatusRequest.loading;
    itemsModel = Get.arguments['itemsmodel'];
    countitems = await getCountItems(itemsModel.itemsId!.toString());
    statusRequest = StatusRequest.success;
    update();
  }

  getCountItems(String itemsid) async {
    statusRequest = StatusRequest.loading;
    var response = await cartData.getCountCart(
        myServices.sharedPreferences.getString("id").toString(), itemsid);
    print("=============================== Controller $response ");
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      // Start backend
      if (response['status'] == "success") {
        int countItems = 1;
        countItems = response['data'];
        print("========================");
        print(countItems);
        return countItems;
        // data.addAll(response['data']);
      } else {
        statusRequest = StatusRequest.failure;
      } // End
    }
  }

  addItems(String itemsid) async {
    statusRequest = StatusRequest.loading;
    var response = await cartData.addCart(
        myServices.sharedPreferences.getString("id").toString(), itemsid);
    print("=============================== Controller $response ");
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      // Start backend
      if (response['status'] == "success") {
        Get.rawSnackbar(title: "Added", message: "Added to cart");
        // data.addAll(response['data']);
      } else {
        statusRequest = StatusRequest.failure;
      } // End
    }
    update();
  }

  deleteItems(String itemsid) async {
    statusRequest = StatusRequest.loading;
    var response = await cartData.deleteCart(
        myServices.sharedPreferences.getString("id").toString(), itemsid);
    print("=============================== Controller $response ");
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      // Start backend
      if (response['status'] == "success") {
        Get.rawSnackbar(title: "Removed", message: "Removed from cart");
        // data.addAll(response['data']);
      } else {
        statusRequest = StatusRequest.failure;
      } // End
    }
    update();
  }

  add() {
    addItems(itemsModel.itemsId!.toString());
    countitems++;
    update();
  }

  remove() {
    if (countitems > 0) {
      deleteItems(itemsModel.itemsId!.toString());
      countitems--;
    }
    update();
  }
}
