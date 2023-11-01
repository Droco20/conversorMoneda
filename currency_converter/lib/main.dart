import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Conversor de Moneda',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white54),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Conversor de Moneda'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double monto = 0.0;
  String monedaBase = 'COP';
  String monedaSeleccionada = 'USD';
  List<String> monedasDisponibles = ['USD', 'EUR', 'CNY'];

  void _convertirMoneda() {
    double resultado = 0.0;

    if (monedaSeleccionada == 'USD') {
      double tasaUSD = 4300.66;
      resultado = monto / tasaUSD;
    } else if (monedaSeleccionada == 'EUR') {
      double tasaEUR = 5100.37;
      resultado = monto / tasaEUR;
    } else if (monedaSeleccionada == 'CNY') {
      double tasaCNY = 599.03;
      resultado = monto / tasaCNY;
    }

    setState(() {
      monto = resultado;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Bienvenidos',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 22),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Moneda a Convertir: ',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  DropdownButton<String>(
                    value: monedaSeleccionada,
                    items: monedasDisponibles.map((moneda) {
                      IconData? icono;
                      String label = moneda;

                      if (moneda == 'USD') {
                        icono = Icons.attach_money;
                      } else if (moneda == 'EUR') {
                        icono = Icons.euro_symbol;
                      } else if (moneda == 'CNY') {
                        icono = Icons.monetization_on;
                      }

                      return DropdownMenuItem<String>(
                        value: moneda,
                        child: Row(
                          children: [
                            Icon(icono),
                            const SizedBox(width: 10),
                            Text(label),
                          ],
                        ),
                      );
                    }).toList(),
                    onChanged: (String? nuevaMoneda) {
                      if (nuevaMoneda != null) {
                        setState(() {
                          monedaSeleccionada = nuevaMoneda;
                        });
                      }
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Monto en ${monedaBase}',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(9.0),
                  ),
                  contentPadding:
                  EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  labelStyle: TextStyle(
                    fontSize: 18,
                    color: Colors.blue,
                  ),
                ),
                keyboardType: TextInputType.number,
                onChanged: (text) {
                  setState(() {
                    monto = double.tryParse(text) ?? 0.0;
                  });
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _convertirMoneda,
                style: ElevatedButton.styleFrom(
                  primary: Colors.lightGreen,
                  onPrimary: Colors.white,
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: const Text('Convertir', style: TextStyle(fontSize: 18)),
              ),
              const SizedBox(height: 20),
              Text(
                'Total: $monto ',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.blue,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
