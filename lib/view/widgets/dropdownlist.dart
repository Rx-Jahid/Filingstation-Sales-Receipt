import 'package:flingstation2/controller/extraitem_form_controller.dart';
import 'package:flingstation2/model/extraitem.dart';
import 'package:flutter/material.dart';
import 'package:flingstation2/controller/sell_form.dart';
import 'package:get/get.dart';

class Dropdown extends StatelessWidget {
  final ExtraitemController extraitemController =
      Get.put(ExtraitemController());
  final Sell_form_Controller controller = Get.put(Sell_form_Controller());
  int dropdowenbutton_index;
  Dropdown(this.dropdowenbutton_index);
  @override
  Widget build(Object context) {
    // TODO: implement build
    return Center(
      child: Obx(() => DropdownButton<Extraitem>(
            hint: Text("select one"),
            value: extraitemController.selectedExtraItem[dropdowenbutton_index],
            onChanged: (Extraitem? newValue) {
              print(newValue);
              if (newValue != null) {
                extraitemController.selectedExtraItem[dropdowenbutton_index] =
                    newValue;
                print(newValue);
                extraitemController.calculateTotal();
                controller.sellcalculateTotal();
              }
            },
            items: extraitemController.extraItemList.map((Extraitem item) {
              return DropdownMenuItem<Extraitem>(
                value: item,
                child: Row(
                  children: [
                    Text(item.extraitem), // Display extra item name
                    SizedBox(width: 10),
                    Text(item.extraitemprice
                        .toString()), // Display extra item price
                  ],
                ),
              );
            }).toList(),
          )),
    );
  }
}
