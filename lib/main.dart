import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  TextEditingController weight = TextEditingController();
  TextEditingController height = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _infoText = 'Informe seus dados!';

  void resetAll(){
    weight.text = '';
    height.text = '';
    setState(() {
      _infoText = 'Informe seus dados!';
      _formKey = GlobalKey<FormState>();
    });
  }
  
  void calculate(){
   setState(() {
     double weightCalc = double.parse(weight.text);
     double heightCalc = double.parse(height.text) / 100;
     double imc = weightCalc / (heightCalc * heightCalc);
     if(imc < 18.6){
       _infoText = 'Abaixo do peso ${imc.toStringAsPrecision(4)}';
     }
     else if(imc >=  18.6 && imc <= 24.9){
       _infoText = 'Peso Ideal ${imc.toStringAsPrecision(4)}';
     } else if(imc >= 24.9 && imc <= 29.9){
       _infoText = 'Levemente acima do peso ${imc.toStringAsPrecision(4)}';
     } else if(imc >=  29.9 && imc <= 34.9){
       _infoText = 'Obesidade Grau I ${imc.toStringAsPrecision(4)}';
     } else if(imc >=  34.9 && imc <= 39.9){
       _infoText = 'Obesidade Grau II ${imc.toStringAsPrecision(4)}';
     } else if(imc >= 40){
       _infoText = 'Obesidade Grau III ${imc.toStringAsPrecision(4)}';
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
        backgroundColor: Colors.green,
        actions: <Widget>[
          IconButton(
              onPressed: resetAll,
              icon: Icon(
                Icons.refresh,
                color: Colors.white,
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Icon(
                  Icons.person_2_outlined,
                  size: 120,
                  color: Colors.green,
                ),
                TextFormField(
                  validator: (value) {
                    if(value!.isEmpty){
                      return 'Inisra sua altura!';
                    }
                  },
                  controller: height,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: 'Altura (cm)',
                      labelStyle: TextStyle(color: Colors.green)),
                  textAlign: TextAlign.center,
                ),
                TextFormField(
                  validator: (value) {
                    if(value!.isEmpty){
                      return 'Inisra seu peso!';
                    }
                  },
                  controller: weight,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: 'Peso (kg)',
                      labelStyle: TextStyle(color: Colors.green)),
                  textAlign: TextAlign.center,
                ),
                 const SizedBox(height: 16,),
                 ElevatedButton(onPressed: (){
                   if(_formKey.currentState!.validate()){
                     calculate();
                   }
                 }, child: Text("Calcular"), style: ElevatedButton.styleFrom(primary: Colors.green[300]),),
                 Text(_infoText, textAlign: TextAlign.center, style: TextStyle(color: Colors.green, fontSize: 16),)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
