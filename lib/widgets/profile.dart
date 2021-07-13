import 'package:GroceryApp/color.dart';
import 'package:GroceryApp/sizeConfig.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';

import '../model/userService.dart';

class ProfileScreen extends StatelessWidget {
  static String routeName = '/profile';
  const ProfileScreen({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          body: ProfileContent(),
        ),
      ),
    );
  }
}

class ProfileContent extends StatefulWidget {
  const ProfileContent({Key key}) : super(key: key);

  @override
  _ProfileContentState createState() => _ProfileContentState();
}

class _ProfileContentState extends State<ProfileContent> {
  CollectionReference user = FirebaseFirestore.instance.collection('user');
  SharedPreferences _pref;
  var id;
  @override
  void initState() {
    initPreference().whenComplete(() {
      setState(() {
        this.id = _pref.getString('docId');
        print(id);
      });
    });
    super.initState();
  }

  void getLocation() async{
    final position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    final Coordinates coordinates = new Coordinates(position.latitude,position.longitude);
    final address = await Geocoder.local.findAddressesFromCoordinates(coordinates);
    setState(() {
    UserService().updateUser(address.first.addressLine, id);
    });
  }

  Future<void> initPreference() async {
    this._pref = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: getFlexibleWidth(300),
            child: Stack(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  height: getFlexibleHeight(300),
                  decoration: BoxDecoration(color: Color(hexColor('#6C63FF'))),
                  child: Center(
                      child: Text(
                    'User Profile',
                    style: GoogleFonts.montserrat(
                        fontSize: 30, color: Colors.white),
                  )),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: getFlexibleWidth(200),
                    height: getFlexibleHeight(200),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(hexColor('#6C63FF')),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
              child: FutureBuilder<DocumentSnapshot>(
            future: user.doc(id).get(),
            builder:
                (BuildContext ctx, AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                Map<String, dynamic> data = snapshot.data.data();

                return Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(25),
                  margin: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      color: Color(hexColor('#6C63FF')),
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    children: <Widget>[
                      Text(
                        'Username : ${data['name']}',
                        style: GoogleFonts.montserrat(
                            fontSize: 20, color: Colors.white),
                      ),
                      Divider(
                        color: Colors.white,
                      ),
                      Text(
                        'Email : ${data['email']}',
                        style: GoogleFonts.montserrat(
                            fontSize: 15, color: Colors.white),
                      ),
                      Divider(
                        color: Colors.white,
                      ),
                      Text(
                        (data['location'] != null)
                            ? 'Location : ${data['location']}'
                            : 'Location not set',
                        style: GoogleFonts.montserrat(
                            fontSize: 15, color: Colors.white),
                      ),
                      IconButton(
                          icon: Icon(Icons.gps_fixed),
                          color: Colors.white,
                          onPressed: () => getLocation())
                    ],
                  ),
                );
              } else {
                return Text('Loading');
              }
            },
          )),
        ],
      ),
    );
  }
}
