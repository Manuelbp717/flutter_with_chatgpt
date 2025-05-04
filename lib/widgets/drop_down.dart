import 'package:app_with_chatgpt_manuelbaas/constants/constants.dart';
import 'package:app_with_chatgpt_manuelbaas/models/models_model.dart';
import 'package:app_with_chatgpt_manuelbaas/providers/models_provider.dart';
import 'package:app_with_chatgpt_manuelbaas/services/api_services.dart';
import 'package:app_with_chatgpt_manuelbaas/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//Esta pagina es para dar una lista de los modelos que pueden ser utilizados en la aplicaciones
class ModelsDropDownWidget extends StatefulWidget {
  const ModelsDropDownWidget({super.key});

  @override
  State<ModelsDropDownWidget> createState() => _ModelsDropDownWidgetState();
}

class _ModelsDropDownWidgetState extends State<ModelsDropDownWidget> {
  //Valor de modelo, un string con el texto Modelo 1
  //Se cambio al modelo que se uso en postman
  String currentModel = "gpt-4.1";

  @override
  Widget build(BuildContext context) {
    final modelsProvider = Provider.of<ModelsProvider>(context, listen: false);
    currentModel = modelsProvider.getCurrentModel;

    //Un tipo de boton tipo select que despliega hacia abajo las opciones
    return FutureBuilder<List<ModelsModel>>(
      future: modelsProvider.getAllModels(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: TextWidget(label: snapshot.error.toString()));
        }
        return snapshot.data == null || snapshot.data!.isEmpty
            ? const SizedBox.shrink()
            : DropdownButton(
              dropdownColor: scaffoldBackgroundColor,
              iconEnabledColor: Colors.white,
              items: List<DropdownMenuItem<String>>.generate(
              //Generalos la lista de metodo DropDownMenu con el largo de la lista y sus elementos
              snapshot.data!.length,
              (index) => DropdownMenuItem(
              value: snapshot.data![index].id,
              child: TextWidget(
                label: snapshot.data![index].id,
                fontSize: 15,
              )
              )
              ),
              value: currentModel,
              onChanged: (value) {
                setState(() {
                  currentModel = value.toString();
                });
                modelsProvider.setCurrentModel(value.toString(),);
              },
            );
      },
    );
  }
}
