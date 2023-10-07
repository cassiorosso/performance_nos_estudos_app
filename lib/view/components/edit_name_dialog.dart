import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../controllers/revisoes_controller.dart';

class DialogEditName extends StatefulWidget {
  final int conteudoId;
  const DialogEditName({super.key, required this.conteudoId});

  @override
  State<DialogEditName> createState() => _DialogEditNameState();
}

class _DialogEditNameState extends State<DialogEditName> {
  final revisoesController = GetIt.I<RevisoesController>();
  String text = "";
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Row(
        children: [
          Padding(
            padding: EdgeInsets.only(right:8.0),
            child: Icon(Icons.menu_book_rounded),
          ),
          Flexible(
            child: Text(
              "Editar nome do conteúdo",
              style: TextStyle(fontSize: 15),
              textAlign: TextAlign.left,
            ),
          ),
        ],
      ),
      content: TextField(
        decoration: const InputDecoration(
          border: OutlineInputBorder()
        ),
        maxLength: 35,
        onChanged: (value) {
          setState(() {
            text = value;
          });
        },
      ),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      actions: [
        Padding(
          padding: const EdgeInsets.all(5),
          child: ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue[800]),
              child:
                  const Text("Cancelar", style: TextStyle(color: Colors.white))),
        ),
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: ElevatedButton(
              onPressed: text.isEmpty
                  ? null
                  : () {
                      revisoesController.editConteudoName(name: text, conteudoId: widget.conteudoId);
                      Navigator.pop(context);
                    },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue[800]),
              child: const Text(
                "Confirmar",
                style: TextStyle(color: Colors.white),
              )),
        )
      ],
    );
  }
}
