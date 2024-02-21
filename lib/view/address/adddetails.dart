import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store/core/functions/validinput.dart';
import 'package:store/view/widget/auth/custom_login_button.dart';

import '../../controller/address/adddetails_controller.dart';
import '../../core/class/handlingdataview.dart';
import '../widget/auth/customtextformauth.dart';

class AddressAddDetails extends StatelessWidget {
  const AddressAddDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AddAddressDetailsController controller =
        Get.put(AddAddressDetailsController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Details Address'),
      ),
      body: Container(
          padding: const EdgeInsets.all(15),
          child: GetBuilder<AddAddressDetailsController>(
            builder: (controller) => HandlingDataView(
                statusRequest: controller.statusRequest,
                widget: Form(
                  key: controller.formState,
                  child: ListView(children: [
                    CustomTextFormAuth(
                      labelText: "City",
                      prefixIcon: const Icon(Icons.location_city),
                      myController: controller.city,
                      valid: (val) {
                        return validInput(val!, 3, 150, "type");
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextFormAuth(
                      labelText: "Street",
                      prefixIcon: const Icon(Icons.location_on_outlined),
                      myController: controller.street,
                      valid: (val) {
                        return validInput(val!, 3, 150, "type");
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextFormAuth(
                      labelText: "Exact location",
                      prefixIcon: const Icon(Icons.near_me),
                      myController: controller.name,
                      valid: (val) {
                        return validInput(val!, 10, 150, "type");
                      },
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    CustomButtonLogin(
                      buttonName: "Add",
                      onPressed: () {
                        controller.addAddress();
                      },
                    )
                  ]),
                )),
          )),
    );
  }
}
