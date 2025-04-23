import 'package:app_with_chatgpt_manuelbaas/constants/constants.dart';
import 'package:app_with_chatgpt_manuelbaas/services/assets_manage.dart';
import 'package:app_with_chatgpt_manuelbaas/services/services.dart';
import 'package:app_with_chatgpt_manuelbaas/widgets/chat_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  //Variables
  final bool _isTyping = true;
  final String firstMessage = "Cómo puedo ayudarte??";

  //Controles de texto, scroll y enfoque
  late TextEditingController textEditingController;
  late ScrollController _listScrollController;
  late FocusNode focusNode;

  //Funcion de inicio
  @override
  void initState() {
    _listScrollController = ScrollController();
    textEditingController = TextEditingController();
    focusNode = FocusNode();
    super.initState();
  }

  //Funcion de dispose
  @override
  void dispose() {
    _listScrollController.dispose();
    textEditingController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      //Aqui hacemos la appBar, con el logo de chatGPt a la izquierda
       appBar: AppBar(
        elevation: 2,
        leading: Padding(
          //Damos el tamaño y hacemos el asset para llamar a la imagen de la página constanst.dart
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(AssetsManager.openaiLogo),
        ),
        //Es el texto que va en medio de la barra
        title: const Text("ChatGPT"),
        //Es un boton que va a la derecha, de la barra
        actions: [
          IconButton(
            onPressed: () async {
              await Services.showModalSheet(context: context);
            },
            icon: const Icon(Icons.more_vert_rounded, color: Colors.white),
          ),
        ],
        ),
        //Este es el cuerpo de la pagina main
      body: SafeArea(
        child: Column(
          children: [
            //Hicimos el warp en flexible
            Flexible(
              child: ListView.builder(
                itemCount: 6,
                itemBuilder: (context,index){
                  return ChatWidget(
                      msg: chatMessages[index]["msg"].toString(), // chatList[index].msg,
                      chatIndex: int.parse(
                        chatMessages[index]["chatIndex"].toString()),//chatList[index].chatIndex,
                    );
                }
              ),
            ),
            //Esta muestra una paqueña barrita de carga al final de nuestra app
            //Simulando que Chat esta pensando
            if (_isTyping) ...[
              const SpinKitThreeBounce(
                color: Colors.white,
                size: 18,
              ),
              //Tamaño del espacio entre la animacion y el cuadro de texto 
              const SizedBox(
              height: 15,
              ),
              //Ponemos todo en un widget material para agregarle elementos visuales
              Material(
                color: cardColor,
                child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                      style: const TextStyle(color: Colors.white),
                      controller: textEditingController,
                      onSubmitted: (value){
                        //Envia el mensaje
                      },
                      //Aqui va el mensaje que visualizamos al inicio
                      decoration: InputDecoration.collapsed(
                        hintText: firstMessage,
                        hintStyle: TextStyle(color: Colors.grey)),
                      ),
                    ),
                    IconButton(
                        onPressed: () async {},
                        icon: const Icon(
                          Icons.send,
                          color: Colors.white,
                        ))
                  ],
                ),
              ),
              )
            ], 
          ],
        )
        )
    );
  }
}