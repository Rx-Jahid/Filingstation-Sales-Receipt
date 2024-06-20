import 'package:flingstation2/model/extraitem.dart';
import 'package:flingstation2/model/extrasellModel.dart';
import 'package:flingstation2/model/sellListModel.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DBcontrolar {
  static final DBcontrolar? _dbcontrolar = DBcontrolar.createinstence();
  static Database? _database;

  DBcontrolar.createinstence();

  //Add_extra_item
  String extraiemtable = 'addextraitemtable'; // table name
  String extraitemid = 'exid'; // column name
  String exdate = 'exdate';
  String extraitem = 'extraitem';
  String extraitemprice = 'extraitemprice';
  String extraitemgroup = 'exgroup';
  //sell_receipt
  String dbtable = 'selltable';
  String colid = 'id';
  String coldate = 'date';
  String colreceipt = 'receipt';
  String colcarnum = 'carno';
  String colcarname = 'carname';
  String colmainitemname = 'mainitemname';
  String colmainitemrate = 'mainitemrate';
  String colmainitemquantity = 'mainitemquantity';
  String colmainitemtotalprice = 'mainitemtotalprice';
  String colgrandtotal = 'grandtotal';
  //Sell_extra_item
  String sellexiemtable = 'sellexitemtable';
  String sellexitemid = 'sellexid';
  String sellexreceipt = 'receipt';
  String sellexdate = 'sellexdate';
  String sellextraitem = 'sellextraitemname';
  String sellextraitemprice = 'sellextraitemprice';
  String sellexitempricetotal = 'sellexitempricetotal';
  String sellextraitemgroup = 'sellexgroup';
  //db creat and open
  Future<Database?> get database async {
    if (_database == null) {
      print("Data base is null");
      _database = await initializeDatabase();
    }
    print("Data base is not null");
    return _database;
  }

  Future<Database> initializeDatabase() async {
    // Get the directory path for both Android and iOS to store database.
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'flingstation.db';

    // Open/create the database at a given path
    var flingstationDatabase =
        await openDatabase(path, version: 1, onCreate: _createDb);
    return flingstationDatabase;
  }

  void _createDb(Database db, int newVersion) async {
    //extraitem table
    await db.execute(
        'CREATE TABLE $extraiemtable($extraitemid INTEGER PRIMARY KEY AUTOINCREMENT, '
        '$extraitem TEXT, $extraitemprice INTEGER)');
    //sell_table
    await db.execute(
        'CREATE TABLE $dbtable($colid INTEGER PRIMARY KEY AUTOINCREMENT, $coldate TEXT, '
        '$colreceipt TEXT,$colcarnum TEXT,$colmainitemname TEXT, $colmainitemrate INTEGER,$colgrandtotal INTEGER,$colmainitemquantity INTEGER,$colmainitemtotalprice INTEGER)');
    await db.execute(
        'CREATE TABLE $sellexiemtable($sellexitemid INTEGER PRIMARY KEY AUTOINCREMENT, $sellexdate TEXT,$sellexreceipt TEXT, '
        '$sellextraitem TEXT, $sellextraitemprice INTEGER,$sellexitempricetotal INTEGER,$sellextraitemgroup TEXT)');
  }

/*-- all insert --*/
  // insert add extra ietm
  Future<int> insertextraitem(Extraitem extraitemmodel) async {
    var db = await this.database;
    var result = await db!.insert(extraiemtable, extraitemmodel.tomap());
    print(result);
    return result;
  }

  //insert sell receipt
  Future<int> insertsell(Selllistmodel selllistmodel) async {
    var db = await this.database;
    var result = await db!.insert(dbtable, selllistmodel.tomap());
    return result;
  }

  //insert extra itwm sell
  Future<int> insertextrasellitem(Extrasellmodel extrasellmodel) async {
    var db = await this.database;
    print(extrasellmodel.tomap());
    var result = await db!.insert(sellexiemtable, extrasellmodel.tomap());
    return result;
  }

  /* all update and delete*/
  Future<int> updateextraitem(Extraitem extraitemmodel) async {
    var db = await this.database;
    var result = await db!.update(extraiemtable, extraitemmodel.tomap(),
        where: '$extraitemid = ?', whereArgs: [extraitemmodel.exid]);
    return result;
  }

  // Delete Operation: Delete a Note object from database
  Future<int> deleteextraitem(int id) async {
    var db = await this.database;
    int result = await db!
        .rawDelete('DELETE FROM $extraiemtable WHERE $extraitemid = $id');
    return result;
  }

/*-- all mape list --*/
  Future<List<Map<String, dynamic>>> getextraitemMapList() async {
    Database? db = await this.database;
//		var result = await db.rawQuery('SELECT * FROM $noteTable order by $colPriority ASC');
    var result = await db!.query(extraiemtable, orderBy: '$extraitemid ASC');
    return result;
  }

  Future<List<Map<String, dynamic>>> getSellMapList() async {
    Database? db = await this.database;
//		var result = await db.rawQuery('SELECT * FROM $noteTable order by $colPriority ASC');
    var result = await db!.query(dbtable, orderBy: '$colid ASC');
    // var result = await db!.query(dbtable,where: '$colreceipt= $value', orderBy: '$colid ASC');
    return result;
  }

//with wher aregument
  Future<List<Map<String, dynamic>>> getexSellMapList(value) async {
    Database? db = await this.database;
    var result = await db!.query(sellexiemtable,
        where: '$sellexreceipt = $value', orderBy: '$sellexitemid ASC');
    return result;
  }

  //with out wher aregument
  Future<List<Map<String, dynamic>>> getexSellMapLists() async {
    Database? db = await this.database;
//		var result = await db.rawQuery('SELECT * FROM $noteTable order by $colPriority ASC');
    var result = await db!.query(sellexiemtable, orderBy: '$sellexitemid ASC');
    //var result = await db!.query(sellexiemtable,where: '$sellexreceipt = $value', orderBy: '$sellexitemid ASC');
    return result;
  }

/*-- all get list --*/

  Future<List<Extraitem>> getextraitemList() async {
    var extralistmodelMapList =
        await getextraitemMapList(); // Get 'Map List' from database
    int count = extralistmodelMapList
        .length; // Count the number of map entries in db table
    List<Extraitem> extraitemlist = <Extraitem>[];
    // For loop to create a 'Note List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      extraitemlist.add(Extraitem.toobj(extralistmodelMapList[i]));
    }
    return extraitemlist;
  }

  Future<List<Selllistmodel>> getSellList() async {
    var selllistmodelMapList =
        await getSellMapList(); // Get 'Map List' from database
    int count = selllistmodelMapList
        .length; // Count the number of map entries in db table
    List<Selllistmodel> selllist = <Selllistmodel>[];
    // For loop to create a 'Note List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      selllist.add(Selllistmodel.toobj(selllistmodelMapList[i]));
    }
    return selllist;
  }

  //with wher arument
  Future<List<Extrasellmodel>> getextrasellitemList(value) async {
    var extraselllistmodelMapList =
        await getexSellMapList(value); // Get 'Map List' from database
    int count = extraselllistmodelMapList
        .length; // Count the number of map entries in db table
    List<Extrasellmodel> extrasellitemlist = <Extrasellmodel>[];
    // For loop to create a 'Note List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      extrasellitemlist.add(Extrasellmodel.toobj(extraselllistmodelMapList[i]));
    }
    return extrasellitemlist;
  }

  //with out wher arument
  Future<List<Extrasellmodel>> getextrasellitemLists() async {
    var extraselllistmodelMapList =
        await getexSellMapLists(); // Get 'Map List' from database
    int count = extraselllistmodelMapList
        .length; // Count the number of map entries in db table
    List<Extrasellmodel> extrasellitemlist = <Extrasellmodel>[];
    // For loop to create a 'Note List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      extrasellitemlist.add(Extrasellmodel.toobj(extraselllistmodelMapList[i]));
    }
    return extrasellitemlist;
  }
}
