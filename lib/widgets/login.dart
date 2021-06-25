import 'package:GroceryApp/sizeConfig.dart';
import 'package:GroceryApp/widgets/HomeScreen.dart';
import 'package:GroceryApp/widgets/component/default_button.dart';
import 'package:GroceryApp/widgets/icons/my_flutter_app_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

import '../color.dart';
import '../main.dart';
import './component/inputType.dart';


class LoginScreen extends StatelessWidget {
  static String routeName = '/login';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          body: LoginContent(),
        ),
      ),
    );
  }
}

class LoginContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: getFlexibleHeight(50),
            ),
            Container(
              height: getFlexibleHeight(300),
              child: Center(child: SvgPicture.asset('asset/image/login1.svg')),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.only(left: getFlexibleWidth(25)),
              child: Text(
                'Login',
                style: GoogleFonts.montserrat(
                  fontSize: 27,
                  fontWeight: FontWeight.bold,
                  color: Color(hexColor('#5A58FF'))
                ),
              ),
            ),
            SizedBox(
              height: getFlexibleHeight(20),
            ),
            InputTypeForm(
              name: 'Email',
              isPassword: false,
              hint: 'Enter your email',
            ),
            SizedBox(
              height: getFlexibleHeight(20),
            ),
            InputTypeForm(
              name: 'Password',
              isPassword: true,
              hint: 'Enter your password',
            ),
            SizedBox(
              height: getFlexibleHeight(20),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
              Container(
              margin:EdgeInsets.symmetric(horizontal: getFlexibleWidth(25)),
              child: Text('Not Have an account?',
              style: GoogleFonts.montserrat(
                fontSize: 15,
                color: Color(hexColor('#AAA8FF'))
                )),
              ),
              Container(
              margin:EdgeInsets.symmetric(horizontal: getFlexibleWidth(25)),
                child: InkWell(
                  splashColor: Colors.transparent,
                  child:Text('Sign up',
                  style: GoogleFonts.montserrat(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Color(hexColor('#6C63FF'))
                    ),
                  ),
                  onTap: (){
                    //Add Something
                    },
                  ),
              ),
              ],
            ),
            SizedBox(
              height: getFlexibleHeight(40),
            ),
            GestureDetector(
                child: DefaultButton(text: 'Login'),
                onTap: (){
                  Get.offAllNamed(HomeScreen.routeName);
                },
            )
          ],
        ),
      ),
    );
  }
}
