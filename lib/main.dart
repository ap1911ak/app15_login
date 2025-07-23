import 'package:flutter/material.dart';
import 'appbar.dart';
import 'share.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    var _text = (!Share.isLoggedIn) ? 'Please Login' : 'You Loged in';

    var _icon = (!Share.isLoggedIn) ? Icons.lock_rounded : Icons.check;

    Share.updateState = (value) {
      setState(() {
        Share.isLoggedIn = value;
      });
    };

    return Scaffold(
        appBar: buildAppbar(context, 'App Login Home'),
        body: Container(
            alignment: Alignment.topCenter,
            padding: EdgeInsets.only(top: 50, left: 20, right: 20),
            child: Column(children: [
              Icon(_icon, size: 64),
              SizedBox(height: 30),
              Text(_text, textScaler: TextScaler.linear(1.7))
            ])));
  }
}
