class BluetoothPrinter {
  int? id;
  String? deviceName;
  String? address;
  bool? isBle;

  bool? state;

  BluetoothPrinter(
      {this.deviceName, this.address, this.state, this.isBle = false});
}
