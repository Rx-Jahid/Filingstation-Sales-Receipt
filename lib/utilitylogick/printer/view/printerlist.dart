import 'package:flingstation2/utilitylogick/printer/controller/printer_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';

class Printerlist extends StatelessWidget {
  Printerlist({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Initialize the controller here
    final PrinterController controller = Get.put(PrinterController());

    return MaterialApp(
      debugShowCheckedModeBanner: false, // Hide the debug banner
      home: Scaffold(
        appBar: AppBar(
          elevation: 1,
          title: Text('Add Printer'),
        ),
        body: Obx(() {
          return Center(
            child: Container(
              height: double.infinity,
              constraints: const BoxConstraints(maxWidth: 400),
              child: SingleChildScrollView(
                padding: EdgeInsets.zero,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed:
                                  controller.selectedPrinter.value == null ||
                                          controller.isConnected.value
                                      ? null
                                      : () {
                                          // State change happens in the event callback, not during build
                                          controller.connectDevice();
                                        },
                              child: const Text("Connect",
                                  textAlign: TextAlign.center),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: controller.selectedPrinter.value ==
                                          null ||
                                      !controller.isConnected.value
                                  ? null
                                  : () {
                                      if (controller.selectedPrinter.value !=
                                          null) {
                                        controller.printerManager.disconnect();
                                        controller.isConnected(false);
                                      }
                                    },
                              child: const Text("Disconnect",
                                  textAlign: TextAlign.center),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Visibility(
                      visible: Platform.isAndroid,
                      child: SwitchListTile.adaptive(
                        contentPadding:
                            const EdgeInsets.only(bottom: 20.0, left: 20),
                        title: const Text(
                          "This device supports BLE (low energy)",
                          textAlign: TextAlign.start,
                          style: TextStyle(fontSize: 19.0),
                        ),
                        value: controller.isBle.value,
                        onChanged: (bool? value) {
                          // State change happens in the event callback, not during build
                          controller.isBle(value ?? false);
                          controller.isConnected(false);
                          controller.selectedPrinter.value = null;
                          controller.scan();
                        },
                      ),
                    ),
                    Visibility(
                      visible: Platform.isAndroid,
                      child: SwitchListTile.adaptive(
                        contentPadding:
                            const EdgeInsets.only(bottom: 20.0, left: 20),
                        title: const Text(
                          "Reconnect",
                          textAlign: TextAlign.start,
                          style: TextStyle(fontSize: 19.0),
                        ),
                        value: controller.reconnect.value,
                        onChanged: (bool? value) {
                          // State change happens in the event callback, not during build
                          controller.reconnect(value ?? false);
                        },
                      ),
                    ),
                    Column(
                      children: controller.devices.map((device) {
                        return ListTile(
                          title: Text('${device.deviceName}'),
                          onTap: () {
                            // State change happens in the event callback, not during build
                            controller.selectDevice(device);
                          },
                          leading: controller.selectedPrinter.value != null &&
                                  ((device.address != null &&
                                      controller
                                              .selectedPrinter.value!.address ==
                                          device.address))
                              ? const Icon(
                                  Icons.check,
                                  color: Colors.green,
                                )
                              : null,
                          trailing: OutlinedButton(
                            onPressed:
                                controller.selectedPrinter.value == null ||
                                        device.deviceName !=
                                            controller.selectedPrinter.value
                                                ?.deviceName
                                    ? null
                                    : () async {
                                        // State change happens in the event callback, not during build
                                        controller.printReceiveTest();
                                      },
                            child: const Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 2, horizontal: 20),
                              child: Text("Print test ticket",
                                  textAlign: TextAlign.center),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
