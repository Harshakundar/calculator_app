import 'package:flutter/material.dart';

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({Key? key}) : super(key: key);

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _display = '';
  String _input = '';
  String _operator = '';
  double? _firstOperand;

  void _onButtonPressed(String value) {
    setState(() {
      if ('0123456789'.contains(value)) {
        _input += value;
        _display += value;
      } else if ('+-*/'.contains(value)) {
        if (_input.isNotEmpty) {
          _firstOperand = double.tryParse(_input);
          _input = '';
        }
        _operator = value;
        _display += ' $value ';
      } else if (value == '=') {
        if (_firstOperand != null && _input.isNotEmpty) {
          final secondOperand = double.tryParse(_input);
          if (secondOperand != null) {
            switch (_operator) {
              case '+':
                _display = (_firstOperand! + secondOperand).toString();
                break;
              case '-':
                _display = (_firstOperand! - secondOperand).toString();
                break;
              case '*':
                _display = (_firstOperand! * secondOperand).toString();
                break;
              case '/':
                if (secondOperand != 0) {
                  _display = (_firstOperand! / secondOperand).toString();
                } else {
                  _display = 'Error (Div by 0)';
                }
                break;
            }
            _firstOperand = null;
            _input = '';
            _operator = '';
          }
        }
      } else if (value == 'C') {
        _display = '';
        _input = '';
        _operator = '';
        _firstOperand = null;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculator'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              color: Colors.black12,
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.all(16.0),
              child: Text(
                _display,
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Container(
            color: Colors.grey[300],
            child: Column(
              children: [
                _buildButtonRow(['7', '8', '9', '/']),
                _buildButtonRow(['4', '5', '6', '*']),
                _buildButtonRow(['1', '2', '3', '-']),
                _buildButtonRow(['C', '0', '=', '+']),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButtonRow(List<String> buttons) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: buttons.map((button) {
        return _buildButton(button);
      }).toList(),
    );
  }

  Widget _buildButton(String label) {
    return ElevatedButton(
      onPressed: () => _onButtonPressed(label),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(24.0),
        minimumSize: const Size(64, 64),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      child: Text(
        label,
        style: const TextStyle(fontSize: 20),
      ),
    );
  }
}
