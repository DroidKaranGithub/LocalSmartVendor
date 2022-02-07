import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:otp_autofill/otp_autofill.dart';
import 'package:shop_project/ApiRepository/ApiRepository.dart';
import 'package:shop_project/Auth/Register/RegisterUserModalClass.dart';
import 'package:shop_project/Constants/ColorButton.dart';
import 'package:shop_project/Constants/Constant.dart';
import 'package:shop_project/Constants/InputField.dart';
import 'package:shop_project/Constants/LoaderClass.dart';

import 'package:shop_project/Auth/Login/LoginModalClass.dart';
import 'package:shop_project/DashboardScreens/CreateShop/CreateShop.dart';
import 'Login/LoginModalClass.dart';
import 'Register/RegisterOTPModalClass.dart';

class OTP extends StatefulWidget {
  String? Name;
  String? Email;
  String? Mobile = "";
  String? OtpCode;

  OTP({this.Mobile, this.Email, this.Name, this.OtpCode});
  static String id = "OTP";

  @override
  _OTPState createState() => _OTPState();
}

class _OTPState extends State<OTP> {
  OverlayEntry? loader;
  String? EnteredOtp;
  String? Otp;
  String? responseMessage;
  String? Mobile;
  final scaffoldKey = GlobalKey();
  late OTPTextEditController controller;
  late OTPInteractor _otpInteractor;
  Color color = orange;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController Textcontroller = TextEditingController();
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

  @override
  void dispose() {
    controller.stopListen();
    super.dispose();
  }

  resendOtp(Map<String, dynamic> modal) {
    ApiRepository().ResendOtp(modal).then((value) {
      print(value.body);
      var msg = jsonDecode(value.body);

      if (msg['code'] == 200) {
        // Fluttertoast.showToast(
        //     msg: "${msg['msg']}", toastLength: Toast.LENGTH_LONG);
        setState(() {
          widget.OtpCode = msg['otp'].toString();
        });
        showAlertDialog(context, msg['msg'].toString(), "Success");
      } else {
        // Fluttertoast.showToast(msg: "${msg['msg']}");
        // showAlertDialog(context, msg['msg'].toString(), "Error");
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
      }
    });
  }

  register(Map<String, dynamic> modal) async {
    print("modal $modal");

    ApiRepository().RegisterOTPVerification(modal).then((value) {
      var msg = jsonDecode(value.body);
      print("msg $msg");
      if (msg['status'] == false) {
        Fluttertoast.showToast(
          msg: msg['error'],
        );
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
        // showAlertDialog(context, msg['error'].toString(), "Error");
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
        ApiRepository()
            .Register(
                RegisterUserModalClass(Name: widget.Name, Mobile: widget.Mobile)
                    .toJson())
            .then((value) {
          var msg = jsonDecode(value.body);
          print(value.body);
          print(value.statusCode);
          if (value.statusCode == 200) {
            var body1 = LoginModalClass.fromJson(jsonDecode(value.body)).user;
            Fluttertoast.showToast(msg: msg['message']);
            Shared.pref.setInt(
                "userPerticularId", int.parse(msg['data']['id'].toString()));
            Shared.pref.setString("UserName", msg['data']['name'].toString());
            Shared.pref
                .setString("mobileNumber", msg['data']['phone'].toString());
            Shared.pref.setString("UserEmail", msg['data']['email'].toString());
            Shared.pref.setString(
                "PROFILE_IMAGE", msg['data']['profile_image'].toString());
            Shared.pref.setString(
                "wallet_balance", msg['data']['wallet_balance'].toString());
            Shared.pref.setBool("Login", true);
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) {
              return CreateShop();
            }));
            // } else {
            //   Fluttertoast.showToast(msg: msg['message']);
            //   showAlertDialog(context, msg['message'].toString(), "Error");
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.red,
                content: Text(
                  msg['message'],
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                ),
              ),
            );
          }
        });
      }
    });
    // var otp = jsonDecode(result.body);
    // print("final vendor register ${result.body}");
    // var resultData = await ApiRepository()
    //     .RegisterOTPVerification({"phone": modal['phone'], "otp": otp['otp']});
    // print("final verification ${resultData.body}");
    // var res = result;
    // if (res['code'].toString() == "200") {
    //   // Shared.pref.setBool("Login", true);
    //   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
    //     return Ask();
    //   }));
    // } else {
    //   Fluttertoast.showToast(msg: res['msg']);
    // }
    // // print("myResult > ${res['code']}");
  }

  @override
  Widget build(BuildContext context) {
    loader = Loader.overlayLoader(context);
    var height = AppBar().preferredSize.height;
    return Scaffold(
        key: scaffoldKey,
        body: Container(
          color: Colors.white,
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(
                  height: height,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Image.asset(
                                'assets/images/otparrow.png',
                                scale: 1.2,
                                color: DarkBlue,
                              ))
                        ],
                      ),
                      Image.asset(
                        'assets/images/otp.png',
                        scale: 1.2,
                      )
                    ],
                  ),
                ),
                Expanded(
                    child: Container(
                  width: MediaQuery.of(context).size.width * 1,
                  decoration: BoxDecoration(
                      color: lightBlueWithLowOpacity,
                      borderRadius:
                          BorderRadius.only(topLeft: Radius.circular(70))),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Verification Code',
                            style: Theme.of(context)
                                .textTheme
                                .headline1!
                                .copyWith(
                                    color: DarkBlue,
                                    fontSize: 23,
                                    fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'We have sent the code verification to Your Mobile Number',
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .headline1!
                                .copyWith(
                                    color: lightBlue,
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "${widget.Mobile.toString()}",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline1!
                                    .copyWith(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17,
                                        color: DarkBlue),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              InkWell(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Icon(
                                    Icons.edit,
                                    size: 20,
                                  ))
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          InputField(
                            controller: controller,
                            onChanged: (val) {
                              EnteredOtp = val;
                            },
                            validator: (value) {
                              if (value == null) {
                                return "Enter OTP";
                              } else if (value.isEmpty) {
                                return "Enter OTP";
                              }
                            },
                            hint: 'Enter OTP',
                            align: TextAlign.center,
                            keyboardType: TextInputType.phone,
                            maxLength: 6,
                            IsStyle: true,
                            fillColor: Colors.white,
                            style: Theme.of(context)
                                .textTheme
                                .headline1!
                                .copyWith(
                                    color: DarkBlue,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                            IsBorder: true,
                            width: MediaQuery.of(context).size.width * 0.6,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          InkWell(
                            onTap: () {
                              print("verify ${widget.OtpCode.toString()}");
                              if (_formKey.currentState!.validate()) {
                                Overlay.of(context)!.insert(loader!);

                                register(RegisterOTPModalClass(
                                        phone: widget.Mobile,
                                        Otp: EnteredOtp.toString())
                                    .toJson());

                                Loader.hideLoader(loader!);

                                // 1 regiter 2 login 3 resend
                              }
                            },
                            child: ColorButton(
                              RoundCorner: true,
                              width: 200,
                              colorValue: DarkBlue,
                              title: 'Verify',
                              // widget: Icon(
                              //   Icons.ac_unit,
                              //   color: Colors.white,
                              // ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          InkWell(
                            onTap: () {
// resend krne pr login success msg aa rha hai APIs issue hai..
                              print(widget.OtpCode.toString());
                              resendOtp({
                                "phone": widget.Mobile,
                                "otp": widget.OtpCode.toString(),
                                "type": "3"
                              });
                              //  GetOtp({"phone": widget.Mobile, "roll_id": "3"});
                            },
                            child: Text(
                              'Resend OTP',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline1!
                                  .copyWith(
                                      color: Blue,
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ))
              ],
            ),
          ),
        ));
  }

  showAlertDialog(BuildContext context, String Message, String type) {
    // set up the button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(type),
      content: Text(Message),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
