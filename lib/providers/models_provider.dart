import 'package:app_with_chatgpt_manuelbaas/models/models_model.dart';
import 'package:app_with_chatgpt_manuelbaas/services/api_services.dart';
import 'package:flutter/widgets.dart';

//Esta clase es como in 3ro que va a mediar entre la APi y la app
class ModelsProvider with ChangeNotifier {
  // Modelo actual
  String currentModel = "gpt-4.1";

  //Modificamos el modelo elegido
  String get getCurrentModel {
    return currentModel;
  }

  void setCurrentModel(String newModel) {
    currentModel = newModel;
    notifyListeners();
  }

  List<ModelsModel> modelsList = [];

  List<ModelsModel> get getModelsList {
    return modelsList;
  }

  Future<List<ModelsModel>> getAllModels() async {
    modelsList = await ApiService.getModels();
    return modelsList;
  }
}