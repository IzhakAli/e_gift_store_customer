import '../../../core/class/crud.dart';
import '../../../linkapi.dart';

class OfferData {
  Crud crud;

  OfferData(this.crud);

  getData(String id) async {
    var response = await crud.postData(AppLink.offers, {"user_id": id});
    return response.fold((l) => l, (r) => r);
  }
}
