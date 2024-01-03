import 'package:flutter/material.dart';

import 'novo_conteudo_dialog.dart';

class NewButtonWidget extends StatelessWidget {
  const NewButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue[800],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
        ),
        onPressed: () => showDialog(
            context: context, builder: (context) => const NovoConteudoDialog()),
        child: const Padding(
          padding: EdgeInsets.all(12),
          child: Text(
            "Adicionar novo conteúdo",
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
      ),
    );
  }
}
