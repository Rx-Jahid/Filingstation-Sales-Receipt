import 'dart:ffi';

import 'package:flingstation2/controller/databasehalper.dart';
import 'package:flingstation2/model/extrasellModel.dart';
import 'package:flingstation2/model/sellListModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flingstation2/controller/extraitem_form_controller.dart';

class Sell_form_Controller extends GetxController {
  final ExtraitemController extraitemController =
      Get.put(ExtraitemController());
  DBcontrolar dbController = DBcontrolar.createinstence();
  var selllist = List<Selllistmodel>.empty().obs;
  TextEditingController carNameTextController = TextEditingController();
  TextEditingController quantityTextController = TextEditingController();
  TextEditingController priceTextController = TextEditingController();
  TextEditingController grandTotalTextController = TextEditingController();
  TextEditingController extraTotalTextController = TextEditingController();
  RxDouble extratotalValue2 = 0.0.obs;
  RxDouble mainetotalValue = 0.0.obs;
  // var selectedValue = 'Option 1'.obs; // Using Rx for reactive updates
  @override
  void onInit() async {
    super.onInit();
    loadselllist();
  }

  void loadselllist() async {
    var item = await dbController.getSellList();
    selllist.assignAll(item);
  }

  void updateSelectedValue(String value) {
    // selectedValue.value = value;
  }
  void sellcalculateTotal() {
    // Update the value using .value
    // RxDouble gtotal = RxDouble.parse(priceTextController.text) +extraitemController.extratotalValue;
    double gtotal = double.tryParse(priceTextController.text) ?? 0.0;
    // extratotalValue2 = extraitemController.extratotalValue;
    var sum = extraitemController.extratotalValue.value + gtotal;
    grandTotalTextController.text = sum.toString();
  }

  sellmainitemm(Selllistmodel selllistmodel) {
    dbController.insertsell(selllistmodel);
  }

  sellextraitem(
      String date, String receipt, String grendtotal, String sellgroup) {
    for (var i = 0; i < extraitemController.selectedExtraItem.length; i++) {
      dbController.insertextrasellitem(Extrasellmodel(
          date,
          receipt,
          extraitemController.selectedExtraItem[i].extraitem,
          extraitemController.selectedExtraItem[i].extraitemprice,
          double.tryParse(grendtotal) ?? 0.0,
          sellgroup));
    }
  }

  void resetfromdata() {
    carNameTextController.text = '';
    quantityTextController.text = '';
    priceTextController.text = '';
    grandTotalTextController.text = '';
    extraTotalTextController.text = '';
    Get.back();
  }
}
