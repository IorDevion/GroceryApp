import 'package:GroceryApp/widgets/CartScreen.dart';
import 'package:GroceryApp/widgets/HomeScreen.dart';
import 'package:GroceryApp/widgets/login.dart';
import 'package:flutter/widgets.dart';

import 'widgets/splash.dart';
import 'widgets/detail_product.dart';

final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (content) => SplashScreen(),
  LoginScreen.routeName: (content) => LoginScreen(),
  HomeScreen.routeName: (content) => HomeScreen(),
  DetailProduct.routeName: (content) => DetailProduct(),
  CartScreen.routeName : (content) => CartScreen(),
};
