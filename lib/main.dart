import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: const TelaPrincipal(),
    initialRoute: "/principal",
    routes: {
      "/principal": (context) => const TelaPrincipal(),
      "/resultado": (context) => const TelaResultado()
    },
  ));
}

class Argumentos {
  String modelo = '';
  double distancia = 0.0;
  double potencia = 0.0;
  double gasolina = 0.0;
  double valorGasto = 0.0;
  Argumentos(this.modelo, this.distancia, this.potencia, this.gasolina,
      this.valorGasto);
}

class TelaResultado extends StatelessWidget {
  const TelaResultado({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // extraindo valores enviados na TelaPrincipal:
    final args = ModalRoute.of(context)?.settings.arguments as Argumentos;
    String modelo = args.modelo;
    double distancia = args.distancia;
    double potencia = args.potencia;
    double gasolina = args.gasolina;
    double valorGasto = args.valorGasto;
    return Scaffold(
      appBar: AppBar(
        title: const Text('RESULTADO'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            '$modelo $potencia gasta R\$ $valorGasto para percorrer $distancia km com gasolina a R\$ $gasolina por litro',
            style: const TextStyle(fontSize: 20, color: Colors.blueAccent),
          )
        ],
      ),
    );
  }
}

class TelaPrincipal extends StatefulWidget {
  const TelaPrincipal({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CalcularResultados();
  }
}

class _CalcularResultados extends State<TelaPrincipal> {
  final _form = GlobalKey<FormState>();
  String modelo = '';
  double distancia = 0.0;
  double potencia = 0.0;
  double gasolina = 0.0;
  double valorGasto = 0.0;

  void _mudarEstado() {
    setState(() {
      if (potencia <= 1.0) {
        valorGasto = (distancia / 13.0) * gasolina;
      } else if (potencia > 1.0 && potencia <= 1.4) {
        valorGasto = (distancia / 11.0) * gasolina;
      } else if (potencia > 1.4 && potencia <= 1.9) {
        valorGasto = (distancia / 9.50) * gasolina;
      } else if (potencia > 1.9) {
        valorGasto = (distancia / 7.75) * gasolina;
      }
      Navigator.pushNamed(context, "/resultado",
          arguments:
              Argumentos(modelo, distancia, potencia, gasolina, valorGasto));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('GASAPP'),
        ),
        body: Form(
            key: _form,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text('Modelo do automóvel'),
                TextFormField(
                  decoration:
                      const InputDecoration(hintText: 'Modelo do automóvel'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Erro! O modelo deve ser informado";
                    } else {
                      modelo = value;
                      return null;
                    }
                  },
                ),
                const Text('Distância (km)'),
                TextFormField(
                  decoration: const InputDecoration(hintText: 'Distância'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Erro! A distância deve ser informada";
                    } else {
                      distancia = double.parse(value);
                      return null;
                    }
                  },
                ),
                const Text('Potência do motor'),
                TextFormField(
                  decoration:
                      const InputDecoration(hintText: 'Potência do motor'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Erro! A potência deve ser informada";
                    } else {
                      potencia = double.parse(value);
                      return null;
                    }
                  },
                ),
                const Text('Valor do litro da gasolina'),
                TextFormField(
                  decoration:
                      const InputDecoration(hintText: 'Valor da gasolina'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Erro! O valor da gasolina deve ser informado";
                    } else {
                      gasolina = double.parse(value);
                      return null;
                    }
                  },
                ),
                ElevatedButton(
										child: const Icon(Icons.share),
                    onPressed: () {
                      if (_form.currentState!.validate()) {
                        _mudarEstado();
                      }
                    },
                    child: const Text('CALCULAR'))
              ],
            )));
  }
}