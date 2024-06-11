class Selllistmodel{
   int? _id;
  late String _date;
  late String _receipt;
  late String _carno;
  late String _mainitemname;
  late num _mainitemrate;
   num?  _mainitemquantity;
   num? _mainitemtotalprice;
  late num _grandtotal;
Selllistmodel(this._date,this._receipt,this._carno,this._mainitemname,this._mainitemrate,this._grandtotal,[this._mainitemquantity,this._mainitemtotalprice]);
Selllistmodel.withid( this._id,this._date,this._receipt,this._carno,this._mainitemname,this._mainitemrate,this._grandtotal,[this._mainitemquantity,this._mainitemtotalprice]);
int? get id => _id;
String get date=>_date;
String get receipt=>_receipt;
String get carno=>_carno;
String get mainitemname=>_mainitemname;
num get mainitemrate=>_mainitemrate;
num? get mainitemquantity=>_mainitemquantity;
num? get mainitemtotalprice=>_mainitemtotalprice;
num get grandtotal=>_grandtotal;

set date(String newdate){
  this._date=newdate;
}
set receipt(String newreceipt){
  this._receipt=newreceipt;
}
set carno(String newcarno){
  this._carno=newcarno;
}
set mainitemname(String newmainitemname){
  this._mainitemname=newmainitemname;
}
set mainitemrate(num newmaninitemrate){
  this._mainitemrate=newmaninitemrate;
}
set mainitemquantity(num? newmainitemquantity){
  this._mainitemquantity=newmainitemquantity;
}
set mainitemtotalprice(num? newdmainitemprice){
  this._mainitemtotalprice=newdmainitemprice;
}
set grandtotal(num newdgrandtotal){
  this._grandtotal=newdgrandtotal;
}

//obj to map
Map<String,dynamic>tomap(){
  var map=Map<String,dynamic>();
  if (id != null) {
    map['id'] = _id;
  }
  map['date']=_date;
  map['receipt']=_receipt;
  map['carno']=_carno;
  map['mainitemname']=_mainitemname;
  map['mainitemrate']=_mainitemrate;
  map['mainitemquantity']=_mainitemquantity;
  map['mainitemtotalprice']=_mainitemtotalprice;
  map['grandtotal']=_grandtotal;
  return map;
}
//map to obj
  Selllistmodel.toobj(Map<String,dynamic>map){
  this._id= map['id'] ;
  this._date=map['date'];
  this._receipt=map['receipt'];
  this._carno=map['carno'];
  this._mainitemname=map['mainitemname'];
  this._mainitemrate= map['mainitemrate'];
  this._mainitemquantity= map['mainitemquantity'];
  this._mainitemtotalprice= map['mainitemtotalprice'];
  this._grandtotal= map['grandtotal'];
  }

}
