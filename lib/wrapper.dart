import 'package:GroceryApp/widgets/login.dart';
import 'package:GroceryApp/widgets/splash.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Wrapper extends StatefulWidget {
  static String routeName = '/wrapper';

  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  String isSplash = '';
  SharedPreferences _pref;

  @override
  void initState() {
    initPreferences().whenComplete(() {
      setState(() {});
    });
    super.initState();
  }

  Future<void> initPreferences() async {
    this._pref = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    isSplash = _pref.getString('splash');
    print(isSplash);
    return isSplash != null ? LoginScreen():  SplashScreen();
  }
}
