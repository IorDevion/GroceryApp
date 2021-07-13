import 'package:GroceryApp/route.dart';
import 'package:GroceryApp/wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';

void main() async {   
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
   SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp
  ]); 
  return  GetMaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute:Wrapper.routeName,
        routes: routes,
      );
  }
}