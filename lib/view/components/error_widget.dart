import 'package:flutter/material.dart';

class ErrorCustomWidget extends StatelessWidget {
  final String errorMessage;
  const ErrorCustomWidget({super.key, required this.errorMessage});

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
              child: Image.asset('assets/images/error2.png', scale: 4,),
            ),
            const Padding(
              padding: EdgeInsets.all(15),
              child: Text("Ops.. parece que houve um erro ao carregar os dados" ,style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18),),
            ),
            Text(errorMessage, style: const TextStyle(fontStyle: FontStyle.italic),)
          ],
        ),
      ),
    );
  }
}
