import 'package:app05_basedatos/db/db_admin.dart';
import 'package:app05_basedatos/models/task_model.dart';
import 'package:flutter/material.dart';

class MyFormWidget extends StatefulWidget {
  const MyFormWidget({Key? key}) : super(key: key);

  @override
  State<MyFormWidget> createState() => _MyFormWidgetState();
}

class _MyFormWidgetState extends State<MyFormWidget> {

  final _formkey = GlobalKey<FormState>();
  bool isFinished = false;
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _apellidosController = TextEditingController();
  final TextEditingController _correoController = TextEditingController();
  final TextEditingController _codigoController = TextEditingController();

  addTask() {
    if(_formkey.currentState!.validate()){
      TaskModel taskModel = TaskModel(

          nombre: _nombreController.text,
          apellidos: _apellidosController.text,
          correo: _correoController.text,
          codigo: _codigoController.text
      );
      DBAdmin.db.insertTask(taskModel).then((value){
        if (value >0){
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.indigo,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0)
              ),
              duration: const Duration(milliseconds: 1400),
              content:Row(
                children: [
                  Icon(Icons.check_circle, color: Colors.white),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(
                      "registrado exitosamente"
                  ),
                ],
              ),
            ),
          );
        }
      });
    }


  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Form(
        key: _formkey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Formulario"),
            const SizedBox(
              height: 6.0,
            ),
            TextFormField(
              controller: _nombreController,
              maxLines: 2,
              decoration: InputDecoration(hintText: "Nombre"),
              validator: (String? value) {

                if(value!.isEmpty){
                  return "el campo es obligatorio";
                }
                if(value.length < 6){
                  return "debe de ser mas de 4 caracteres";
                }
                return null;
              },
            ),
            const SizedBox(
              height: 6.0,
            ),
            TextFormField(
              controller: _apellidosController,
              maxLines: 2,
              decoration: InputDecoration(hintText: "Apellidos"),
              validator: (String? value) {

                if(value!.isEmpty){
                  return "el campo es obligatorio";
                }

                return null;
              },
            ),
            const SizedBox(
              height: 6.0,
            ),
            TextFormField(
              controller: _correoController,
              maxLines: 2,
              decoration: InputDecoration(hintText: "correo"),
              validator: (String? value) {

                if(value!.isEmpty){
                  return "el campo es obligatorio";
                }

                if(value.length < 6){
                  return "debe de ser mas de 4 caracteres";
                }

                return null;
              },
            ),
            const SizedBox(
              height: 6.0,
            ),
            TextFormField(
              controller: _codigoController,
              maxLines: 2,
              decoration: InputDecoration(hintText: "codigo"),
              validator: (String? value) {

                if(value!.isEmpty){
                  return "el campo es obligatorio";
                }

                return null;
              },
            ),
            const SizedBox(
              height: 6.0,
            ),
            Row(
              children: [
                const Text("Estado: "),
                const SizedBox(
                  width: 6.0,
                ),
                Checkbox(
                  value: isFinished,
                  onChanged: (value) {
                    isFinished = value!;
                    setState(() {});
                  },
                ),
              ],
            ),
            SizedBox(
              width: 10.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Cancelar",
                  ),
                ),
                SizedBox(
                  width: 10.0,
                ),
                ElevatedButton(
                  onPressed: () {
                   addTask();

                  },
                  child: Text(
                    "Aceptar",
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
