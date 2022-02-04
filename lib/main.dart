import 'package:flutter/material.dart';
import 'package:shop_project/Auth/OTP.dart';
import 'package:shop_project/DashboardScreens/Shop/Shop.dart';
import 'package:shop_project/SplashScreen.dart';
import 'Auth/Login/Login.dart';
import 'Auth/Register/Register.dart';
import 'Constants/Constant.dart';
import 'DashboardScreens/Inquries/Inquries.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'DashboardScreens/Profile/EditProfile.dart';
import 'DashboardScreens/Profile/Profile.dart';
import 'DashboardScreens/Responses/Responses.dart';
import 'DashboardScreens/Wallet/coupons/Coupon UI/Coupons.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Shared.pref = await SharedPreferences.getInstance();
  runApp(Material());
}

class Material extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LocalsMart Vendor',
      theme: ThemeData(
        textTheme: TextTheme(
          headline1:
              TextStyle(color: Colors.orange, fontWeight: FontWeight.w100),
          headline2: TextStyle(
            color: Colors.orange,
            // fontWeight: FontWeight.w100
          ),
        ),
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
      routes: {
        Profile.id: (context) => Profile(),
        EditProfile.id: (context) => EditProfile(),
        SplashScreen.id: (context) => SplashScreen(),
        Login.id: (context) => Login(),
        Register.id: (context) => Register(),
        OTP.id: (context) => OTP(),
        CouponsPage.id: (context) => CouponsPage(),
        "Inquries": (context) => Inquries(),
        Responses.id: (context) => Responses(),
        ShopName.id: (context) => ShopName(),
      },
    );
  }
}
