import 'dart:async';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io';
import 'package:path/path.dart';

class JapanPostCode  {
  JapanPostCode._(this._path);
  final _path;
  static Completer<JapanPostCode> _completer;


  static Future<JapanPostCode> getInstance() async {
    if(_completer == null){
      _completer = Completer<JapanPostCode>();
      try {
        var databasesPath = await getDatabasesPath();
        var path = join(databasesPath, "zip.db");

// Check if the database exists
        var exists = await databaseExists(path);

        if (!exists) {
          // Should happen only the first time you launch your application
          print("Creating new copy from asset");

          // Make sure the parent directory exists
          try {
            await Directory(dirname(path)).create(recursive: true);
          } catch (_) {}
//          Directory directory = new Directory("database/zip.db");

          // Copy from asset
          ByteData data = await rootBundle.load(join("packages/japan_postal_code/database", "zip.db"));
//          ByteData data = await rootBundle.load(directory.path);
          List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

          // Write and flush the bytes written
          await File(path).writeAsBytes(bytes, flush: true);
        } else {
          print("Opening existing database");
        }
        _completer.complete(JapanPostCode._(path));
      } on Exception catch (e){
        _completer.completeError(e);
        final Future<JapanPostCode> japanPostalCode = _completer.future;
        _completer = null;
        return japanPostalCode;
      }
    }
    return _completer.future;
  }

  Future<List<Map>> getJapanPostalCode(String code) async{
    Database database = await openDatabase(_path);
    List<Map> list = await database.rawQuery('SELECT * FROM address where code = "$code"');
    return list;
  }

}
