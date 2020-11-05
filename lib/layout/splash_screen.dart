import 'dart:async';
import 'package:aliman_app/layout/login.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../UIScale/sizeconfig.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  DateTime currentBackPressTime;
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 5), () {
      navigateUser();
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: WillPopScope(
        onWillPop: onWillPop,
        child: Container(
          decoration: BoxDecoration(color: Colors.white24),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  'assets/images/alimanbogalogo.png',
                  height: 200,
                  width: 200,
                ),
                new Padding(
                  padding: EdgeInsets.only(top: 30),
                ),
                CircularProgressIndicator()
              ],
            ),
          ),
        ),
      ),
    );
  }

  void navigateUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var status = prefs.getBool("isLogin") ?? false;
    print("status=$status");
    if (status) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
    } else {
      Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
    }
  }

  Future<bool> onWillPop() async {
    DateTime now = DateTime.now();
    bool backButton = currentBackPressTime == null ||
        now.difference(currentBackPressTime) > Duration(seconds: 2);

    if (backButton) {
      currentBackPressTime = now;
      Fluttertoast.showToast(
          msg: 'Tekan dua kali untuk keluar dari aplikasi',
          textColor: Colors.white);
      return false;
    }
    return true;
  }
}
