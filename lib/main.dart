import 'package:GroceryApp/route.dart';
import 'package:GroceryApp/widgets/splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) { 
        return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute:SplashScreen.routeName,
      routes: routes,
    );
  }
}