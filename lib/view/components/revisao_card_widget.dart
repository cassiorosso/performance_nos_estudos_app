import 'package:flutter/material.dart';

class RevisaoCardWidget extends StatelessWidget {
  const RevisaoCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return  const Card(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 3,
              child: Text("Matéria aibiologica")),
            Expanded(
              flex: 3,
              child: Text("25/08/2023", textAlign: TextAlign.center)),
            Expanded(
              flex: 2,
              child: Text("45%", textAlign: TextAlign.center)),
            Expanded(
              flex: 3,
              child: Text("11/09/2023", textAlign: TextAlign.center)),
            Expanded(
              flex: 1,
              child: Align(
                alignment: Alignment.centerRight,
                child: Icon(Icons.check_circle_outline_outlined))),
            Expanded(
              flex: 1,
              child: Align(
                alignment: Alignment.centerRight,
                child: Icon(Icons.delete)))
          ],
        ),
      ),
    );
  }
}
