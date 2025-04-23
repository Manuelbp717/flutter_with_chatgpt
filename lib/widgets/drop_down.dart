import 'package:app_with_chatgpt_manuelbaas/constants/constants.dart';
import 'package:flutter/material.dart';

//Esta pagina es para dar una lista de los modelos que pueden ser utilizados en la aplicaciones
class ModelsDropDownWidget extends StatefulWidget {
  const ModelsDropDownWidget({super.key});

  @override
  State<ModelsDropDownWidget> createState() => _ModelsDropDownWidgetState();
}

class _ModelsDropDownWidgetState extends State<ModelsDropDownWidget> {
  //Valor de modelo, un string con el texto Modelo 1
  String currentModel = "Modelo 1";

  @override
  Widget build(BuildContext context) {
    //Un tipo de boton tipo select que despliega hacia abajo las opciones
    return DropdownButton(
      dropdownColor: scaffoldBackgroundColor,
      iconEnabledColor: Colors.white,
      items: getModelsItem,
      value: currentModel, 
      onChanged:(value){
        setState(() {
          currentModel = value.toString();
        });
      },);
  }
}