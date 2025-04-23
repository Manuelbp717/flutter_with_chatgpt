import 'package:app_with_chatgpt_manuelbaas/constants/constants.dart';
import 'package:app_with_chatgpt_manuelbaas/widgets/drop_down.dart';
import 'package:app_with_chatgpt_manuelbaas/widgets/text_widget.dart';
import 'package:flutter/material.dart';

//Creamos una clase llamada Services
class Services {
  static Future<void> showModalSheet({required BuildContext context}) async {
    await showModalBottomSheet(

        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        backgroundColor: scaffoldBackgroundColor,
        context: context,
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.all(18.0),
            child: Row(
              //Mandamos cada a elemento a un lado del row
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Flexible(
                  //Importamos el textWidget para que de formato al texto
                  child: TextWidget(
                    label: "Chosen Model:",
                    fontSize: 16,
                  ),
                ),
                Flexible(
                  flex: 2,
                  child: ModelsDropDownWidget()),
              ],
            ),
          );
        });
  }
}