import 'package:flutter/material.dart';

// teste1
void main() {
  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class NomeAmigo extends StatelessWidget {
  final String nome;
  final Color cor;
  NomeAmigo(this.nome, this.cor);
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: DecoratedBox(
            decoration: BoxDecoration(color: cor),
            child: Text(nome,
                style: TextStyle(
                  fontSize: 32,
                ))));
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meus Amigos'),
      ),
      body: Center(
          child: Column(
        children: <Widget>[
          NomeAmigo('Alan', Colors.red),
          NomeAmigo('Paulo', Colors.yellow),
          NomeAmigo('Carlos', Colors.green),
          NomeAmigo('Pedro', Colors.blue),
        ],
      )),
    );
  }
}
