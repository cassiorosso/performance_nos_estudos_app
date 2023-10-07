import 'package:flutter/material.dart';

import 'novo_conteudo_dialog.dart';

class NewButtonWidget extends StatelessWidget {
  const NewButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: InkWell(
            onTap: ()=> showDialog(context: context, builder: (context)=> const NovoConteudoDialog()),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.05,
              width: MediaQuery.of(context).size.width * 0.1,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.blue,
                      Colors.lightBlue,
                    ]),
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  const Text(""),
                  const Text(
                    "Novo Conteúdo",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                  Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: Colors.white),
                      child: Icon(
                        Icons.add,
                        size: 22.0,
                        color: Colors.blue[800],
                      ))
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}