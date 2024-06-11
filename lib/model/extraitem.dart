class Extraitem {
  int? _exid;

  late String _extraitem;
  late double _extraitemprice;
  Extraitem(
    this._extraitem,
    this._extraitemprice,
  );
  Extraitem.withid(
    this._exid,
    this._extraitem,
    this._extraitemprice,
  );
  int? get exid => _exid;
  String get extraitem => _extraitem;
  double get extraitemprice => _extraitemprice;

  set extraitem(String newmainitemname) {
    this._extraitem = newmainitemname;
  }

  set extraitemprice(double newmaninitemrate) {
    print(newmaninitemrate);
    this._extraitemprice = newmaninitemrate.toDouble();
    print(newmaninitemrate);
  }

//obj to map
  Map<String, dynamic> tomap() {
    var map = Map<String, dynamic>();
    if (exid != null) {
      map['exid'] = _exid;
    }
    map['extraitem'] = _extraitem;
    map['extraitemprice'] = _extraitemprice;
    return map;
  }

//map to obj
  Extraitem.toobj(Map<String, dynamic> map) {
    this._exid = map['exid'];
    this._extraitem = map['extraitem'];
    this._extraitemprice = map['extraitemprice'].toDouble();
  }
}
