import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../controllers/revisoes_controller.dart';

class ConfirmationDialog extends StatelessWidget {
  final int conteudoId;
  const ConfirmationDialog({
    super.key,
    required this.conteudoId,
  });

  @override
  Widget build(BuildContext context) {
    final revisoesController = GetIt.I<RevisoesController>();
    return AlertDialog(
      title: const Row(
        children: [
          Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: Icon(Icons.delete),
          ),
          Flexible(
            child: Text(
              "Tem certeza que deseja apagar essa rotina de estudo?\n(Você perderá todo o histórico de acertos e revisões)",
              style: TextStyle(fontSize: 15),
              textAlign: TextAlign.left,
            ),
          ),
        ],
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style:
                  ElevatedButton.styleFrom(backgroundColor: Colors.blue[800]),
              child: const Text("Cancelar",
                  style: TextStyle(color: Colors.white))),
        ),
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: ElevatedButton(
              onPressed: () {
                revisoesController.deleteConteudoRevisao(
                    conteudoId: conteudoId);
                Navigator.pop(context);
              },
              style:
                  ElevatedButton.styleFrom(backgroundColor: Colors.blue[800]),
              child: const Text(
                "Confirmar",
                style: TextStyle(color: Colors.white),
              )),
        )
      ],
    );
  }
}
