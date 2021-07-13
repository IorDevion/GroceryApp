import 'package:GroceryApp/widgets/icons/my_flutter_app_icons.dart';
import 'package:flutter/material.dart';
import '../../sizeConfig.dart';
import '../../color.dart';

class InputTypeForm extends StatelessWidget {

  final String name, hint;
  final bool isPassword;
  InputTypeForm({this.name,this.hint,this.isPassword});
  
  @override
  Widget build(BuildContext context) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal:getFlexibleWidth(20)),
          child: TextField(
            keyboardType: isPassword ? TextInputType.visiblePassword: TextInputType.emailAddress,
            obscureText: isPassword ? true : false,
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color(hexColor('#5A58FF')),
                ),
                borderRadius: BorderRadius.circular(12)
              ),
              contentPadding:EdgeInsets.symmetric(horizontal:getFlexibleWidth(30),vertical: getFlexibleHeight(25)),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                ),
              labelText:name,
              labelStyle: TextStyle(
                color: Color(hexColor('#0000FF'))
              ),
              hintText: hint,
              hintStyle: TextStyle(
                color: Color(hexColor('#C8C8FF'))
              ),
              suffixIcon: name == 'Email' ? Icon(MyFlutterApp.mail_1) : Icon(MyFlutterApp.key),
          floatingLabelBehavior: FloatingLabelBehavior.always,
        ),
      ),
    );
  }
}