import 'package:flingstation2/controller/databasehalper.dart';
import 'package:flingstation2/model/extraitem.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExtraitemController extends GetxController {
  DBcontrolar dbController = DBcontrolar.createinstence();
  // Define an observable variable to hold the list of extra items
  var extraItemList = List<Extraitem>.empty().obs;
  //late Extraitem selectedExtraItem; // Selected extra item
  //late Rx<Extraitem> selectedExtraItem =Extraitem("test one", 250.0).obs; // Define as Rx
  var selectedExtraItem = <Extraitem>[].obs;
  var extratotalValue = 0.0.obs; // Define as Rx
  @override
  void onInit() {
    super.onInit();
    // Load extra items from the local database when the controller is initialized
    loadExtraItems();
  }

  // Function to load extra items from the local database
  void loadExtraItems() async {
    // Retrieve extra items from the database
    var items = await dbController.getextraitemList();
    // Update the observable list
    extraItemList.assignAll(items);
    if (selectedExtraItem.isEmpty) {
      selectedExtraItem.add(extraItemList.first);
    }
  }

  /* void addNewDropdown() {
    print(selectedExtraItem.length);
    selectedExtraItem.add(extraItemList.first);
    print(selectedExtraItem
        .length); // Add a null placeholder for the new dropdown
  }*/
  void addNewDropdown() {
    print(selectedExtraItem.length);
    selectedExtraItem.add(extraItemList.first);
    calculateTotal(); // Ensure to recalculate the total after adding new item
    update(); // Trigger UI update
    print(selectedExtraItem.length);
  }

  void calculateTotal() {
    double total =
        selectedExtraItem.fold(0, (sum, item) => sum + item.extraitemprice);
    extratotalValue.value = total;
    print(extratotalValue.value); // Update the value using .value
  }

  TextEditingController itemnamecontrollers = TextEditingController();
  TextEditingController itempricecontrollers = TextEditingController();
  TextEditingController itemgroupecontroller = TextEditingController();
  TextEditingController datecontroller = TextEditingController();
  setExtraitempriceWithcontroller(Extraitem extraitem) {
    extraitem.extraitem = itemnamecontrollers.text;
    extraitem.extraitemprice =
        double.tryParse(itempricecontrollers.text) ?? 0.0;
    dbController.insertextraitem(extraitem);
    print(extraitem.extraitemprice);
  }

  updateExtraitem(Extraitem extraitem) {
    extraitem.extraitem = itemnamecontrollers.text;
    extraitem.extraitemprice =
        double.tryParse(itempricecontrollers.text) ?? 0.0;
    dbController.updateextraitem(extraitem);
    print(extraitem.extraitemprice);
  }

  deleteExtaitem(int id) {
    dbController.deleteextraitem(id);
  }
}
