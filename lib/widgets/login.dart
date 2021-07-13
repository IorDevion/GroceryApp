import 'package:GroceryApp/sizeConfig.dart';
import 'package:GroceryApp/widgets/component/default_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../color.dart';
import 'icons/my_flutter_app_icons.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

Future<UserCredential> signInFacebook() async {
  final AccessToken result = await FacebookAuth.instance.login();
  final facebookAuthCredential = FacebookAuthProvider.credential(result.token);
  return await FirebaseAuth.instance
      .signInWithCredential(facebookAuthCredential);
}

Future<UserCredential> signInGoogle() async {
  final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();
  final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
  final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
  return await FirebaseAuth.instance.signInWithCredential(credential);
}

class LoginScreen extends StatelessWidget {
  final FirebaseAuth auth = FirebaseAuth.instance;

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
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  final CollectionReference _user =
      FirebaseFirestore.instance.collection('user');

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
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
                    color: Color(hexColor('#5A58FF'))),
              ),
            ),
            SizedBox(
              height: getFlexibleHeight(20),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: getFlexibleWidth(20)),
              child: TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(hexColor('#5A58FF')),
                      ),
                      borderRadius: BorderRadius.circular(12)),
                  contentPadding: EdgeInsets.symmetric(
                      horizontal: getFlexibleWidth(30),
                      vertical: getFlexibleHeight(25)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  labelText: 'Email',
                  labelStyle: TextStyle(color: Color(hexColor('#0000FF'))),
                  hintText: 'Enter your Email',
                  hintStyle: TextStyle(color: Color(hexColor('#C8C8FF'))),
                  suffixIcon: Icon(MyFlutterApp.mail_1),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                ),
              ),
            ),
            SizedBox(
              height: getFlexibleHeight(20),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: getFlexibleWidth(20)),
              child: TextField(
                controller: _passController,
                obscureText: true,
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(hexColor('#5A58FF')),
                      ),
                      borderRadius: BorderRadius.circular(12)),
                  contentPadding: EdgeInsets.symmetric(
                      horizontal: getFlexibleWidth(30),
                      vertical: getFlexibleHeight(25)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  labelText: 'Password',
                  labelStyle: TextStyle(color: Color(hexColor('#0000FF'))),
                  hintText: 'Enter your password',
                  hintStyle: TextStyle(color: Color(hexColor('#C8C8FF'))),
                  suffixIcon: Icon(MyFlutterApp.key),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                ),
              ),
            ),
            SizedBox(
              height: getFlexibleHeight(20),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  margin:
                      EdgeInsets.symmetric(horizontal: getFlexibleWidth(25)),
                  child: Text('Not Have an account?',
                      style: GoogleFonts.montserrat(
                          fontSize: 15, color: Color(hexColor('#AAA8FF')))),
                ),
                Container(
                  margin:
                      EdgeInsets.symmetric(horizontal: getFlexibleWidth(25)),
                  child: InkWell(
                    splashColor: Colors.transparent,
                    child: Text(
                      'Sign up',
                      style: GoogleFonts.montserrat(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Color(hexColor('#6C63FF'))),
                    ),
                    onTap: () {
                      Get.toNamed('/signup');
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
              onTap: () async {
                if (_emailController.text.isNotEmpty &&
                    _passController.text.isNotEmpty) {
                  QuerySnapshot eventsQuery = await _user
                      .where("email", isEqualTo: _emailController.text)
                      .where('pass', isEqualTo: _passController.text)
                      .get();
                  var docRefName = eventsQuery.docs[0].reference.path.split('/').last;

                  SharedPreferences pref = await SharedPreferences.getInstance();
                  pref.setString('username', eventsQuery.docs[0]['name']);
                  pref.setString('email', eventsQuery.docs[0]['email']);
                  pref.setString('role', eventsQuery.docs[0]['role']);
                  pref.setString('docId', docRefName);
                  if (eventsQuery.docs[0]['role'] == 'admin') {
                    Get.offNamed('/admin');
                  } else {
                    Get.offNamed('/home');
                  }
                } else {
                  return null;
                }
              },
            ),
            SizedBox(
              height: getFlexibleHeight(20),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                    height: getFlexibleHeight(50),
                    width: getFlexibleWidth(50),
                    decoration: BoxDecoration(
                      color: Color(hexColor('#3B5998')),
                      shape: BoxShape.circle,
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                          child: Center(
                              child: Icon(MyFlutterApp.facebook_2,
                                  color: Colors.white)),
                          onTap: () => signInFacebook().then((value) {
                                Get.offNamed('/home');
                              })),
                    )),
                SizedBox(
                  width: getFlexibleWidth(30),
                ),
                Container(
                    height: getFlexibleHeight(50),
                    width: getFlexibleWidth(50),
                    decoration: BoxDecoration(
                      color: Color(hexColor('#EA4335')),
                      shape: BoxShape.circle,
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        child: Center(
                            child:
                                Icon(MyFlutterApp.google, color: Colors.white)),
                        onTap: () => signInGoogle()
                            .then((value) => {Get.offNamed('/home')}),
                      ),
                    )),
              ],
            ),
            SizedBox(
              height: getFlexibleHeight(20),
            ),
          ],
        ),
      ),
    );
  }
}

// class InputTypeForm extends StatelessWidget {
//   final String name, hint;
//   final bool isPassword;

//   final TextEditingController passController = TextEditingController();
//   final TextEditingController emailController = TextEditingController();

//   InputTypeForm({this.name,this.hint,this.isPassword});

//   @override
//   Widget build(BuildContext context) {
//         return Container(
//           padding: EdgeInsets.symmetric(horizontal:getFlexibleWidth(20)),
//           child: TextField(
//             controller: isPassword ? passController : emailController,
//             keyboardType: isPassword ? TextInputType.visiblePassword: TextInputType.emailAddress,
//             obscureText: isPassword ? true : false,
//             decoration: InputDecoration(
//               focusedBorder: OutlineInputBorder(
//                 borderSide: BorderSide(
//                   color: Color(hexColor('#5A58FF')),
//                 ),
//                 borderRadius: BorderRadius.circular(12)
//               ),
//               contentPadding:EdgeInsets.symmetric(horizontal:getFlexibleWidth(30),vertical: getFlexibleHeight(25)),
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(15),
//                 ),
//               labelText:name,
//               labelStyle: TextStyle(
//                 color: Color(hexColor('#0000FF'))
//               ),
//               hintText: hint,
//               hintStyle: TextStyle(
//                 color: Color(hexColor('#C8C8FF'))
//               ),
//               suffixIcon: name == 'Email' ? Icon(MyFlutterApp.mail) : Icon(MyFlutterApp.key),
//           floatingLabelBehavior: FloatingLabelBehavior.always,
//         ),
//       ),
//     );
//   }
// }
