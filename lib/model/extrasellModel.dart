class Extrasellmodel{
  int? _sellexid;
  late String _sellexdate;
  late String _receipt;
  late String _sellextraitem;
  late num _sellextraitemprice;
  late num _sellexitempricetotal;
  late String _sellexgroup;
  Extrasellmodel(this._sellexdate,this._receipt,this._sellextraitem,this._sellextraitemprice,this._sellexitempricetotal,this._sellexgroup);
  Extrasellmodel.withid( this._sellexid,this._sellexdate,this._receipt,this._sellextraitem,this._sellextraitemprice,this._sellexitempricetotal,this._sellexgroup);
  int? get sellexid => _sellexid;
  String get sellexdate=>_sellexdate;
  String get receipt=>_receipt;
  String get sellextraitem=>_sellextraitem;
  num get sellextraitemprice=>_sellextraitemprice;
  num get sellexitempricetotal=>_sellexitempricetotal;
  String get sellexgroup=>_sellexgroup;

  set sellexdate(String newdate){
    this._sellexdate=newdate;
  }
  set receipt(String newreceipt){
    this._receipt=newreceipt;
  }
  set sellextraitem(String newmainitemname){
    this._sellextraitem=newmainitemname;
  }
  set sellextraitemprice(num newmaninitemrate){
    this._sellextraitemprice=newmaninitemrate;
  }set sellexitempricetotal(num newmaninitemrate){
    this._sellexitempricetotal=newmaninitemrate;
  }
  set sellexgroup(String newmainitemname){
    this._sellexgroup=newmainitemname;
  }

//obj to map
  Map<String,dynamic>tomap(){
    var map=Map<String,dynamic>();
    if (sellexid != null) {
      map['sellexid'] = _sellexid;
    }
    map['sellexdate']=_sellexdate;
    map['receipt']=_receipt;
    map['sellextraitemname']=_sellextraitem;
    map['sellextraitemprice']=_sellextraitemprice;
    map['sellexitempricetotal']=_sellexitempricetotal;
    map['sellexgroup']=_sellexgroup;
    return map;
  }
//map to obj
  Extrasellmodel.toobj(Map<String,dynamic>map){
    this._sellexid= map['sellexid'] ;
    this._sellexdate=map['sellexdate'];
    this._receipt=map['receipt'];
    this._sellextraitem=map['sellextraitemname'];
    this._sellextraitemprice= map['sellextraitemprice'];
    this._sellexitempricetotal=map['sellexitempricetotal'];
    this._sellexgroup= map['sellexgroup'];
  }

}
