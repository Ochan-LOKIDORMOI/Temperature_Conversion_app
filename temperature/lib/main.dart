// ignore_for_file: library_private_types_in_public_api, sort_child_properties_last, sized_box_for_whitespace

import 'package:flutter/material.dart';

void main() {
  runApp(const TemperatureConversionApp());
}

class TemperatureConversionApp extends StatelessWidget {
  const TemperatureConversionApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Temperature Conversion App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const TemperatureConversionScreen(),
    );
  }
}

class TemperatureConversionScreen extends StatefulWidget {
  const TemperatureConversionScreen({super.key});

  @override
  _TemperatureConversionScreenState createState() =>
      _TemperatureConversionScreenState();
}

class _TemperatureConversionScreenState
    extends State<TemperatureConversionScreen> {
  final TextEditingController _controller = TextEditingController();
  String _convertedValue = '';
  final List<String> _conversionHistory = [];
  bool _isFahrenheitToCelsius = true;

  void _convertTemperature() {
    double inputValue = double.tryParse(_controller.text) ?? 0.0;
    double result;
    if (_isFahrenheitToCelsius) {
      result = (inputValue - 32) * 5 / 9;
      _conversionHistory.insert(
          0, 'F to C: ${inputValue.toStringAsFixed(1)} => ${result.toStringAsFixed(1)}');
    } else {
      result = inputValue * 9 / 5 + 32;
      _conversionHistory.insert(
          0, 'C to F: ${inputValue.toStringAsFixed(1)} => ${result.toStringAsFixed(1)}');
    }
    setState(() {
      _convertedValue = result.toStringAsFixed(1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(195, 13, 92, 110),
      appBar: AppBar(
        title: const Text('Temperature Conversion App'),
        backgroundColor: Color.fromARGB(173, 170, 3, 3), 
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 25),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: const Text(
                  'Select Conversion Type',
                  style: TextStyle(fontSize: 33, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: ListTile(
                      title: const Text('Fahrenheit to Celsius', style: TextStyle(color: Colors.white, fontSize: 16)),
                      leading: Radio<bool>(
                        value: true,
                        groupValue: _isFahrenheitToCelsius,
                        onChanged: (value) {
                          setState(() {
                            _isFahrenheitToCelsius = value!;
                          });
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListTile(
                      title: const Text('Celsius to Fahrenheit', style: TextStyle(color: Colors.white, fontSize: 16)),
                      leading: Radio<bool>(
                        value: false,
                        groupValue: _isFahrenheitToCelsius,
                        onChanged: (value) {
                          setState(() {
                            _isFahrenheitToCelsius = value!;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Enter Temperature',
                        labelStyle: TextStyle(color: Colors.white),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                      style: const TextStyle(color: Colors.white, fontSize: 30),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      '=',
                      style: TextStyle(fontSize: 40, color: Colors.white),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Text(
                        _convertedValue,
                        style: const TextStyle(fontSize: 30, color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: _convertTemperature,
                  child: const Text('Convert'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    textStyle: const TextStyle(fontSize: 25),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              const Text(
                'Conversion History',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              Container(
                height: 200,
                child: ListView.builder(
                  itemCount: _conversionHistory.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(_conversionHistory[index], style: const TextStyle(color: Colors.white, fontSize: 25)),
                      leading: const Icon(Icons.history, color: Colors.white),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
