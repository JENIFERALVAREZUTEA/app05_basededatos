import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBAdmin {
  Database? myDatabase;

  static final DBAdmin db = DBAdmin._();
  DBAdmin._();

  Future<Database?> chekDatabase() async{
    if (myDatabase != null) {
      return myDatabase;
    }

    myDatabase = await initDatabase();
    return myDatabase;
  }

  initDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, "MatriculaDB.db");
    return await openDatabase(
      path,
      version: 1,
      onOpen: (db) {},
      onCreate: (Database dbx, int version)async {
      await dbx.execute(
            "CREATE TABLE Matricula(id INTEGER PRIMARY KEY AUTOINCREMENT, nombre TEXT, apellidos TEXT, correo TEXT,codigo TEXT)");
      },
    );
  }
}
