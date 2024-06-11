import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class Maintitem_form_Controller extends GetxController {
  final box = GetStorage();

  @override
  void onInit() {
    super.onInit();
    // Initialize GetStorage and write default values
    // box.write('octen', 0.0);
    // box.write('petrol', 0.0);
    // box.write('disel', 0.0);
    print('calling Maintitem_form_Controller function');
  }

  void setMaineitemprice(String item, double price) {
    box.write(item, price);
  }

  void setMaineitempriceWithcontroller() {
    // Get the item name and price from the text controllers
    String itemName = itemnamecontroller.text;
    double itemPrice = double.tryParse(itempricecontroller.text) ??
        0.0; // Default value if parsing fails

    // Write the item name and price to GetStorage
    box.write(itemName, itemPrice);
    print(box.read(itemName));
  }

  TextEditingController itemnamecontroller = TextEditingController();
  TextEditingController itempricecontroller = TextEditingController();
}
