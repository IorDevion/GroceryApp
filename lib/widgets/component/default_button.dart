import 'package:flutter/material.dart';
import '../../sizeConfig.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../color.dart';

class DefaultButton extends StatelessWidget {
  final String text;
  DefaultButton({this.text});
  
  @override
  Widget build(BuildContext context) {
    return  Container(
    width: double.infinity,
    height: getFlexibleHeight(50),
    margin: EdgeInsets.symmetric(horizontal: getFlexibleWidth(20)),
    decoration: BoxDecoration(
      color: Color(hexColor('#6C63FF')),
      borderRadius: BorderRadius.circular(12)
    ),
    child:Material(
      color: Colors.transparent,
        child: InkWell(
          splashColor: Colors.white,
          child: Center(
            child: Text(text,style: GoogleFonts.montserrat(
              fontSize:15,
              color: Colors.white
            ),
          ),
        ),
      )
    )
  );
  }
}