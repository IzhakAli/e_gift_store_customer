import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:store/data/datasource/remote/cart_data.dart';

import '../core/class/statusrequest.dart';
import '../core/constant/routes.dart';
import '../core/functions/handlingdatacontroller.dart';
import '../core/services/services.dart';
import '../data/model/cartmodel.dart';
import '../data/model/couponmodel.dart';

class CartController extends GetxController {
  //variables used by the COUPON
  TextEditingController? controllercoupon;
  int? discountcoupon = 0;
  String? couponname;
  CouponModel? couponModel;

  //end of variables used by COUPON
  CartData cartData = CartData(Get.find());
  late StatusRequest statusRequest;
  MyServices myServices = Get.find();
  List<CartModel> data = [];
  double priceorders = 0.0;
  int totalcountitems = 0;

  @override
  void onInit() {
    view();
    controllercoupon = TextEditingController();
    super.onInit();
  }

  String? couponid; // this variable is initiated here because
  // it is used by the method below it.
  goToPageCheckout() {
    if (data.isEmpty) {
      return Get.snackbar(
          "Cart is empty", "Add the items you want to buy to the cart first");
    } else {
      Get.toNamed(AppRoute.checkout, arguments: {
        "couponid": couponid ?? "0",
        "priceorder": priceorders,
        "discountcoupon": discountcoupon.toString(),
        "orderdetails": data //todo:just added
      });
    }
  }

  //method used for the coupon
  checkcoupon() async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await cartData.checkCoupon(controllercoupon!.text);
    print("=============================== Controller $response ");
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      // Start backend
      if (response['status'] == "success") {
        Map<String, dynamic> datacoupon = response['data'];
        couponModel = CouponModel.fromJson(datacoupon);
        discountcoupon = couponModel!.couponDiscount;
        couponname = couponModel!.couponName;
        couponid = couponModel!.couponId.toString();
      } else {
        // statusRequest = StatusRequest.failure;
        discountcoupon = 0;
        couponname = null;
        couponid = null;
        Get.snackbar("Invalid Coupon", "Enter a valid coupon");
      }
      // End
    }
    update();
  }

  //method used to get total price
  getTotalPrice() {
    return (priceorders - priceorders * discountcoupon! / 100);
  }

  add(String itemsid) async {
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

  delete(String itemsid) async {
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

  view() async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await cartData
        .viewCart(myServices.sharedPreferences.getString("id").toString());
    print("=============================== Controller $response ");
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      // Start backend
      if (response['status'] == "success") {
        if (response['datacart']['status'] == "success") {
          List dataresponse = response['datacart']['data'];
          Map dataresponsecountprice = response['countprice'];
          data.clear();
          data.addAll(dataresponse.map((e) => CartModel.fromJson(e)));
          totalcountitems = int.parse(dataresponsecountprice['totalcount']);
          priceorders =
              double.parse(dataresponsecountprice['totalprice'].toString());
        }
        // data.addAll(response['data']);
      } else {
        statusRequest = StatusRequest.failure;
      } // End
    }
    update();
  }

  resetVarCart() {
    totalcountitems = 0;
    priceorders = 0.0;
    data.clear();
  }

  refreshPage() {
    resetVarCart();
    view();
  }
}
