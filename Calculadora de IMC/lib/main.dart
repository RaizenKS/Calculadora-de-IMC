import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
    debugShowCheckedModeBanner: false,
  ));
}

//A classe home vai gerenciar o estado da nossa aplicação:
//A tela em execução e os valores dos campos
class Home extends StatefulWidget {
//Utilizamos o override para
//sobrescrever o comportamento de criação da nossa aplicação
  @override
  _HomeState createState() => _HomeState();
}

//Esta classe representa a nossa view
//ela extende o Estado da aplicação que criamos anteriormente
class _HomeState extends State<Home> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController pesoController = TextEditingController();
  TextEditingController alturaController = TextEditingController();
  String _resultado = "*****";

  void _reset() {
    pesoController.text = "";
    alturaController.text = "";

    setState(() {
      _resultado = "****";
      _formKey = GlobalKey<FormState>();
    });
  }

  void _calcularImc() {
    setState(() {
      double vlrPeso = double.parse(pesoController.text.replaceAll(',', '.'));
      double vlrAltura =
          double.parse(alturaController.text.replaceAll(',', '.'));

      double resultImc = vlrPeso / (vlrAltura * vlrAltura);

      if (resultImc < 18.5) {
        _resultado = "Abaixo do peso (IMC: ${resultImc.toStringAsFixed(2)})";
      } else if (resultImc >= 18.5 && resultImc < 24.9) {
        _resultado = "Peso normal (IMC: ${resultImc.toStringAsFixed(2)})";
      } else if (resultImc >= 25 && resultImc < 29.9) {
        _resultado = "Sobrepeso (IMC: ${resultImc.toStringAsFixed(2)})";
      } else if (resultImc >= 30 && resultImc < 34.9) {
        _resultado = "Obesidade grau 1 (IMC: ${resultImc.toStringAsFixed(2)})";
      } else if (resultImc >= 35 && resultImc < 39.9) {
        _resultado =
            "Obesidade grau 2 (severa) (IMC: ${resultImc.toStringAsFixed(2)})";
      } else if (resultImc >= 40) {
        _resultado =
            "Obesidade grau 3 (mórbida) (IMC: ${resultImc.toStringAsFixed(2)})";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Calculadora de IMC",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Color(0xfff80000),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.refresh, color: Colors.white),
              onPressed: () {
                _reset();
              })
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Icon(
                Icons.person,
                size: 150.0,
                color: Color(0xfff80000),
              ),
              TextFormField(
                controller: pesoController,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Informe o valor do Peso";
                  }
                  return null;
                },
                decoration: InputDecoration(
                    labelText: "Seu Peso(Kg)",
                    labelStyle: TextStyle(color: Color(0xfff80000))),
                style: TextStyle(color: Color(0xfff80000), fontSize: 26.0),
              ),
              TextFormField(
                controller: alturaController,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Informe o valor da Altura";
                  }
                  return null;
                },
                decoration: InputDecoration(
                    labelText: "Sua Altura(Metro)",
                    labelStyle: TextStyle(color: Color(0xfff80000))),
                style: TextStyle(color: Color(0xfff80000), fontSize: 26.0),
              ),
              Padding(
                  padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                  child: Container(
                      height: 50.0,
                      child: ElevatedButton(
                        child: Text("Calcule",
                            style:
                                TextStyle(color: Colors.white, fontSize: 26.0)),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xfff80000)),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _calcularImc();
                          }
                        },
                      ))),
              Text(_resultado,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Color(0xfff80000), fontSize: 26.0))
            ],
          ),
        ),
      ),
    );
  }
}
