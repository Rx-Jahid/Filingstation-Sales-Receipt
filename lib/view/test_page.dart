import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flingstation2/controller/databasehalper.dart';
import 'package:flingstation2/controller/extraitem_form_controller.dart';
import 'package:flingstation2/model/extraitem.dart';

class YourWidget extends StatelessWidget {
  final ExtraitemController extraitemController =
      Get.put(ExtraitemController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dropdown List Example'),
      ),
      body: Center(
        child: Obx(() {
          // Display dropdown only when extra items are loaded
          if (extraitemController.extraItemList.isEmpty) {
            return CircularProgressIndicator();
          } else {
            return DropdownButton<Extraitem>(
              hint: Text("select one"),
              value: extraitemController.selectedExtraItem[0],
              onChanged: (Extraitem? newValue) {
                print(newValue);
                if (newValue != null) {
                  extraitemController.selectedExtraItem[0] = newValue;
                  print(newValue);
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
            );
          }
        }),
      ),
    );
  }
}
