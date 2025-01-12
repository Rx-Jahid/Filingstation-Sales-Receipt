import 'dart:developer';
import 'package:flingstation2/model/extraitem.dart';
import 'package:flingstation2/model/sellListModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'dart:async';
import 'dart:io';
import 'package:esc_pos_utils/esc_pos_utils.dart';
import 'package:smart_bluetooth_pos_printer/smart_bluetooth_pos_printer.dart';
import 'package:flingstation2/utilitylogick/printer/model/bluetoothPrinter.dart';

class PrinterController extends GetxController {
  var isBle = false.obs;
  var reconnect = false.obs;
  var isConnected = false.obs;
  var printerManager = PrinterManager.instance;
  var devices = <BluetoothPrinter>[].obs;
  StreamSubscription<List<PrinterDevice>>? subscription;
  StreamSubscription<BTStatus>? subscriptionBtStatus;
  BTStatus currentStatus = BTStatus.none;
  List<int>? pendingTask;
  var selectedPrinter = Rx<BluetoothPrinter?>(null); // Changed to Rx

  @override
  void onInit() {
    super.onInit();
    scan();
    subscriptionBtStatus = printerManager.stateBluetooth.listen((status) {
      log(' ----------------- status bt $status ------------------ ');
      currentStatus = status;
      if (status == BTStatus.connected) {
        isConnected(true);
      } else if (status == BTStatus.none) {
        isConnected(false);
      }
      if (status == BTStatus.connected && pendingTask != null) {
        if (Platform.isAndroid) {
          Future.delayed(const Duration(milliseconds: 1000), () {
            printerManager.send(bytes: pendingTask!);
            pendingTask = null;
          });
        } else if (Platform.isIOS) {
          printerManager.send(bytes: pendingTask!);
          pendingTask = null;
        }
      }
    });
  }

  @override
  void onClose() {}

  void scan() {
    printerManager.startScan(timeout: const Duration(seconds: 4), isBle: true);
    subscription = printerManager.scanResults().listen((results) {
      devices.clear();
      for (PrinterDevice r in results) {
        devices.add(BluetoothPrinter(
          deviceName: r.name,
          address: r.address,
          isBle: isBle.value,
        ));
      }
    });
  }

  void selectDevice(BluetoothPrinter device) async {
    if (selectedPrinter.value != null) {
      if (device.address != selectedPrinter.value!.address) {
        await PrinterManager.instance.disconnect();
      }
    }
    selectedPrinter.value = device; // Update the selectedPrinter with Rx
  }

  Future printReceiveTest() async {
    List<int> bytes = [];
    final profile = await CapabilityProfile.load(name: 'XP-N160I');
    final generator = Generator(PaperSize.mm80, profile);
    bytes += generator.setGlobalCodeTable('CP1252');
    bytes += generator.text('Test Print',
        styles: const PosStyles(align: PosAlign.center));
    bytes += generator.text('Product 1');
    bytes += generator.text('Product 2');
    printEscPos(bytes, generator);
  }

  String replaceNonAscii(String text) {
    return text.replaceAllMapped(RegExp(r'[^\x00-\x7F]'), (match) => '?');
  }

  Future<void> printReceive(
      List<Extraitem> mylidt, Selllistmodel selllistmodel) async {
    List<int> bytes = [];

    final profile = await CapabilityProfile.load(name: 'XP-N160I');
    final generator = Generator(PaperSize.mm80, profile);
    bytes += generator.setGlobalCodeTable('CP1252');
    bytes += generator.row([
      PosColumn(
          text: 'Prodhan',
          width: 5,
          styles: PosStyles(
              align: PosAlign.right,
              height: PosTextSize.size3,
              width: PosTextSize.size2,
              bold: true)),
      PosColumn(
          text: 'CNG',
          width: 1,
          styles: PosStyles(
            align: PosAlign.center,
          )),
      PosColumn(
          text: 'Filling Station',
          width: 6,
          styles: PosStyles(
              align: PosAlign.left,
              height: PosTextSize.size3,
              width: PosTextSize.size1,
              bold: true)),
    ]);
    bytes += generator.text("D N Road Ponchoboti,Fatullah,Narayanganj",
        styles: PosStyles(align: PosAlign.center));
    bytes += generator.text('Mobile: +8801304430010',
        styles: PosStyles(align: PosAlign.center));
    bytes += generator.hr();
    bytes += generator.text('Date:-' + selllistmodel.date,
        styles: PosStyles(align: PosAlign.center));
    bytes += generator.row([
      PosColumn(
          text: 'CarNo:- ${replaceNonAscii(selllistmodel.carno)}',
          width: 6,
          styles: PosStyles(align: PosAlign.left, bold: true)),
      PosColumn(
          text: 'R.No:-${selllistmodel.receipt}',
          width: 6,
          styles: PosStyles(align: PosAlign.right, bold: true)),
    ]);
    bytes += generator.hr();
    bytes += generator.row([
      PosColumn(
          text: 'Product',
          width: 6,
          styles: PosStyles(align: PosAlign.left, bold: true)),
      PosColumn(
          text: 'Qty',
          width: 2,
          styles: PosStyles(align: PosAlign.center, bold: true)),
      PosColumn(
          text: 'Rate',
          width: 2,
          styles: PosStyles(align: PosAlign.center, bold: true)),
      PosColumn(
          text: 'Total',
          width: 2,
          styles: PosStyles(align: PosAlign.right, bold: true)),
    ]);
    bytes += generator.hr(ch: '.', linesAfter: 1);
    bytes += generator.row([
      PosColumn(
          text: selllistmodel.mainitemname,
          width: 6,
          styles: PosStyles(
              align: PosAlign.left,
              height: PosTextSize.size2,
              width: PosTextSize.size2,
              bold: true)),
      PosColumn(
          text: selllistmodel.mainitemquantity.toString(),
          width: 2,
          styles: PosStyles(align: PosAlign.center, bold: true)),
      PosColumn(
          text: selllistmodel.mainitemrate.toString(),
          width: 2,
          styles: PosStyles(align: PosAlign.center, bold: true)),
      PosColumn(
          text: selllistmodel.mainitemtotalprice.toString(),
          width: 2,
          styles: PosStyles(align: PosAlign.right, bold: true)),
    ]);
    bytes += generator.hr(
      ch: ' ',
    );
    bytes += generator.hr();
    bytes += generator.hr();
    bytes += generator.row([
      PosColumn(
          text: 'Mobil',
          width: 6,
          styles: PosStyles(align: PosAlign.left, bold: true)),
      PosColumn(
          text: 'Qty',
          width: 2,
          styles: PosStyles(align: PosAlign.center, bold: true)),
      PosColumn(
          text: 'Price',
          width: 2,
          styles: PosStyles(align: PosAlign.center, bold: true)),
      PosColumn(
          text: 'Total',
          width: 2,
          styles: PosStyles(align: PosAlign.right, bold: true)),
    ]);
    bytes += generator.hr(ch: '.', linesAfter: 1);
    for (int i = 0; i < mylidt.length; i++) {
      bytes += generator.row([
        PosColumn(
            text: mylidt[i].extraitem.toString(),
            width: 6,
            styles: PosStyles(
              align: PosAlign.left,
            )),
        PosColumn(
            text: "1", width: 2, styles: PosStyles(align: PosAlign.center)),
        PosColumn(
            text: mylidt[i].extraitemprice.toString(),
            width: 2,
            styles: PosStyles(
              align: PosAlign.center,
            )),
        PosColumn(
            text: mylidt[i].extraitemprice.toString(),
            width: 2,
            styles: PosStyles(align: PosAlign.right)),
      ]);
    }

    bytes += generator.hr(linesAfter: 1);

    bytes += generator.row([
      PosColumn(
          text: 'TOTAL',
          width: 6,
          styles: PosStyles(
            align: PosAlign.left,
            height: PosTextSize.size2,
            width: PosTextSize.size2,
          )),
      PosColumn(
          text: selllistmodel.grandtotal.toString(),
          width: 6,
          styles: PosStyles(
            align: PosAlign.right,
            height: PosTextSize.size2,
            width: PosTextSize.size2,
          )),
    ]);

    bytes += generator.hr(ch: '=', linesAfter: 1);

    // ticket.feed(2);
    bytes += generator.text('Thank you!',
        styles: PosStyles(align: PosAlign.center, bold: true));
    printEscPos(bytes, generator);
  }

  void printEscPos(List<int> bytes, Generator generator) async {
    if (selectedPrinter.value == null) return;
    var bluetoothPrinter = selectedPrinter.value!;
    bytes += generator.cut();
    await printerManager.connect(
      model: BluetoothPrinterInput(
        name: bluetoothPrinter.deviceName,
        address: bluetoothPrinter.address!,
        isBle: bluetoothPrinter.isBle ?? false,
        autoConnect: reconnect.value,
      ),
    );
    pendingTask = null;
    if (Platform.isAndroid) pendingTask = bytes;
    if (Platform.isAndroid) {
      if (currentStatus == BTStatus.connected) {
        printerManager.send(bytes: bytes);
        pendingTask = null;
      }
    } else {
      printerManager.send(bytes: bytes);
    }
  }

  Future<void> connectDevice() async {
    isConnected(false);
    if (selectedPrinter.value == null) return;
    await printerManager.connect(
      model: BluetoothPrinterInput(
        name: selectedPrinter.value!.deviceName,
        address: selectedPrinter.value!.address!,
        isBle: selectedPrinter.value!.isBle ?? false,
        autoConnect: reconnect.value,
      ),
    );
  }
}
