import 'package:app_with_chatgpt_manuelbaas/services/assets_manage.dart';
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

  @override
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
                itemCount: 2,
                itemBuilder: (context,index){
                  return Text("Hello text");
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
            ], 
          ],
        )
        )
    );
  }
}