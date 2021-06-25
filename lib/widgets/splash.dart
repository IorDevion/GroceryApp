import 'package:GroceryApp/widgets/component/default_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

import '../sizeConfig.dart';
import './login.dart';

hexColor(String color) {
  var newColor = '0xff' + color;
  newColor = newColor.replaceAll('#', '');
  int intColor = int.parse(newColor);
  return intColor;
}

class SplashScreen extends StatefulWidget {
  static String routeName = '/splash';

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  int currentPage = 0;
  PageController _controller = PageController(initialPage: 0);
  List<Map<String, String>> splashData = [
    {
      "title": "FAST DELIVERY",
      "desc":
          "Grocery merupakan aplikasi menggunakan sistem delivery yang sangat cepat",
      "img": "asset/image/splash1.svg"
    },
    {
      "title": "GROCERY",
      "desc":
          "Grocery merupakan aplikasi baru sebagai tempat belanja yang lengkap",
      "img": "asset/image/splash2.svg"
    },
    {
      "title": "FAST PAYMENT",
      "desc":
          "Grocery merupakan aplikasi baru dengan meggunakan pembayaran yang cepat",
      "img": "asset/image/splash3.svg"
    },
  ];

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: PageView.builder(
                  controller: _controller,
                  onPageChanged: (value) {
                    setState(() {
                      currentPage = value;
                    });
                  },
                  itemBuilder: (context, currentPage) {
                    return SplashContent(
                      title: splashData[currentPage]['title'],
                      img: splashData[currentPage]['img'],
                      desc: splashData[currentPage]['desc'],
                    );
                  },
                  itemCount: splashData.length),
            ),
            Container(
              padding: EdgeInsets.only(bottom: getFlexibleHeight(70)),
              child: Column(
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        splashData.length,
                        (index) => buildDot(index: index),
                      )),
                ],
              ),
            ),
            GestureDetector(
              child: DefaultButton(text: 'Continue'),
              onTap: () {
                setState(() {
                  if(currentPage == 0){
                  _controller.animateToPage(1, duration: Duration(milliseconds: 360), curve: Curves.easeInOut);
                  }
                 if(currentPage == 1){
                  _controller.animateToPage(2, duration: Duration(milliseconds: 360), curve: Curves.easeInOut);
                  }
                  if(currentPage == 2){
                    Get.toNamed(LoginScreen.routeName);
                  }
                });
              },
            ),
            SizedBox(height: 20)
          ],
        ),
      ),
    );
  }

  AnimatedContainer buildDot({int index}) {
    return AnimatedContainer(
      margin: EdgeInsets.symmetric(horizontal: getFlexibleWidth(5)),
      duration: Duration(milliseconds: 360),
      width: 10,
      height: 10,
      decoration: BoxDecoration(
        color: currentPage == index
            ? Color(hexColor('#6C63FF'))
            : Color(hexColor('#EDEDFF')),
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }
}

class SplashContent extends StatelessWidget {
  const SplashContent({
    this.title,
    this.img,
    this.desc,
    Key key,
  }) : super(key: key);

  final String title, img, desc;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(top: getFlexibleHeight(50)),
          child: Center(
            child: Text(
              title,
              style: GoogleFonts.montserrat(
                  fontSize: getFlexibleWidth(40),
                  color: Color(hexColor('#6C63FF'))),
            ),
          ),
        ),
        Container(
            padding: EdgeInsets.symmetric(
                horizontal: getFlexibleWidth(50),
                vertical: getFlexibleHeight(20)),
            child: Text(desc,
                textAlign: TextAlign.center,
                style: GoogleFonts.montserrat(
                    fontSize: getFlexibleWidth(20),
                    color: Color(hexColor('#B9B6FF'))))),
        Container(
          height: getFlexibleHeight(350),
          margin: EdgeInsets.symmetric(horizontal: getFlexibleWidth(40)),
          child: SvgPicture.asset(img),
        ),
      ],
    );
  }
}
