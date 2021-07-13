import 'package:GroceryApp/widgets/Admin/ProductItem/addNewItemScreen.dart';
import 'package:GroceryApp/widgets/CartScreen.dart';
import 'package:GroceryApp/widgets/HomeScreen.dart';
import 'package:GroceryApp/widgets/component/cameraScreen.dart';
import 'package:GroceryApp/widgets/favScreen.dart';
import 'package:GroceryApp/widgets/login.dart';
import 'package:GroceryApp/widgets/profile.dart';
import 'package:GroceryApp/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'widgets/adminScreen.dart';
import 'widgets/splash.dart';
import 'widgets/detail_product.dart';
import 'widgets/CheckoutScreen.dart';
import 'widgets/SignUpScreen.dart';

final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (content) => SplashScreen(),
  LoginScreen.routeName: (content) => LoginScreen(),
  HomeScreen.routeName: (content) => HomeScreen(),
  DetailProduct.routeName: (content) => DetailProduct(),
  CartScreen.routeName: (content) => CartScreen(),
  CheckoutScreen.routeName: (content) => CheckoutScreen(),
  SignUpScreen.routeName: (content) => SignUpScreen(),
  Wrapper.routeName: (content) => Wrapper(),
  FavScreen.routeName: (content) => FavScreen(),
  AdminScreen.routeName :(content) =>AdminScreen(),
  AddNewProductScreen.routeName : (content) =>AddNewProductScreen(),
  CameraScreen.routeName : (content) =>CameraScreen(),
  ProfileScreen.routeName : (content) =>ProfileScreen(),
};
