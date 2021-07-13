import 'package:flutter/material.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({ Key key }) : super(key: key);

  static String routeName = '/checkout';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Text('Ini Checkout')
            ],
          ),
        ),
      ),
    );
  }
}