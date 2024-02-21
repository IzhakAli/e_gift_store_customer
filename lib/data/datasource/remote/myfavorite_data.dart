import '../../../core/class/crud.dart';
import '../../../linkapi.dart';

class MyFavoriteData {
  Crud crud;
  MyFavoriteData(this.crud);
  getData(String usersid) async {
    var response = await crud.postData(AppLink.favoriteView, {
      "id": usersid.toString(),
    });
    // print("=========================id $id");
    return response.fold((l) => l, (r) => r);
  }

  deleteData(String id) async {
    var response = await crud.postData(AppLink.deleteFromFavorite, {"id": id});
    return response.fold((l) => l, (r) => r);
  }
}
