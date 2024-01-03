import 'package:flutter/material.dart';

class GuiaEstudosPage extends StatelessWidget {
  const GuiaEstudosPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextStyle title = TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 24,
        fontStyle: FontStyle.italic,
        color: Colors.blue[700]);
    TextStyle seconsTitle =
        const TextStyle(fontWeight: FontWeight.bold, fontSize: 20);
    const textStyle = TextStyle(fontSize: 18);
    Widget divider = Container(
      padding: const EdgeInsets.only(top: 6, bottom: 6),
      height: 3,
      width: double.infinity,
      color: Colors.blue[800],
    );
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 25, bottom: 20, left: 30, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Planilha revisão cíclica individual", style: title),
            divider,
            const Text(
              "\n A planilha de revisões cíclicas da Performance nos estudos para vestibulares e ENEM tem como objetivos principais: aprimorar a preparação dos estudantes, proporcionar organização eficiente e personalizada, incentivar a revisão por meio de questões, otimizar a produtividade e aprendizado em cada matéria, promover a identificação de áreas de melhoria e oferecer um método de estudo adaptado ao desempenho individual. Com formatação condicional, destaca-se o progresso das revisões em andamento, a conclusão com alto aproveitamento e a fase intermediária para o desenvolvimento contínuo.\n\n",
              style: textStyle,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset("assets/images/guia1.png"),
            ),
            Text("O Básico", style: title),
            divider,
            const Text(
              "\nA preparação para vestibulares e o Exame Nacional do Ensino Médio (ENEM) é um momento crucial na vida dos estudantes, representando uma etapa determinante para ingressar em instituições de ensino superior. Nesse contexto, uma organização eficiente e personalizada para revisões cíclicas desempenha um papel fundamental no aprimoramento do desempenho acadêmico e na conquista dos objetivos almejados. A planilha de revisões cíclicas surge como uma ferramenta indispensável para auxiliar estudantes nessa jornada desafiadora. Por meio dessa planilha, é possível estabelecer um método estruturado de estudo, que se adapta ao progresso individual de cada aluno, maximizando a produtividade e o aprendizado, dando atenção a suas matérias mais deficitárias. O ponto central para uma revisão eficaz reside na abordagem por questões, um dos métodos mais recomendados por especialistas em educação. A prática constante de exercícios permite a fixação dos conteúdos, o aprimoramento das habilidades de resolução e a identificação das áreas que necessitam de maior atenção. Ademais, esse enfoque propicia ao estudante o desenvolvimento de uma abordagem analítica e crítica, características cruciais para obter sucesso nos exames de vestibulares e no ENEM. Ao dividir a preparação em três fases distintas, conforme o percentual de acerto em cada matéria, a planilha possibilita uma abordagem individualizada para o estudo. A Fase 1, dedicada a conteúdos com baixo aproveitamento, estimula a revisão de toda a teoria, a síntese dos conceitos e a resolução de questões. Na Fase 2, em que o aluno já demonstra maior domínio, ocorre o início do estudo cíclico, com revisões periódicas para aperfeiçoamento contínuo. Por fim, a Fase 3, alcançada quando a matéria é dominada, prioriza o treino intenso por meio de questões e correções, contribuindo para a consolidação do conhecimento",
              style: textStyle,
            ),
            Text(
              "\nFase 1 de Estudos\n",
              style: seconsTitle,
            ),
            const Text(
              "A Fase 1 de estudos é o primeiro passo na preparação para vestibulares e ENEM. Nesta etapa, o foco está na compreensão e assimilação dos conteúdos, especialmente aqueles em que o desempenho inicial é baixo, entre 0% a 50% de acerto.\n\nDiagnóstico Inicial:\n\n• Identifique as matérias em que seu aproveitamento está abaixo de 50%.\n• Faça uma análise honesta de suas dificuldades e áreas de desconhecimento.\n\nEstudo Teórico:\n\n• Dedique-se ao estudo completo da teoria das matérias identificadas.\n• Utilize materiais de referência, livros, apostilas e recursos confiáveis.\n\nResumos e Anotações:\n\n• Faça resumos sintéticos dos principais tópicos de cada matéria.\n• Realize anotações para destacar pontos cruciais e tirar dúvidas.\n• Utilize papel e caneta, isso é efetivo.\n• Use a estratégia que preferir, flash cards, resumos e etc\n\nExercícios Práticos:\n\n• Resolva questões básicas relacionadas aos temas estudados.\n• Pratique a aplicação dos conceitos aprendidos para fixar o conhecimento.\n• Coloque um número mínimo de questões para ser realizado e não as chute. Seja\n• honesto consigo mesmo.\n\nRevisões Periódicas:\n\n• Coloque na tabela seu % de acerto e a siga de acordo com as datas.\n• Priorize a revisão de matérias em que ainda há dificuldades.\n\nAutoavaliação:\n\n• Avalie periodicamente seu progresso nessa fase inicial, utilizando a planilha.\n• Reconheça suas conquistas e identifique áreas que ainda precisam ser reforçadas.\nLembrando que a Fase 1 é fundamental para construir uma base sólida de conhecimento e preparar o terreno para as próximas etapas do estudo. Ao dominar os conteúdos, você estará pronto para avançar para a Fase 2, onde a prática de questões e revisões cíclicas desempenharão um papel crucial na melhoria contínua do seu desempenho acadêmico.",
              style: textStyle,
            ),
            Text(
              "\nFase 2 de Estudos\n",
              style: seconsTitle,
            ),
            const Text("A Fase 2 de estudos é uma etapa de aprendizado progressivo, voltada para matérias em que o aproveitamento está entre 50% a 80% de acerto. Neste estágio, o objetivo é consolidar o conhecimento adquirido na Fase 1 e aprimorar a resolução de questões, corrigindo erros e desenvolvendo uma abordagem analítica.\n\nPrática Intensiva de Questões:\n\n• Foque na resolução de questões relacionadas aos conteúdos estudados na Fase 1.\n• Identifique os erros cometidos e busque compreender o raciocínio por trás das respostas corretas.\n\nCorreção e Análise de Desempenho:\n\n• Analise suas respostas e verifique as razões dos acertos e erros.\n• Identifique padrões de erros recorrentes e defina estratégias para evitá-los.\n\nVolte ao Material de Referência:\n\n• Sempre que surgirem dúvidas, retorne ao material de estudo e revise a teoria.\n• Reforce os conceitos essenciais e esclareça pontos de dificuldade.\n\nEstudo Cíclico e Revisões Programadas:\n\n• Utilize a planilha de revisões para acompanhar as datas e o progresso de cadamatéria.\n\nFoco na Consistência:\n\n• Mantenha uma rotina de estudos constante e disciplinada.\n• Estabeleça metas realistas e atinja-as gradualmente.\n\nAutoavaliação e Celebração das Conquistas:\n\n• Avalie seu avanço regularmente e reconheça o progresso alcançado.\n• Celebre suas conquistas e motive-se para continuar empenhado nos estudos." ,style: textStyle,),
            Text(
              "\nFase 3 de Estudos: a sua APROVAÇÃO\n",
              style: seconsTitle,
            ),
            const Text(
              "A Fase 3 de estudos é o estágio avançado da preparação para vestibulares e ENEM, destinada às matérias em que o aproveitamento está acima de 80% de acerto. Neste momento, o foco é aprofundar o conhecimento e a confiança, visando o domínio completo dos conteúdos paraalcançar alto desempenho nas provas.\n\nTreino Intenso por Questões:\n\n• Pratique questões desafiadoras e diversificadas em cada matéria.\n• Busque fontes de exercícios mais complexos e alinhados com os vestibulares e ENEM. Individualize seu estudo.\n\nAnálise Aprofundada de Desempenho:\n\n• Analise minuciosamente as respostas das questões e as estratégias utilizadas.\n• Identifique pontos de melhoria e explore abordagens mais eficientes.\n\nResumos Rápidos e Objetivos:\n\n• Utilize-os como ferramenta de consulta rápida antes das provas ou em dúvidas durante suas baterias de estudo.\n\nEnfoque em Matérias Específicas:\n\n• Individualize o estudo para cada matéria de acordo com sua natureza.\n• Exemplo: Priorize a prática intensa de questões em Matemática, enquanto em História, enfoque na leitura de resumos e questões.\n\nRevisões Personalizadas:\n\n• Siga a planilha e não desanime de seu objetivo, ele está próximo.\n\nConsolidação do Conhecimento:\n\n• Busque consolidar os conceitos aprendidos, evitando novas teorias de última hora.\n• Fortaleça sua confiança na resolução de questões e tomada de decisões em provas.\n\nSimulados e Provas Anteriores:\n\n• Realize simulados e provas anteriores para familiarizar-se com o estilo das avaliações. Analise os resultados para identificar pontos de destaque e possíveis ajustes.\nEssa fase é essencial para garantir o domínio completo dos conteúdos e o aprimoramentodas habilidades de resolução de questões. Através de uma abordagem focada epersonalizada, o estudante estará preparado para enfrentar os desafios das provas comconfiança e obter sucesso nos vestibulares e ENEM. É importante lembrar que a dedicação ea constância nos estudos são fundamentais para alcançar resultados sólidos e atingir seusobjetivos acadêmicos.",
              style: textStyle,
            ),
          ],
        ),
      ),
    );
  }
}
