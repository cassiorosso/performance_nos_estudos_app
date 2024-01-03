import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

import '../stores/user_store.dart';

class InicialPage extends StatelessWidget {
  InicialPage({super.key});
  final userStore = GetIt.I<UsuarioStore>();
  final _controller = YoutubePlayerController.fromVideoId(
    videoId: 'C3aRyxcpy5A',
    autoPlay: false,
    params: const YoutubePlayerParams(showFullscreenButton: true),
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(
          height: 35,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10, left: 20),
          child: Text(
            "Bem vindo a plataforma Performance nos estudos, ${userStore.user.nome}!",
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontWeight: FontWeight.w600, fontSize: 20),
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        const Text(
          "Confira o tutorial abaixo de como usar a plataforma.",
          textAlign: TextAlign.left,
          style: TextStyle(fontSize: 14),
        ),
        const SizedBox(
          height: 10,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: YoutubePlayer(
              controller: _controller,
              //aspectRatio: 4 / 3,
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
