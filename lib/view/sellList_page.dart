import 'package:flingstation2/view/forms_receipt.dart';
import 'package:flutter/material.dart';
import 'package:flingstation2/controller/sell_form.dart';
import 'package:flingstation2/model/sellListModel.dart';
import 'package:get/get.dart';

class SsellList extends StatelessWidget {
  final Sell_form_Controller controller = Get.put(Sell_form_Controller());
  @override
  Widget build(BuildContext context) {
    controller.loadselllist();
    // TODO: implement build
    return Scaffold(
      body: Obx(() => ListView.builder(
            itemCount: controller.selllist.length,
            itemBuilder: (context, index) {
              final item = controller.selllist[index];
              return GestureDetector(
                child: Card(
                  elevation: 2,
                  child: ListTile(
                    title: Text('Name: ${item.carno}'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Receitp no: ${item.receipt}'),
                        Text('Item: ${item.mainitemname}'),
                        Text('Total: ${item.grandtotal.toStringAsFixed(2)} TK'),
                      ],
                    ),
                    trailing: Text(item.date),
                  ),
                ),
                onTap: () {
                  Get.to(FormReceipt(
                      itemName: '${controller.selllist[index].mainitemname}',
                      selllistmodel: controller.selllist[index]));
                },
              );
            },
          )),
    );
  }
}
