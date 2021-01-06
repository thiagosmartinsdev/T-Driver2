import 'package:flutter/material.dart';

class ListaVazia extends StatelessWidget {
  const ListaVazia({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Seja bem vindo ao TDriver!",
                style: TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.bold,
                    fontSize: 26)),
            Padding(
              padding: EdgeInsets.all(20),
            ),
            Text(
              "Parece que você ainda não iniciou o seu controle.",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.bold,
                  fontSize: 26),
            ),
            Padding(
              padding: EdgeInsets.all(10),
            ),
            Text(
              "Vamos começar ?",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.bold,
                  fontSize: 26),
            ),
          ],
        )
      ],
    );
  }
}
