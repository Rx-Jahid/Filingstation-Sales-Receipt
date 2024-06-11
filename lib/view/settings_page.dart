import 'package:flingstation2/model/extraitem.dart';
import 'package:flingstation2/utilitylogick/printer/view/printerlist.dart';
import 'package:flingstation2/view/estraitemlisr.dart';
import 'package:flingstation2/view/extraitemform.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flingstation2/view/mainitemlist.dart';
import 'package:flingstation2/view/test_page.dart';

class Settings extends StatelessWidget {
  late List<Extraitem> extraitem;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 1.5),
          child: Container(
            height: (MediaQuery.of(context).size.height / 4),
// width: (MediaQuery.of(context).size.width),
            width: 1000,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
            ),
            child: Icon(
              Icons.settings_outlined,
              size: 150,
              color: Color.fromARGB(255, 41, 40, 40),
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Expanded(
            child: GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          children: [
            Card(
              color: Colors.white,
              child: GestureDetector(
                onTap: () {
                  Get.to(() => Printerlist());
                },
                onLongPress: () {
                  // handle long press gesture
                },
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: GridTile(
                    footer: Center(child: Text('Add printer')),
                    child: Icon(
                      Icons.print,
                      size: 100,
                      color: Color.fromARGB(255, 45, 170, 7),
                    ),
                  ),
                ),
              ),
            ),

            ///car Two Petrol
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: Card(
                color: Colors.white,
                child: GestureDetector(
                  onTap: () {
                    Get.to(() => Extraitemlist());
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: GridTile(
                      footer: Center(child: Text('Add Extra Item')),
                      child: Icon(
                        Icons.oil_barrel_outlined,
                        size: 100,
                        color: Color.fromARGB(255, 135, 62, 196),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            ///card disel
            Card(
              color: Colors.white,
              child: GestureDetector(
                onTap: () {
                  Get.to(() => Extraitemfrom(
                        extraitem: Extraitem(
                          "",
                          0,
                        ),
                        title: "Add New",
                      ));
                },
                onLongPress: () {
                  // handle long press gesture
                  Get.to(() => YourWidget());
                },
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: GridTile(
                    footer: Center(child: Text('Delete Old Data')),
                    child: Icon(
                      Icons.delete_forever,
                      size: 100,
                      color: Color.fromARGB(255, 230, 37, 31),
                    ),
                  ),
                ),
              ),
            ),
            Card(
              color: Colors.white,
              child: GestureDetector(
                onTap: () {
                  Get.to(Mainitemlist());
                },
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: GridTile(
                    footer: Center(child: Text('Main Item List')),
                    child: Icon(
                      Icons.oil_barrel,
                      size: 100,
                      color: Color.fromARGB(255, 61, 185, 235),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ))
      ],
    );
  }
}
