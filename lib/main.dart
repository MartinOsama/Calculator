import 'package:flutter/material.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator',
      home: CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _output = "0";
  String _input = "";
  String _equation = "";
  double num1 = 0;
  double num2 = 0;
  String operand = "";

  void buttonPressed(String value) {
    setState(() {
      if (value == "C") {
        _output = "0";
        _input = "";
        _equation = "";
        num1 = 0;
        num2 = 0;
        operand = "";
      } else if (value == "DEL") {
        if (_input.isNotEmpty) {
          _input = _input.substring(0, _input.length - 1);
          _output = _input.isEmpty ? "0" : _input;
        }
      } else if (value == "+" || value == "-" || value == "×" || value == "÷") {
        if (_input.isNotEmpty) {
          num1 = double.tryParse(_input) ?? 0;
          operand = value;
          _equation = "$_input $operand";
          _input = "";
        }
      } else if (value == "=") {
        if (_input.isNotEmpty) {
          num2 = double.tryParse(_input) ?? 0;

          if (operand == "+") {
            _output = (num1 + num2).toString();
          } else if (operand == "-") {
            _output = (num1 - num2).toString();
          } else if (operand == "×") {
            _output = (num1 * num2).toString();
          } else if (operand == "÷") {
            _output = (num1 / num2).toString();
          }

          _equation = "";
          _input = _output;
          num1 = 0;
          num2 = 0;
          operand = "";
        }
      } else {
        _input += value;
        _output = _input;
      }
    });
  }

  Widget buildButton(String value) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () => buttonPressed(value),
        child: Text(
          value,
          style: TextStyle(fontSize: 24),
        ),
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.all(20),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Calculator')),
      body: Column(
        children: [
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
            child: Text(
              _equation,
              style: TextStyle(fontSize: 24, color: Colors.grey),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.symmetric(vertical: 24, horizontal: 12),
            child: Text(
              _output,
              style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(child: Divider()),
          Column(
            children: [
              Row(
                children: [
                  buildButton("7"),
                  buildButton("8"),
                  buildButton("9"),
                  buildButton("÷"),
                ],
              ),
              Row(
                children: [
                  buildButton("4"),
                  buildButton("5"),
                  buildButton("6"),
                  buildButton("×"),
                ],
              ),
              Row(
                children: [
                  buildButton("1"),
                  buildButton("2"),
                  buildButton("3"),
                  buildButton("-"),
                ],
              ),
              Row(
                children: [
                  buildButton("C"),
                  buildButton("0"),
                  buildButton("DEL"),
                  buildButton("+"),
                ],
              ),
              Row(
                children: [
                  buildButton("="),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}