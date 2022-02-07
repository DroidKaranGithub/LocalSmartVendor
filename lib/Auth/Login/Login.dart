import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:otp_autofill/otp_autofill.dart';
import 'package:shop_project/ApiRepository/ApiRepository.dart';
import 'package:shop_project/Auth/Login/LoginDataUser.dart';
import 'package:shop_project/Auth/Login/LoginModalClass.dart';
import 'package:shop_project/Auth/Login/LoginOTPModalClass.dart';
import 'package:shop_project/Constants/ColorButton.dart';
import 'package:shop_project/Constants/Constant.dart';
import 'package:shop_project/Constants/InputField.dart';
import 'package:shop_project/Constants/LoaderClass.dart';
import 'package:shop_project/DashboardScreens/CreateShop/CreateShop.dart';

import '../Register/Register.dart';

class Login extends StatefulWidget {
  static String id = "Login";

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  DateTime? currentBackPressTime;
  String? Mobile;
  String? Otp;
  String? responseMessage;
  late OverlayEntry loader;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final RegExp phoneRegex = new RegExp(r'^[6-9]\d{9}$');
  final RegExp emailRegex = new RegExp(
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");
  late OTPTextEditController controller;
  late OTPInteractor _otpInteractor;
  bool? Status;
  void initState() {
    super.initState();
    _otpInteractor = OTPInteractor();
    _otpInteractor
        .getAppSignature()
        .then((value) => print('signature - $value'));

    controller = OTPTextEditController(
      codeLength: 6,
      //ignore: avoid_print
      onCodeReceive: (code) => print('Your Application receive code - $code'),
      otpInteractor: _otpInteractor,
    )..startListenUserConsent(
        (code) {
          final exp = RegExp(r'(\d{6})');
          return exp.stringMatch(code ?? '') ?? '';
        },
        // strategies: [
        //   SampleStrategy(),
        // ],
      );
  }

  void dispose() {
    controller.stopListen();
    super.dispose();
  }

  OtpVerification(Object modal) {
    ApiRepository().LoginOTPVerification(modal).then((value) {
      print("Response : ${value.body.toString()}");

      var msg = jsonDecode(value.body);
      print("msg $msg");
      if (msg['status'] == false) {
        // Fluttertoast.showToast(
        //   msg: msg['error'],
        // );
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            content: Text(
              msg['error'],
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
              ),
            ),
          ),
        );
        setState(() {
          // responseMessage = msg['error'];
        });
      } else {
        // Fluttertoast.showToast(
        //   msg: msg['msg'],
        // );
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            content: Text(
              msg['msg'],
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
              ),
            ),
          ),
        );
        setState(() {
          // responseMessage = '';
        });
        ApiRepository()
            .Login(LoginModalClass(Mobile: Mobile.toString()).toJson())
            .then((value) {
          var msg = jsonDecode(value.body);
          print(value.body);
          print(value.statusCode);
          var body = LoginModalClass.fromJson(jsonDecode(value.body));
          var body1 = LoginModalClass.fromJson(jsonDecode(value.body)).user;
          if (body.Code == 200) {
            print("myuser id is : ${body1!.id}");
            //  Shared.pref.setString("UserID", body1.id.toString());
            Shared.pref.setInt("userPerticularId", int.parse(body1.id!));
            Shared.pref.setString("UserName", body1.name.toString());
            Shared.pref.setString("mobileNumber", body1.phone.toString());
            Shared.pref.setString("UserEmail", body1.email.toString());
            Shared.pref
                .setString("PROFILE_IMAGE", body1.profile_image.toString());

            Shared.pref
                .setString("wallet_balance", body1.wallet_balance.toString());
            Shared.pref.setBool("Login", true);
            print(Shared.pref.setBool("Login", true));
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) {
              return CreateShop();
            }));

//      Status = body.Code;
            // Fluttertoast.showToast(
            //     msg: "Your Otp is ${body1.otp.toString()}",
            //     toastLength: Toast.LENGTH_LONG);

//         setState(() {});
          } else {
            // Fluttertoast.showToast(msg: body.Msg!);

          }
        });
      }
    });
  }

  Login(Object modal) {
    print("inside login $modal");
    ApiRepository().LoginOTPVerification(modal).then((value) {
      var msg = jsonDecode(value.body);
      //    print(msg);
      print(value.body.toString());
      if (msg['status'] == true) {
        var body = LoginOTPModalClass.fromJson(jsonDecode(value.body));

        setState(() {
          Status = body.Status;
          responseMessage = '';
        });
      } else {
        // Fluttertoast.showToast(msg: msg['msg']);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            content: Text(
              msg['error'],
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
              ),
            ),
          ),
        );
        setState(() {
          responseMessage = msg['msg'];
        });
      }
      // if (tatus == body.Status) {
      //   Shared.pref.setBool("Login", true);
      //   print(Shared.pref.setBool("Login", true));
      //   Navigator.pushReplacement(context,
      //       MaterialPageRoute(builder: (context) {
      //     return Ask();
      //   }));
      // }
    });
  }

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(msg: "press back twice to exit");
      return Future.value(false);
    }
    return exit(0);
  }

  @override
  Widget build(BuildContext context) {
    loader = Loader.overlayLoader(context);
    var height = AppBar().preferredSize.height;
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            // Positioned(
            //     bottom: 0.0,
            //     child: Image.asset('assets/images/VectorBlue.png')),
            // Positioned(
            //     bottom: 0.0,
            //     child: Image.asset('assets/images/VectorlightBlue.png')),
            Container(
              height: MediaQuery.of(context).size.height * 1,
              width: MediaQuery.of(context).size.width * 1,
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Image.asset('assets/images/VectorlightBlue.png'),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Image.asset('assets/images/VectorBlue.png'),
                  ),
                  Center(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: height + 70,
                          ),
                          Text(
                            'LocalsMart',
                            style: Theme.of(context)
                                .textTheme
                                .headline1!
                                .copyWith(
                                    color: DarkBlue,
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'Welcome Back!',
                            style: Theme.of(context)
                                .textTheme
                                .headline1!
                                .copyWith(
                                    color: lightBlue,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          InputField(
                            onChanged: (val) {
                              Mobile = val;
                            },
                            validator: (value) {
                              if (value == null) {
                                return "Enter Mobile Number";
                              } else if (value.isEmpty) {
                                return "Enter Mobile Number";
                              } else if (!phoneRegex.hasMatch(value)) {
                                return 'Please Enter valid phone number';
                              }
                            },
                            width: MediaQuery.of(context).size.width * 0.8,
                            // height: 60,
                            keyboardType: TextInputType.number,
                            maxLength: 10,
                            IsBorder: true,
                            prefix: Icon(
                              Icons.phone_android,
                              color: lightBlue,
                              size: 25,
                            ),
                            hint: 'Enter Mobile Number',
                            IsStyle: true,
                            style: Theme.of(context)
                                .textTheme
                                .headline1!
                                .copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: DarkBlue,
                                    fontSize: 16),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Visibility(
                            visible: (Status == true) ? true : false,
                            child: InputField(
                              controller: controller,
                              onChanged: (val) {
                                debugPrint("OTP_onChanged==>$Otp");
                                Otp = val;
                              },
                              validator: (value) {
                                Otp = value;
                                debugPrint("OTP_validator==>$value");
                                if (value == null) {
                                  return "Enter OTP";
                                } else if (value.isEmpty) {
                                  return "Enter OTP";
                                }
                              },
                              width: MediaQuery.of(context).size.width * 0.8,
                              // height: 60,
                              IsBorder: true,
                              prefix: Icon(
                                Icons.lock_open_outlined,
                                color: lightBlue,
                                size: 25,
                              ),
                              hint: 'Enter OTP',
                              maxLength: 6,

                              keyboardType: TextInputType.number,
                              IsStyle: true,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline1!
                                  .copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: lightBlue,
                                      fontSize: 16),
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Visibility(
                            visible: (Status == true) ? false : true,
                            child: InkWell(
                              onTap: () {
                                FocusScope.of(context).unfocus();
                                print("GET OTP CLICKED");
                                if (_formKey.currentState!.validate()) {
                                  Overlay.of(context)!.insert(loader);
                                  Login(LoginModalClassLoginTime(
                                          Mobile: Mobile.toString())
                                      .toJson());

                                  Loader.hideLoader(loader);
                                }
                                // Navigator.push(context,
                                //     MaterialPageRoute(builder: (context) {
                                //   return Register();
                                // }));
                              },
                              child: ColorButton(
                                RoundCorner: true,
                                width: 200,
                                colorValue: DarkBlue,
                                title: 'Get OTP',
                              ),
                            ),
                          ),
                          Visibility(
                            visible: (Status == true) ? true : false,
                            child: InkWell(
                              onTap: () {
                                print("LOGIN CLICKED");
                                if (_formKey.currentState!.validate()) {
                                  Overlay.of(context)!.insert(loader);

                                  OtpVerification(LoginOTPModalClass(
                                          phone: Mobile.toString(),
                                          otp: Otp.toString())
                                      .toJson());

                                  Loader.hideLoader(loader);
                                  // Timer(Duration(seconds: 1), () {
                                  //   Navigator.push(context, MaterialPageRoute(
                                  //       builder: (BuildContext context) {
                                  //     return Ask();
                                  //   }));
                                  // });

                                  // else{
                                  //   Fluttertoast.showToast(msg: "Please Enter OTP");
                                  // }
                                }
                              },
                              child: ColorButton(
                                RoundCorner: true,
                                width: 200,
                                colorValue: DarkBlue,
                                title: 'Login',
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          if (responseMessage != null)
                            Text(
                              responseMessage.toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .headline1!
                                  .copyWith(
                                      color: Colors.red,
                                      fontSize: 18,
                                      fontWeight: FontWeight.normal),
                            ),

                          SizedBox(
                            height: 30,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Are you new user?",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline1!
                                    .copyWith(
                                        color: DarkBlue,
                                        fontSize: 18,
                                        fontWeight: FontWeight.normal),
                              ),
                              TextButton(
                                  onPressed: () {
                                    print("Register CLICKED");
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return Register();
                                    }));
                                  },
                                  child: Text(
                                    "Register",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline1!
                                        .copyWith(
                                            color: DarkBlue,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                  ))
                            ],
                          ),
                          // InkWell(
                          //   onTap: () {
                          //     print("Register CLICKED");
                          //     Navigator.push(context,
                          //         MaterialPageRoute(builder: (context) {
                          //       return Register();
                          //     }));
                          //   },
                          //   child: ColorButton(
                          //     RoundCorner: true,
                          //     width: 200,
                          //     // color: color,
                          //     title: 'Register',
                          //   ),
                          // )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
