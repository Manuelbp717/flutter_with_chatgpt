import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:app_with_chatgpt_manuelbaas/constants/api_consts.dart';
import 'package:app_with_chatgpt_manuelbaas/models/chat_model.dart';
import 'package:app_with_chatgpt_manuelbaas/models/models_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static Future<List<ModelsModel>> getModels() async {
    try {
      //Aqui se hace la conección a la API de OpenIA
      //Usamos el await para que se espera a que se haga una llamada para activar el post
      var response = await http.get(
        Uri.parse("$BASE_URL/models"),
        headers: {'Authorization': 'Bearer $API_KEY'},
      );

      //Toma la respuesta del json
      Map jsonResponse = jsonDecode(response.body);

      //Si la respuesta da error se manda  nada
      if (jsonResponse['error'] != null) {
        // print("jsonResponse['error'] ${jsonResponse['error']["message"]}");
        throw HttpException(jsonResponse['error']["message"]);
      }
      //Recibimos la lista y la recorremos
      List temp = [];
      for (var value in jsonResponse["data"]) {
        temp.add(value);
        //Imprimimos el Id para ver cual es el error y que no nos aparezca todo en consola
        // log("temp ${value["id"]}");
      }
      //Se la pasamos al snapshot
      return ModelsModel.modelsFromSnapshot(temp);
      //Mensaje de error por si no conecta
    } catch (error) {
      log("error $error");
      //Sirve para relanzar
      rethrow;
    }
  }

  // Enviamos el mensaje usando la API de ChatGPT
  static Future<List<ChatModel>> sendMessageGPT(
    //Se va a necesitar el mensaje y le modelo a quien le preguntamos
      {required String message, required String modelId}) async {
    try {
      log("modelId $modelId");
      var response = await http.post(
        //Llamamos la URL base y le agregamos para que salga como le postman
        Uri.parse("$BASE_URL/chat/completions"),
        headers: {
          'Authorization': 'Bearer $API_KEY',
          "Content-Type": "application/json"
        },
        //eL body es como generalmente hicimos en el postman
        body: jsonEncode(
          {
            "model": modelId,
            "messages": [
              {
                "role": "user",
                "content": message,
              }
            ]
          },
        ),
      );

      // Usamos map para encontrar la funcion que queremos
      Map jsonResponse = json.decode(utf8.decode(response.bodyBytes));

      //Este el mensaje por si la solicutud da error, porque le URL esta mal o algo asi
      if (jsonResponse['error'] != null) {
        // print("jsonResponse['error'] ${jsonResponse['error']["message"]}");
        throw HttpException(jsonResponse['error']["message"]);
      }
      //En el Json las respuesta esta dentro de choices, por eso vamos a revisar en busca de la linea
      List<ChatModel> chatList = [];
      if (jsonResponse["choices"].length > 0) {
        // log("jsonResponse[choices]text ${jsonResponse["choices"][0]["text"]}");
        chatList = List.generate(
          jsonResponse["choices"].length,
          (index) => ChatModel(
            //content>message>choises es la dirección de la respuesta
            //y le damos el index 1 para que sepa que el modelo quiene escribe
            msg: jsonResponse["choices"][index]["message"]["content"],
            chatIndex: 1,
          ),
        );
      }
      //Regresamos la lista
      return chatList;
    } catch (error) {
      log("error $error");
      rethrow;
    }
  }

  // Send Message fct
  static Future<List<ChatModel>> sendMessage(
      {required String message, required String modelId}) async {
    try {
      log("modelId $modelId");
      var response = await http.post(
        Uri.parse("$BASE_URL/chat/completions"),
        headers: {
          'Authorization': 'Bearer $API_KEY',
          "Content-Type": "application/json"
        },
        body: jsonEncode(
          {
            "model": modelId,
            "messages": [
              {
                "role": "user",
                "content": message,
              }
            ]
          },
        ),
      );

      // Map jsonResponse = jsonDecode(response.body);
      Map jsonResponse = json.decode(utf8.decode(response.bodyBytes));
      if (jsonResponse['error'] != null) {
        // print("jsonResponse['error'] ${jsonResponse['error']["message"]}");
        throw HttpException(jsonResponse['error']["message"]);
      }
      List<ChatModel> chatList = [];
      if (jsonResponse["choices"].length > 0) {
        // log("jsonResponse[choices]text ${jsonResponse["choices"][0]["text"]}");
        chatList = List.generate(
          jsonResponse["choices"].length,
          (index) => ChatModel(
            msg: jsonResponse["choices"][index]["text"],
            chatIndex: 1,
          ),
        );
      }
      return chatList;
    } catch (error) {
      log("error $error");
      rethrow;
    }
  }
}