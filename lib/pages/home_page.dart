import 'package:app05_basedatos/db/db_admin.dart';
import 'package:app05_basedatos/models/task_model.dart';
import 'package:app05_basedatos/widgets/myform_widget.dart';
import 'package:flutter/material.dart';
class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  /* const HomePage({super.key});*/

  Future<String> getFullName() async {
    return "Juan Manuel";
  }

  showDialogForm() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return MyFormWidget();
      },
    );
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Home Page'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialogForm();
          },
          child: const Icon(Icons.add),
        ),
        body: FutureBuilder(
          future: DBAdmin.db.getTasks() /*DBAdmin.db.getTasks()*/,
          builder: (BuildContext context, AsyncSnapshot snap) {
            /*print(snap.hasData);*/
            /* print(snap.data);*/
            if (snap.hasData) {
              List<TaskModel> myTasks = snap.data;
              return ListView.builder(
                itemCount: myTasks.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(myTasks[index].nombre),
                    subtitle: Text(myTasks[index].apellidos),
                    trailing: Text(myTasks[index].id.toString()),
                  );
                },
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        )
        /* Center(
      /*aqui hay un codigo antiguo*/
     /*   child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
              /*  DBAdmin.db.initDatabase();*/
                DBAdmin.db.getTasks();
              },
              child: Text(
                "Mostrar data"
                ),
            ),
            ElevatedButton(
              onPressed: () {
                /*DBAdmin.db.insertRawTask();*/
                DBAdmin.db.insertTask();
              },
              child: Text(
                "Insertar tarea"
                ),
            ),
            ElevatedButton(
              onPressed: () {
                /*DBAdmin.db.updateRawTask();*/
                DBAdmin.db.updateTask();

              },
              child: Text(
                  "Actualizar tarea"
              ),
            ),
            ElevatedButton(
              onPressed: () {
                /*DBAdmin.db.updateRawTask();*/
                DBAdmin.db.deleteTASK();

              },
              child: Text(
                  "Eliminar tarea"
              ),
            ),
          ],
        ),
        */

      ),*/
        );
  }
}
