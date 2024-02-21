import 'package:get/get.dart';
import 'package:store/core/class/statusrequest.dart';
import 'package:store/core/constant/routes.dart';
import 'package:store/core/services/services.dart';
import 'package:store/data/datasource/remote/address_data.dart';
import 'package:store/data/datasource/remote/checkout_date.dart';

import '../../core/functions/handlingdatacontroller.dart';
import '../../data/model/addressmodel.dart';
import '../../data/model/cartmodel.dart';

class CheckoutController extends GetxController {
  AddressData addressData = Get.put(AddressData(Get.find()));
  CheckoutData checkoutData = Get.put(CheckoutData(Get.find()));

  StatusRequest statusRequest = StatusRequest.none;
  MyServices myServices = Get.find();

  RxString selectedDeliveryMethod = '0'.obs; //0 is for delivery //delivery type
  RxString selectedPaymentMethod = '0'.obs; //0 is for cash //payment method
  RxBool showPaymentDetails = false.obs;
  RxBool showDeliveryAddress = true.obs;

  late String coupoinid;
  late String priceorders = '0';
  late String coupondiscount = '0';
  List<CartModel> orderdetails = [];

  // Dummy list of user's saved addresses
  List<AddressModel> data_userAddresses = [];

  @override
  void onInit() {
    coupoinid = Get.arguments['couponid'].toString();
    priceorders = Get.arguments['priceorder'].toString();
    coupondiscount = Get.arguments['discountcoupon'].toString();
    orderdetails = Get.arguments['orderdetails'];
    getShippingAddress();
    super.onInit();
  }

  void calculateNewTotal() {
    double totalPrice = double.parse(priceorders);
    double discount = double.parse(coupondiscount) / 100;
    totalPrice -= totalPrice * discount;
    // Update the total price
    priceorders = totalPrice.toStringAsFixed(2);
    // Call update to refresh the UI
    update();
  }

//ALL ABOUT DELIVERY
  void updateDeliveryMethod(String method) {
    selectedDeliveryMethod.value = method;
    showDeliveryAddress.value = (method == '0');
  }

  //index to choose one of the addresses used by the customer
  Rx<int?> selectedAddressIndex = Rx<int?>(null);
  late String addressid = "";
  void setSelectedAddress(int index) {
    selectedAddressIndex.value = index;
    addressid = data_userAddresses[index].addressId!.toString();
  }

  getShippingAddress() async {
    statusRequest = StatusRequest.loading;
    var response = await addressData
        .getData(myServices.sharedPreferences.getString("id")!);
    print("=============================== Controller $response ");
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      // Start backend
      if (response['status'] == "success") {
        List listdata = response['data'];
        data_userAddresses
            .addAll(listdata.map((e) => AddressModel.fromJson(e)));
        if (data_userAddresses.isEmpty) {
          // statusRequest = StatusRequest.failure;
        }
      } else {
        statusRequest = StatusRequest.none;
        // print("no addressed found");
      }
      // End
    }
    update();
  }

  checkout() async {
    if (selectedPaymentMethod.isEmpty) {
      return Get.snackbar("Error", "Please select a payment method");
    }
    if (selectedDeliveryMethod.isEmpty) {
      return Get.snackbar("Error", "Please select a order Type");
    }
    if (selectedDeliveryMethod.value == '1') {
      addressid = "0";
    }
    if (addressid == "" && selectedDeliveryMethod.value == '0') {
      return Get.snackbar("Error", "Please select delivery location");
    }

    statusRequest = StatusRequest.loading;
    update();
    Map<String, dynamic> data = {
      "usersid": myServices.sharedPreferences.get("id").toString(),
      "addressid": addressid.toString(),
      "orderstype": selectedDeliveryMethod.toString(),
      "pricedelivery": "1000",
      "ordersprice": priceorders.toString(),
      "couponid": coupoinid.toString(),
      "coupondiscount": coupondiscount.toString(),
      "paymentmethod": selectedPaymentMethod.toString(),
    };
    var response = await checkoutData.checkout(data);
    print("=============================== Controller $response ");
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      // Start backend
      if (response['status'] == "success") {
        Get.offAllNamed(AppRoute.homePage);
        Get.snackbar("Success!",
            "Your order remains in a pending state. Please await confirmation");
      }
    } else {
      statusRequest = StatusRequest.none;
      Get.snackbar("Error", "Please try again");
    }
    update();
  }

////ALL ABOUT PAYMENT
  void updatePaymentMethod(String method) {
    selectedPaymentMethod.value = method;
    showPaymentDetails.value = (method == '1');
  }

  String bankAccountDetails = 'Our Al-Kuraimi Account number: 1234-5678-9012';
}
