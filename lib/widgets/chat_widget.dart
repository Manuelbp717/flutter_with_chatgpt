import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:app_with_chatgpt_manuelbaas/constants/constants.dart';
import 'package:app_with_chatgpt_manuelbaas/services/assets_manage.dart';
import 'package:app_with_chatgpt_manuelbaas/widgets/text_widget.dart';
import 'package:flutter/material.dart';


class ChatWidget extends StatelessWidget {
  const ChatWidget(
      {super.key,
      required this.msg,
      required this.chatIndex,
      this.shouldAnimate = false});

  //Variables que usamos
  final String msg;
  final int chatIndex;
  final bool shouldAnimate;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Material(
          //EL color depende de su es usuario o no
          color: chatIndex == 0 ? scaffoldBackgroundColor : cardColor,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              //Alineamos la imagen y texto al principio del row
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //En una linea vamos a tener la imagen del bot y en otra la imagen del usuario, dependiendo de quien hable
                Image.asset(
                  chatIndex == 0
                      ? AssetsManager.userImage
                      : AssetsManager.botImage,
                  //Rezise de la imagen para que no rompa la pantalla
                  height: 30,
                  width: 30,
                ),
                //Espacio entre mensaje y mensaje
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: chatIndex == 0
                  //Llamamos a textwidget para que tengo formato establecido
                      ? TextWidget(
                          label: msg,
                        )
                        //Parte de la animacion de scroll y visualización del texto
                      : shouldAnimate
                          ? DefaultTextStyle(
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16),
                              child: AnimatedTextKit(
                                  isRepeatingAnimation: false,
                                  repeatForever: false,
                                  displayFullTextOnTap: true,
                                  totalRepeatCount: 1,
                                  animatedTexts: [
                                    TyperAnimatedText(
                                      msg.trim(),
                                    ),
                                  ]),
                            )
                          : Text(
                              msg.trim(),
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16),
                            ),
                ),
                //Aqui agreramos los botones de like y dislike solo su el index es 0, es decir, si quien habla es ChatGPT
                chatIndex == 0
                    ? const SizedBox.shrink()
                    //Los botones se alinean a la derecha del cuadro de texto de chat
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Icon(
                            Icons.thumb_up_alt_outlined,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Icon(
                            Icons.thumb_down_alt_outlined,
                            color: Colors.white,
                          )
                        ],
                      ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}