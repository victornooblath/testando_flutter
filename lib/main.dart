import 'package:flutter/material.dart';

// teste1
void main() {
  runApp(const MaterialApp(home: TelaConta()));
}

class TelaConta extends StatefulWidget {
  const TelaConta({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CalContaEstado();
  }
}

class _CalContaEstado extends State<TelaConta> {
  final _formCalc = GlobalKey<FormState>();
  double _valor = 0.0;
  double _valorPorc = 0.0;
  var _valorTotal;

  void _calcTotal() {
    setState(() {
      _valorTotal = _valor * (100 + _valorPorc) / 100;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Conta'),
      ),
      body: Form(
        key: _formCalc,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                  decoration: const InputDecoration(hintText: 'Valor da conta'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'erro! informe um valor';
                    } else {
                      _valor = double.parse(value);
                      if (_valor <= 0) {
                        return "erro! o valor tem que ser maior que zero";
                      }
                    }
                    return null;
                  }),
              TextFormField(
                  decoration: const InputDecoration(hintText: 'Valor da % do acrescimo'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'erro! informe um valor';
                    } else {
                      _valorPorc = double.parse(value);
                      if (_valorPorc <= 0) {
                        return "erro! o valor tem que ser maior que zero";
                      }
                    }
                    return null;
                  }),
              ElevatedButton(
                onPressed: () {
                  if (_formCalc.currentState!.validate()) {
                    _calcTotal();
                  }
                },
                child:
                  const Text('Calcular')
              ),
              Text(
                'valor total R\$ $_valorTotal',
                style: const TextStyle(fontSize:20),
              )
            ]),
      ),
    );
  }
}
