import 'package:GroceryApp/model/userService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';

import '../color.dart';
import '../sizeConfig.dart';
import 'component/default_button.dart';
import 'icons/my_flutter_app_icons.dart';

class SignUpScreen extends StatelessWidget {
  static String routeName = '/signup';
  const SignUpScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          body: SignUpContent(),
        ),
      ),
    );
  }
}

class SignUpContent extends StatefulWidget {
  @override
  _SignUpContentState createState() => _SignUpContentState();
}

class _SignUpContentState extends State<SignUpContent> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passController = TextEditingController();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();

  bool isChecked = false;
  var role;

  void getAddress() async {
    final position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    final Coordinates coordinates = new Coordinates(position.latitude,position.longitude);
    final getAddress = await Geocoder.local.findAddressesFromCoordinates(coordinates);
    print(getAddress.first.addressLine);
    setState(() {
      _locationController.text = getAddress.first.addressLine;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isValidate = true;
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
                'Sign Up',
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
                controller: _nameController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  errorText: (isValidate == true) ? null : 'Fill all the input type',
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
                  labelText: 'Username',
                  labelStyle: TextStyle(color: Color(hexColor('#0000FF'))),
                  hintText: 'Enter your username',
                  hintStyle: TextStyle(color: Color(hexColor('#C8C8FF'))),
                  suffixIcon: Icon(Icons.account_circle),
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
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  errorText: (isValidate == true) ? null : 'Fill all the input type',
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
                  hintText: 'Enter your email',
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
                    padding: EdgeInsets.only(left:getFlexibleWidth(20)),
                    width: getFlexibleWidth(295),
                    height: getFlexibleHeight(70),
                    child: TextField(
                  controller: _locationController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    errorText: (isValidate == true) ? null : 'Fill all the input type',
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(hexColor('#5A58FF')),
                        ),
                        borderRadius: BorderRadius.circular(12)),
                    contentPadding: EdgeInsets.symmetric(
                        horizontal: getFlexibleWidth(30),
                        vertical: getFlexibleHeight(15)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    labelText: 'Address',
                    labelStyle: TextStyle(color: Color(hexColor('#0000FF'))),
                    hintText: 'Enter your address',
                    hintStyle: TextStyle(color: Color(hexColor('#C8C8FF'))),
                    suffixIcon: Icon(MyFlutterApp.location),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(right:getFlexibleHeight(25)),
                  decoration: BoxDecoration(
                    color:Color(hexColor('#5A58FF')),
                    borderRadius: BorderRadius.circular(12)
                  ),
                  child: IconButton(
                    icon:Icon(Icons.gps_fixed),
                    color: Colors.white,
                    onPressed: ()=>getAddress(),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children : <Widget>[
                Container(
                  margin : EdgeInsets.all(20),
                  child: Text('Make an admin account',
                  style: GoogleFonts.montserrat(
                    fontSize:15,
                  )),
                ),
                Checkbox( 
                  checkColor: Colors.white,
                  value: isChecked,
                  onChanged: (value){
                    setState(() {
                      isChecked = value;
                    });
                    print(isChecked);
                  },
                ),
              ]
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
                  child: Text('Have an account?',
                      style: GoogleFonts.montserrat(
                          fontSize: 15, color: Color(hexColor('#AAA8FF')))),
                ),
                Container(
                  margin:
                      EdgeInsets.symmetric(horizontal: getFlexibleWidth(25)),
                  child: InkWell(
                    splashColor: Colors.transparent,
                    child: Text(
                      'Login',
                      style: GoogleFonts.montserrat(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Color(hexColor('#6C63FF'))),
                    ),
                    onTap: () {
                      Get.toNamed('/login');
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
              child: DefaultButton(text: 'Sign Up'),
              onTap: () {
                if(isChecked == true){
                  role = 'admin';
                }else{
                  role = 'user';
                }
              setState(() async {
                if(_nameController.text.isNotEmpty && _nameController.text.isNotEmpty && _nameController.text.isNotEmpty){
                  await UserService().signUp(
                  _nameController.text,
                  _emailController.text, 
                  _passController.text,
                  role,
                  _locationController.text
                  );
                  isValidate = true;
                  Get.offNamed('/login');
                }else{
                  isValidate = false;
                  print('kosong boi');
                }
              });
                // if(_nameController.text.isNotEmpty & _nameController.text.isNotEmpty && _nameController.text.isNotEmpty){
                //  void signUp = await UserService().signUp(
                //   _nameController.text,
                //   _emailController.text, 
                //   _passController.text
                //   );
                // } else {
                //   setState(() {
                    
                //     print('Something went Wrong');
                //   });
                // }
                // await AuthService.signUp(_emailController.text, _passController.text);
                // Get.toNamed('/login');
              },
            ),
            SizedBox(
              height: getFlexibleHeight(40),
            ),
          ],
        ),
      ),
    );
  }
}
