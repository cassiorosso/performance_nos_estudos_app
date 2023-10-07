import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';

import '../../controllers/revisoes_controller.dart';

class DialogEditAcerto extends StatefulWidget {
  final int revisaoId;
  const DialogEditAcerto({super.key, required this.revisaoId});

  @override
  State<DialogEditAcerto> createState() => _DialogEditAcertoState();
}

class _DialogEditAcertoState extends State<DialogEditAcerto> {
  final revisoesController = GetIt.I<RevisoesController>();
  String text = "";
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Row(
        children: [
          Padding(
            padding: EdgeInsets.only(right:8.0),
            child: Icon(Icons.percent_rounded,),
          ),
          Flexible(
            child: Text(
              "Editar porcentagem de acerto de questões",
              style: TextStyle(fontSize: 15),
              textAlign: TextAlign.left,
            ),
          ),
        ],
      ),
      content: Row(
        children: [
          const Expanded(child: SizedBox()),
          SizedBox(
            width: 80,
            child: TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                suffix: Text("%"),isDense: true, 
              ),
              maxLength: 5,
              inputFormatters: [FilteringTextInputFormatter.allow((RegExp("[.0-9]")))],
              onChanged: (value) {
                setState(() {
                  if (double.parse(value) > 100 || double.parse(value) < 1) {
                    text = "";
                  } else{
                  text = value;
                  }
                });
              },
            ),
          ),
          const Expanded(child: SizedBox()),
        ],
      ),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      actions: [
        Padding(
          padding: const EdgeInsets.all(5.0),
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
                      int acerto = double.parse(text).round();
                      revisoesController.editAcertoRevisao(
                          acerto: acerto, revisaoId: widget.revisaoId);
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
