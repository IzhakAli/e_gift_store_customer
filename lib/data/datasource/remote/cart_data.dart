import '../../../core/class/crud.dart';
import '../../../linkapi.dart';

class CartData {
  Crud crud;
  CartData(this.crud);
  addCart(String usersid, String itemsid) async {
    var response = await crud.postData(AppLink.cartadd,
        {"usersid": usersid.toString(), "itemsid": itemsid.toString()});
    // print("=========================id $id");
    return response.fold((l) => l, (r) => r);
  }

  deleteCart(String usersid, String itemsid) async {
    var response = await crud.postData(AppLink.cartdelete,
        {"usersid": usersid.toString(), "itemsid": itemsid.toString()});
    // print("=========================id $id");
    return response.fold((l) => l, (r) => r);
  }

  getCountCart(String usersid, String itemsid) async {
    var response = await crud.postData(AppLink.cartgetcountitem,
        {"usersid": usersid.toString(), "itemsid": itemsid.toString()});
    // print("=========================id $id");
    return response.fold((l) => l, (r) => r);
  }

  viewCart(String usersid) async {
    var response =
        await crud.postData(AppLink.cartview, {"usersid": usersid.toString()});
    // print("=========================id $id");
    return response.fold((l) => l, (r) => r);
  }

  checkCoupon(String couponname) async {
    var response =
        await crud.postData(AppLink.checkcoupon, {"couponname": couponname});
    return response.fold((l) => l, (r) => r);
  }
}
