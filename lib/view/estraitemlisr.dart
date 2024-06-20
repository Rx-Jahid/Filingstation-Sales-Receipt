import 'package:flingstation2/controller/extraitem_form_controller.dart';
import 'package:flingstation2/model/extraitem.dart';
import 'package:flingstation2/view/extraitemform.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Extraitemlist extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ExtraitemController controller = Get.put(ExtraitemController());
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Extra Item List'),
        centerTitle: true,
      ),
      body: Obx(() => ListView.builder(
            itemCount: controller.extraItemList.length,
            itemBuilder: (context, index) {
              final item = controller.extraItemList[index];
              return GestureDetector(
                onTap: () => Get.to(() => Extraitemfrom(
                      extraitem: item,
                      title: "Update",
                    )),
                child: Card(
                  child: ListTile(
                    leading: Icon(Icons.image),
                    title: Text(item.extraitem),
                    subtitle: Text(item.extraitemprice.toString()),
                    trailing: IconButton(
                      icon: Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                      onPressed: () {
                        controller.deleteExtaitem(item.exid!);
                        controller.loadExtraItems();
                      },
                    ),
                  ),
                ),
              );
            },
          )),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Get.to(() => Extraitemfrom(
                extraitem: Extraitem(
                  "",
                  0.0,
                ),
                title: "Add New",
              ));
        },
      ),
    );
  }
}
