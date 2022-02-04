import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shop_project/Constants/Constant.dart';
import 'package:shop_project/DashboardScreens/CreateShop/CreateShop.dart';

import 'Auth/Login/Login.dart';

class SplashScreen extends StatefulWidget {
  static String id = "SpalasScreen";
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 3),
        () => Navigator.push(context, MaterialPageRoute(builder: (context) {
              return login == true ? CreateShop() : Login();
            })));
  }

  bool? login = Shared.pref.getBool("Login");
  @override
  Widget build(BuildContext context) {
    var height = AppBar().preferredSize.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Container(
        height: MediaQuery.of(context).size.height * 1,
        width: MediaQuery.of(context).size.width * 1,
        child: Stack(
          //mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Center(
              child: Column(
                children: [
                  SizedBox(
                    height: height + 140,
                  ),
                  Container(
                    height: 230,
                    child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40)),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(40),
                          child: Image.asset(
                            "assets/images/AppLogo.png",
                            scale: 2.5,
                          )),
                    ),
                  ),
                ],
              ),
            ),
            //SizedBox(height: 80,),
            Align(
                alignment: Alignment.bottomRight,
                child: Image.asset('assets/images/VectorlightBlue.png')),
            Align(
                alignment: Alignment.bottomRight,
                child: Image.asset('assets/images/VectorBlue.png'))
          ],
        ),
      ),
    );
  }
}
