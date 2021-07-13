import 'dart:io';
import 'dart:math';
import 'package:GroceryApp/model/productItem.dart';
import 'package:GroceryApp/widgets/component/cameraScreen.dart';
import 'package:GroceryApp/widgets/component/default_button.dart';
import 'package:GroceryApp/widgets/icons/my_flutter_app_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../color.dart';
import '../../../sizeConfig.dart';

class AddNewProductScreen extends StatefulWidget {
  static String routeName = '/addProduct';

  @override
  _AddNewProductScreenState createState() => _AddNewProductScreenState();
}

class _AddNewProductScreenState extends State<AddNewProductScreen> {
  File imageFile;
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    final TextEditingController _nameController = TextEditingController();
    final TextEditingController _priceController = TextEditingController();
    final TextEditingController _descController = TextEditingController();
    final TextEditingController _stockController = TextEditingController();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Color(hexColor('#6C63FF')),
            title: Text(
              'Add new product',
              style: GoogleFonts.montserrat(
                  fontSize: 15, color: Color(hexColor('#ffffff'))),
            ),
            actions: <Widget>[
              IconButton(
                icon: Icon(MyFlutterApp.cancel),
                onPressed: () {
                  Get.back();
                },
              ),
            ],
          ),
          body: SingleChildScrollView(
              child: Container(
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: getFlexibleWidth(20),
                      vertical: getFlexibleHeight(25)),
                  child: TextField(
                    controller: _nameController,
                    autofocus: true,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: getFlexibleWidth(30),
                          vertical: getFlexibleHeight(25)),
                      labelText: 'Name',
                      labelStyle: TextStyle(color: Color(hexColor('#0000FF'))),
                      hintText: 'Enter product name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(hexColor('#5A58FF')),
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: getFlexibleWidth(20),
                      vertical: getFlexibleHeight(25)),
                  child: TextField(
                    controller: _priceController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: getFlexibleWidth(30),
                          vertical: getFlexibleHeight(25)),
                      labelText: 'Price',
                      labelStyle: TextStyle(color: Color(hexColor('#0000FF'))),
                      hintText: 'Enter product price',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(hexColor('#5A58FF')),
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: getFlexibleWidth(20),
                      vertical: getFlexibleHeight(25)),
                  child: TextField(
                    controller: _descController,
                    minLines: 6,
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: getFlexibleWidth(30),
                          vertical: getFlexibleHeight(25)),
                      labelText: 'Description',
                      labelStyle: TextStyle(color: Color(hexColor('#0000FF'))),
                      hintText: 'Enter product description',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(hexColor('#5A58FF')),
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: getFlexibleWidth(20),
                      vertical: getFlexibleHeight(25)),
                  child: TextField(
                    controller: _stockController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: getFlexibleWidth(30),
                          vertical: getFlexibleHeight(25)),
                      labelText: 'Stock',
                      labelStyle: TextStyle(color: Color(hexColor('#0000FF'))),
                      hintText: 'Enter product stock',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(hexColor('#5A58FF')),
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: getFlexibleWidth(20)),
                      decoration: BoxDecoration(
                          color: Color(hexColor('#c5c2ff')),
                          borderRadius: BorderRadius.circular(20)),
                      height: getFlexibleHeight(300),
                      width: getFlexibleWidth(200),
                      child: (imageFile == null)
                          ? SizedBox()
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.file(
                                imageFile,
                                fit: BoxFit.fill,
                              )),
                    ),
                    Container(
                      height: getFlexibleHeight(70),
                      width: getFlexibleWidth(120),
                      //padding: EdgeInsets.symmetric(horizontal: getFlexibleWidth(20),vertical: getFlexibleHeight(20)),
                      decoration: BoxDecoration(
                        color: Color(hexColor('#6C63FF')),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          splashColor: Colors.white,
                          child: Center(
                              child: Text('Take Picture',
                                  style: GoogleFonts.montserrat(
                                      color: Colors.white))),
                          onTap: () async {
                            imageFile = await Navigator.push<File>(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => CameraScreen()));
                            setState(() {});
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20)
              ],
            ),
          )),
          bottomNavigationBar: Container(
            padding: EdgeInsets.symmetric(
                horizontal: getFlexibleWidth(20),
                vertical: getFlexibleHeight(10)),
            decoration: BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  offset: Offset(0, -3),
                  spreadRadius: 2,
                  blurRadius: 6)
            ]),
            child: GestureDetector(
              child: DefaultButton(text: 'Add product'),
              onTap: () async {
                int rNumber = Random().nextInt(5);
                // print(imageFile.path);
                // File(imageFile.path).copy('/asset/image');
                if (_nameController.text.isNotEmpty &&
                    _priceController.text.isNotEmpty &&
                    _descController.text.isNotEmpty &&
                    imageFile.toString().isNotEmpty &&
                    _stockController.text.isNotEmpty) {
                  print('Ade lengkap data boi');
                  ProductItem().addnewProduct(
                      _nameController.text,
                      _descController.text,
                      int.parse(_priceController.text),
                      imageFile.path.toString(),
                      int.parse(_stockController.text),
                      rNumber);
                  Get.back();
                } else {
                  return null;
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
