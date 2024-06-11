import 'package:flingstation2/controller/extraitem_form_controller.dart';
import 'package:flingstation2/controller/mainitem_form_controller.dart';
import 'package:flingstation2/controller/sell_form.dart';
import 'package:flingstation2/model/sellListModel.dart';
import 'package:flingstation2/utilitylogick/printer/controller/printer_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flingstation2/view/widgets/dropdownlist.dart';

class FormReceipt extends StatelessWidget {
  final Sell_form_Controller controller = Get.put(Sell_form_Controller());
  final Maintitem_form_Controller maintitem_form_controller =
      Get.put(Maintitem_form_Controller());
  final PrinterController printerController = Get.put(PrinterController());
  final String itemName;
  Rx<DateTime> selectedDate = DateTime.now().obs;
  late int receiptno = int.parse(
      '${selectedDate.value.minute}${selectedDate.value.microsecond}');
  FormReceipt({super.key, required this.itemName}); // Default date
  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate.value,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate.value) {
      selectedDate.value = picked;
    }
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final ExtraitemController extraitemController =
        Get.put(ExtraitemController());
    return Container(
      child: Scaffold(
        appBar: AppBar(
            title: Text(
              'PRODHAN CNG & FILLING STATION',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            ),
            flexibleSpace: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Colors.indigoAccent, Colors.deepPurpleAccent])),
            )),
        body: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(padding: EdgeInsets.all(5), children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                          child: Text(
                        "Receipt no:-$receiptno",
                        style:
                            TextStyle(color: Colors.orangeAccent, fontSize: 18),
                      )),
                      Obx(() => GestureDetector(
                            onLongPress: () => selectDate(context),
                            child: Text(
                              ' Date: ${selectedDate.value.day}/${selectedDate.value.month}/${selectedDate.value.year}',
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                          )),
                    ],
                  ),
                ),
                TextFormField(
                  controller: controller.carNameTextController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Car No:",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a car number';
                    }
                    return null;
                  },
                  onChanged: (value) {},
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          itemName.toUpperCase() + ' :',
                          style: TextStyle(
                              color: Colors.orangeAccent, fontSize: 35),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          maintitem_form_controller.box
                                  .read(itemName)
                                  .toString() +
                              'TK',
                          style: TextStyle(
                              color: Colors.orangeAccent, fontSize: 30),
                        ),
                      ),
                    ],
                  ),
                ),

                Row(
                  children: <Widget>[
                    Expanded(
                      child: TextFormField(
                        controller: controller.quantityTextController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Quantity:",
                        ),
                        onChanged: (quantity) {
                          double parsedQuantity =
                              double.tryParse(quantity) ?? 0.0;
                          double totalPrice = parsedQuantity *
                              maintitem_form_controller.box.read(itemName);
                          controller.priceTextController.text =
                              totalPrice.toString();
                          controller.sellcalculateTotal();
                        },
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: TextFormField(
                      controller: controller.priceTextController,
                      keyboardType: TextInputType.number,

                      // initialValue: itemrate.toString(),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Price:",
                      ),
                      onChanged: (price) {
                        double parsedPrice = double.tryParse(price) ?? 0.0;
                        double calculatedQuantity = parsedPrice /
                            maintitem_form_controller.box.read(itemName);
                        controller.quantityTextController.text =
                            calculatedQuantity.toStringAsFixed(2);
                        controller.sellcalculateTotal();
                      },
                    )),
                  ],
                ),
                Text(
                  "Add Extra:",
                  style: TextStyle(color: Colors.orangeAccent, fontSize: 20),
                ),
                // begin dyna mick fild
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 180,
                      child: SingleChildScrollView(
                        child: Obx(
                          () => Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              for (int i = 0;
                                  i <
                                      extraitemController
                                          .selectedExtraItem.length;
                                  i++)
                                Row(
                                  children: [
                                    Dropdown(i),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        foregroundColor: const Color.fromARGB(
                                            255, 240, 5, 5),
                                      ),
                                      child: Icon(Icons.delete_outline),
                                      onPressed: () {
                                        extraitemController.selectedExtraItem
                                            .removeAt(i);
                                        // Update the total value
                                        extraitemController.calculateTotal();
                                        controller.sellcalculateTotal();
                                      },
                                    ),
                                  ],
                                )
                            ],
                          ),
                        ),
                      ),
                    ),

                    Obx(() => Row(
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: Colors.deepOrange,
                              ),
                              child: Icon(Icons.add),
                              onPressed: () {
                                extraitemController.addNewDropdown;
                                extraitemController.selectedExtraItem.add(
                                    extraitemController.extraItemList.first);
                                extraitemController.loadExtraItems;
                                extraitemController.update();
                                // Update the total value
                                extraitemController.calculateTotal();
                                controller.sellcalculateTotal();
                              },
                            ),
                            Text(
                                'Extra Total: ${extraitemController.extratotalValue.obs}'),
                          ],
                        )),

                    //Add Dropdown
                  ],
                ),
                //end dynamic fild
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: TextFormField(
                    controller: controller.grandTotalTextController,
                    enabled: false,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Total:",
                    ),
                    onChanged: (value) {},
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 20, left: 10, right: 10, bottom: 10),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red, // background
                      onPrimary: Colors.white, // foreground
                    ),
                    onPressed: () {
                      print(receiptno);
                      print(selectedDate.value);
                      print(controller.carNameTextController.text);
                      print(controller.grandTotalTextController.text);
                      if (_formKey.currentState?.validate() ?? false) {
                        // Form is valid, proceed with submission
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Processing Data')),
                        );
                        // Perform the form submission logic here
                        if (extraitemController.extratotalValue.obs != 0) {
                          controller.sellextraitem(
                              '${selectedDate.value.day}/${selectedDate.value.month}/${selectedDate.value.year}',
                              receiptno.toString(),
                              '${extraitemController.extratotalValue.obs}',
                              'null group');
                        }
                        printerController.printReceive(
                            extraitemController.selectedExtraItem,
                            Selllistmodel(
                                '${selectedDate.value.day}/${selectedDate.value.month}/${selectedDate.value.year}',
                                receiptno.toString(),
                                controller.carNameTextController.text,
                                itemName,
                                maintitem_form_controller.box.read(itemName),
                                double.tryParse(controller
                                        .grandTotalTextController.text) ??
                                    0.0,
                                double.tryParse(controller
                                        .quantityTextController.text) ??
                                    0.0,
                                double.tryParse(
                                        controller.priceTextController.text) ??
                                    0.0));
                        controller.sellmainitemm(Selllistmodel(
                            '${selectedDate.value.day}/${selectedDate.value.month}/${selectedDate.value.year}',
                            receiptno.toString(),
                            controller.carNameTextController.text,
                            itemName,
                            maintitem_form_controller.box.read(itemName),
                            double.tryParse(
                                    controller.grandTotalTextController.text) ??
                                0.0,
                            double.tryParse(
                                    controller.quantityTextController.text) ??
                                0.0,
                            double.tryParse(
                                    controller.priceTextController.text) ??
                                0.0));
                        controller.resetfromdata();
                      }
                    },
                    child: Text('Print&Save'),
                  ),
                )
              ]),
            )),
      ),
    );
  }
}
