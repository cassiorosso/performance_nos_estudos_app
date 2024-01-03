import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../controllers/dashboard_controller.dart';
import '../../controllers/revisoes_controller.dart';

class ErrorCustomWidget extends StatelessWidget {
  final String errorMessage;
  final int indexButton;
  final revisoesController = GetIt.I<RevisoesController>();
  final _dashboardController = GetIt.I<DashboardController>();
  ErrorCustomWidget(
      {super.key, required this.errorMessage, required this.indexButton});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Image.asset(
                'assets/images/error2.png',
                scale: 4,
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(15),
              child: Text(
                "Ops.. parece que houve um erro ao carregar os dados",
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18),
              ),
            ),
            Text(
              errorMessage,
              style: const TextStyle(fontStyle: FontStyle.italic),
            ),
            const SizedBox(
              height: 20,
            ),
            IconButton(
                padding: const EdgeInsets.all(10),
                onPressed: () {
                  switch (indexButton) {
                    case 0:
                      revisoesController.listRevisoes();
                      break;
                    case 1:
                      _dashboardController.getConteudos();
                      break;
                    default:
                      break;
                  }
                },
                icon: const Icon(Icons.refresh_rounded)),
            const Text(
              'Recarregar',
            ),
          ],
        ),
      ),
    );
  }
}
