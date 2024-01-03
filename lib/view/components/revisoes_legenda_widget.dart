import 'package:flutter/material.dart';

class RevisoesLegenda extends StatelessWidget {
  const RevisoesLegenda({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(flex: 3, child: Tooltip(message: "Nessa coluna está o nome de todos os conteúdos que serão revisados",child: Text("Matéria"))),
          Expanded(flex: 3, child: Tooltip(message: "Nessa coluna está a data da última revisão feita deste conteúdo" ,child: Text("Data última\nrevisão", textAlign: TextAlign.center,))),
          Expanded(flex: 3, child: Tooltip(message: "Nessa coluna está a porcentagem de acerto da última revisão feita. Baseado no desempenho de acertos dessa última revisão é calculada a data para realizar uma nova revisão deste conteúdo.",child: Text("Acerto (%)",textAlign: TextAlign.center))),
          Expanded(flex: 4, child: Tooltip(message: "Nessa coluna está a data mais recomendada para a realização de uma nova revisão,\nquando esta for concluída, o botão de ''Concluir Revisão'' deve ser acionado para o periodização de uma nova revisão.",child: Text("Data Próxima\nrevisão", textAlign: TextAlign.center))),
        ],
      ),
    );
  }
}
