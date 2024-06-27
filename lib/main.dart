import 'package:flutter/material.dart';
import 'package:flingstation2/view/home_page.dart';
import 'package:flingstation2/view/settings_page.dart';
import 'package:flingstation2/view/sellList_page.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';

void main() {
  runApp(Myapp());
}

class Myapp extends StatelessWidget {
  var _currentIndex = 1.obs;
  final List<Widget> _pages = [Settings(), Home(), SsellList()];
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    // TODO: implement build
    return GetMaterialApp(
        debugShowCheckedModeBanner: false, // Hide the debug banner
        title: 'Filling Station',
        home: Scaffold(
          appBar: AppBar(
              title: Text(
                'PRODHAN CNG & FILLING STATION',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              flexibleSpace: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                  Colors.indigoAccent,
                  Colors.deepPurpleAccent
                ])),
              )),
          body: Obx(
            () => _pages[_currentIndex.value],
          ),
          bottomNavigationBar: Obx(() => BottomNavigationBar(
                currentIndex: _currentIndex.value,
                onTap: (index) {
                  _currentIndex.value = index;
                },
                items: const <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: Icon(Icons.settings),
                    label: 'Settings',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.list_rounded),
                    label: 'Sell List',
                  ),
                ],
              )),
        ));
  }
}
