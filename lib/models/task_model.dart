class TaskModel {
  int? id;
  String nombre;
  String apellidos;
  String correo;
  String codigo;

  TaskModel({
     this.id,
    required this.nombre,
    required this.apellidos,
    required this.correo,
    required this.codigo,
  });

  factory TaskModel.deMapaModel(Map<String, dynamic> mapa) => TaskModel(
        id: mapa["id"],
        nombre: mapa["nombre"],
        apellidos: mapa["apellidos"],
        correo: mapa["correo"],
        codigo: mapa["codigo"],
      );
}
