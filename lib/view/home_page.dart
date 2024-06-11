import 'package:flingstation2/controller/extraitem_form_controller.dart';
import 'package:flingstation2/controller/mainitem_form_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flingstation2/view/forms_receipt.dart';

class Home extends StatelessWidget {
  final ExtraitemController extraitemController =
      Get.put(ExtraitemController());
  final Maintitem_form_Controller maintitem_form_controller =
      Get.put(Maintitem_form_Controller());
  AssetImage assetimage = AssetImage('lib/assets/images/gas-station.png');
  AssetImage petrolimage = AssetImage('lib/assets/images/petrol.png');
  AssetImage octenimage = AssetImage('lib/assets/images/nozel.png');

  @override
  Widget build(BuildContext context) {
    //extraitemController.loadExtraItems;
    // TODO: implement build
    return Container(
      child: Scaffold(
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 1.5),
              child: Container(
                height: (MediaQuery.of(context).size.height / 4),
                width: (MediaQuery.of(context).size.width),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Image(image: assetimage),
              ),
            ),

            //Frist img
            ///card one octen

            Card(
              color: Color(0xff74b9ff),
              elevation: 20,
              child: ListTile(
                leading: ImageIcon(
                  octenimage,
                  color: Colors.white,
                  size: 100,
                ),
                title: Text(
                  "OCTEN",
                  style: TextStyle(color: Colors.white, fontSize: 40),
                ),
                onTap: () {
                  Get.to(FormReceipt(
                    itemName: 'octen',
                  ));
                },
              ),
            ),

            ///car Two Petrol
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: Card(
                  elevation: 20,
                  color: Color(0xffa29bfe),
                  child: ListTile(
                    leading: ImageIcon(
                      octenimage,
                      color: Colors.white,
                      size: 100,
                    ),
                    title: Text(
                      "PETROL",
                      style: TextStyle(color: Colors.white, fontSize: 40),
                    ),
                    onTap: () {},
                  )),
            ),

            ///card disel
            Card(
                borderOnForeground: true,
                elevation: 20,
                color: Color(0xfffab1a0),
                child: ListTile(
                  leading: ImageIcon(
                    octenimage,
                    color: Colors.white,
                    size: 100,
                  ),
                  title: Text(
                    "DISEL",
                    style: TextStyle(color: Colors.white, fontSize: 40),
                  ),
                  onTap: () {},
                )),
            Card(
                elevation: 20,
                color: Color(0xff81ecec),
                child: ListTile(
                  leading: ImageIcon(
                    octenimage,
                    color: Colors.white,
                    size: 100,
                  ),
                  title: Text(
                    "OTHERS",
                    style: TextStyle(color: Colors.white, fontSize: 40),
                  ),
                  onTap: () {
                    () {};
                  },
                ))
          ],
        ),
      ),
    );
  }
}
