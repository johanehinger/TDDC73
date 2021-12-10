import 'package:flutter/material.dart';
import 'package:mini_sdk/mini_sdk.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Swish mini_sdk page',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'mini_sdk Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        decoration: BoxDecoration(color: Colors.red),
        child: Center(
          child: Card(
            child: Container(
              height: 400,
              child: SwishForm(
                currencies: const ['NOK', 'USD', 'EUR'],
                // decoration: BoxDecoration(color: Colors.green),
                swishButton: SwishButtonTypes.primaryTextButton,
                onSwishPress: () {
                  debugPrint("Swish!");
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
