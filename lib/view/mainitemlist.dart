import 'package:flingstation2/controller/mainitem_form_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flingstation2/view/forms_receipt.dart';
import 'package:flingstation2/view/test_page.dart';
import 'package:flingstation2/view/mainitemfrom.dart';

class Mainitemlist extends StatelessWidget {
  final Maintitem_form_Controller controller =
      Get.put(Maintitem_form_Controller());
  AssetImage assetimage = AssetImage('lib/assets/images/gas-station.png');
  AssetImage petrolimage = AssetImage('lib/assets/images/petrol.png');
  AssetImage octenimage = AssetImage('lib/assets/images/nozel.png');
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: Scaffold(
        appBar: AppBar(
            title: Text(
              'Main item list',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            flexibleSpace: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Colors.indigoAccent, Colors.deepPurpleAccent])),
            )),
        body: ListView(
          children: [
            SizedBox(
              height: 100,
            ),
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
                  Get.to(() => Mainitemfrom(itemName: "octen"));
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
                    onTap: () {
                      Get.to(() => Mainitemfrom(itemName: "petrol"));
                    },
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
                  onTap: () {
                    Get.to(() => Mainitemfrom(itemName: "disel"));
                  },
                )),
          ],
        ),
      ),
    );
  }
}
