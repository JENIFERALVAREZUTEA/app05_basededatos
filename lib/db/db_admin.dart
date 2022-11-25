import 'dart:io';

import 'package:app05_basedatos/models/task_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBAdmin {
  Database? myDatabase;

  static final DBAdmin db = DBAdmin._();
  DBAdmin._();

  Future<Database?> chekDatabase() async {
    if (myDatabase != null) {
      return myDatabase;
    }

    myDatabase = await initDatabase();
    return myDatabase;
  }

  Future<Database> initDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, "MatriculaDB.db");
    return await openDatabase(
      path,
      version: 1,
      onOpen: (db) {},
      onCreate: (Database dbx, int version) async {
        await dbx.execute(
            "CREATE TABLE Matricula(id INTEGER PRIMARY KEY AUTOINCREMENT, nombre TEXT, apellidos TEXT, correo TEXT,codigo TEXT)");
      },
    );
  }

  Future<int>insertRawTask(TaskModel model) async {
    Database? db = await chekDatabase();
    int res = await db!.rawInsert(
        "INSERT INTO Matricula(nombre,apellidos,correo,codigo)VALUES('${model.nombre}','${model.apellidos}','${model.correo}','${model.codigo}')");
    return res;
  }

  Future<int>insertTask(TaskModel model) async {
    Database? db = await chekDatabase();
    int res = await db!.insert(
        "Matricula",
        {
          "nombre":model.nombre,
          "apellidos":model.apellidos,
          "correo":model.correo,
          "codigo":model.codigo,
        },
    );
    return res;
  }

  getRawTask() async{
    Database? db = await chekDatabase();
    List tasks = await db!.rawQuery("SELECT * FROM Matricula");
    print(tasks);
  }

  Future<List<TaskModel>> getTasks() async{
    Database? db = await chekDatabase();
    List<Map<String,dynamic>> tasks = await db!.query("Matricula");
    List<TaskModel> taskModelList = tasks.map((e) => TaskModel.deMapaModel(e)).toList();



    //tasks.forEach((element) {
   // TaskModel task = TaskMoldel.deMapAmodel(element);
    //TaskModelList.add(task);
   // });

   // print(taskModelList);

    return taskModelList;
  }






updateRawTask()async{
  Database? db = await chekDatabase();
  int res = await db!.rawUpdate("UPDATE Matricula SET nombre='Carlos',apellidos='Ayma Letona',correo='CAL@gmail.com',codigo='202000120a' WHERE id = 2");
  print(res);
  }

  updateTask()async{
    Database? db = await chekDatabase();
    int res = await db!.update("Matricula",
    {
      "nombre":"Gabi",
      "apellidos":"Gonzales Ojeda",
      "correo":"GGO@gmail.com",
      "codigo":"202000221B",
    },
      where: "id=3"
    );

  }

  deletRawTASK()async{
    Database? db = await chekDatabase();
    int res = await db!.rawDelete("DELETE FROM Matricula where id =13");
    print(res);
  }

  Future<int>deleteTASK(int id)async{
    Database? db = await chekDatabase();
    int res = await db!.delete(" Matricula", where: "id =$id");
   return res;
  }

}
