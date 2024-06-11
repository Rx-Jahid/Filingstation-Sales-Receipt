import 'package:flingstation2/controller/mainitem_form_controller.dart';
import 'package:flingstation2/view/mainitemlist.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Mainitemfrom extends StatelessWidget {
  final Maintitem_form_Controller controller =
      Get.put(Maintitem_form_Controller());
  final String itemName;
  Mainitemfrom({required this.itemName}) {
    controller.itemnamecontroller.text = itemName;
    controller.itempricecontroller.text =
        controller.box.read(itemName).toString();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
          title: Text(
            'Update Main items Price',
            style: TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.indigoAccent, Colors.deepPurpleAccent])),
          )),
      body: Form(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(padding: EdgeInsets.all(5), children: <Widget>[
          SizedBox(
            height: 30,
          ),
          TextFormField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Item",
            ),
            controller: controller.itemnamecontroller,
            enabled: false,
          ),
          SizedBox(
            height: 30,
          ),
          TextFormField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Price",
            ),
            controller: controller.itempricecontroller,
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            onChanged: (value) {},
          ),
          SizedBox(
            height: 30,
          ),
          Padding(
            padding:
                const EdgeInsets.only(top: 20, left: 10, right: 10, bottom: 10),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red, // background
                foregroundColor: Colors.white, // foreground
              ),
              onPressed: () {
                print(controller.itempricecontroller);
                controller.setMaineitempriceWithcontroller();
                Get.off(() => Mainitemlist());
              },
              child: Text('Update'),
            ),
          )
        ]),
      )),
    );
  }
}
