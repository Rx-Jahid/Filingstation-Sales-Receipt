import 'package:flingstation2/controller/extraitem_form_controller.dart';
import 'package:flingstation2/model/extraitem.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Extraitemfrom extends StatelessWidget {
  final Extraitem extraitem;
  final ExtraitemController controller = Get.put(ExtraitemController());
  final String title;
  Extraitemfrom({required this.title, required this.extraitem});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
          title: Text(
            '$title Extra items Price',
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
            controller: controller.itemnamecontrollers,
          ),
          SizedBox(
            height: 30,
          ),
          TextFormField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Price",
            ),
            controller: controller.itempricecontrollers,
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
                controller.setExtraitempriceWithcontroller(extraitem);
              },
              child: Text(title),
            ),
          )
        ]),
      )),
    );
  }
}
