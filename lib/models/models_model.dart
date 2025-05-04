//Es la clase modelsModel
class ModelsModel {

  //Nuestras variables para conectar al modelo
  final String id;
  final int created;
  final String root;

  ModelsModel({
    required this.id,
    required this.root,
    required this.created,
  });

  //Constructor del modelo
  factory ModelsModel.fromJson(Map<String, dynamic> json) => ModelsModel(
        id: json["id"],
        root: json["root"],
        created: json["created"],
      );

  //Lista para decodificar json y ponerlo en una lista modelsnapshot, para hacer la solicitud de post como lo hariamos en postman
  static List<ModelsModel> modelsFromSnapshot(List modelSnapshot) {
    return modelSnapshot.map((data) => ModelsModel.fromJson(data)).toList();
  }
}