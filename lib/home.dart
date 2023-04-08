import 'package:flutter/material.dart';

void main() => runApp(CurrencyConverterApp());

class CurrencyConverterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Currency Converter',
      home: CurrencyConverter(),
    );
  }
}

class CurrencyConverter extends StatefulWidget {
  @override
  _CurrencyConverterState createState() => _CurrencyConverterState();
}

class _CurrencyConverterState extends State<CurrencyConverter> {
  String selectedSourceCurrency = 'USD';
  String selectedTargetCurrency = 'EUR';
  double amountToConvert = 0.0;
  double convertedAmount = 0.0;

  Map<String, double> exchangeRates = {
    'USD': 1.0,
    'EUR': 0.87,
    'GBP': 0.76,
    'JPY': 112.04,
    'INR': 74.89, // Indian Rupee exchange rate
  }; // Example exchange rates

  void _convertCurrency() {
    setState(() {
      double sourceRate = exchangeRates[selectedSourceCurrency] ?? 1.0;
      double targetRate = exchangeRates[selectedTargetCurrency] ?? 1.0;
      convertedAmount = (amountToConvert / sourceRate) * targetRate;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Currency Converter'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'Amount to Convert:',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 8.0),
            TextField(
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  amountToConvert = double.parse(value);
                });
              },
            ),
            SizedBox(height: 16.0),
            Text(
              'From:',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 8.0),
            DropdownButton<String>(
              value: selectedSourceCurrency,
              onChanged: (value) {
                setState(() {
                  selectedSourceCurrency = value!;
                });
              },
              items: exchangeRates.keys.map<DropdownMenuItem<String>>((currency) {
                return DropdownMenuItem<String>(
                  value: currency,
                  child: Text(currency),
                );
              }).toList(),
            ),
            SizedBox(height: 16.0),
            Text(
              'To:',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 8.0),
            DropdownButton<String>(
              value: selectedTargetCurrency,
              onChanged: (value) {
                setState(() {
                  selectedTargetCurrency = value!;
                });
              },
              items: exchangeRates.keys.map<DropdownMenuItem<String>>((currency) {
                return DropdownMenuItem<String>(
                  value: currency,
                  child: Text(currency),
                );
              }).toList(),
            ),
            SizedBox(height: 16.0),
            RaisedButton(
              child: Text('Convert'),
              onPressed: () {
                _convertCurrency();
              },
            ),
            SizedBox(height: 16.0),
            Text(
              'Converted Amount: $convertedAmount',
              style: TextStyle(fontSize: 16.0),
            ),
          ],
        ),
      ),
    );
  }
}
