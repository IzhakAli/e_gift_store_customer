import 'package:get/get.dart';
import 'package:store/data/datasource/remote/myfavorite_data.dart';
import 'package:store/data/model/myfavoritemodel.dart';

import '../core/class/statusrequest.dart';
import '../core/functions/handlingdatacontroller.dart';
import '../core/services/services.dart';

abstract class MyFavoriteController extends GetxController {
  getData();
  deleteFromFavorite(String favroiteid);
}

class MyFavoriteControllerImp extends MyFavoriteController {
  MyServices myServices = Get.find();

  List<MyFavoriteModel> data = [];

  MyFavoriteData favoriteData = MyFavoriteData(Get.find());

  late StatusRequest statusRequest = StatusRequest.none;

  @override
  void onInit() {
    getData();
    super.onInit();
  }

  @override
  getData() async {
    data.clear();
    statusRequest = StatusRequest.loading;
    var response = await favoriteData
        .getData(myServices.sharedPreferences.getString("id")!);
    print("=============================== Controller $response ");
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      // Start backend
      if (response['status'] == "success") {
        List responsedata = response['data'];
        data.addAll(responsedata.map((e) => MyFavoriteModel.fromJson(e)));
      } else {
        statusRequest = StatusRequest.failure;
      }
      // End
    }
    update();
  }

  @override
  deleteFromFavorite(String favroiteid) {
    var response = favoriteData.deleteData(favroiteid);
    statusRequest = handlingData(response);
    data.removeWhere((element) => element.favoriteId == favroiteid);
    update();
  }
}
