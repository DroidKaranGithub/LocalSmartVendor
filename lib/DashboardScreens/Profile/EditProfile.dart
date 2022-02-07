import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shop_project/Constants/ColorButton.dart';
import 'package:shop_project/Constants/Constant.dart';
import 'package:shop_project/Constants/InputField.dart';
import 'package:shop_project/Constants/LoaderClass.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop_project/DashboardScreens/Profile/Profile.dart';
import 'package:shop_project/constant.dart';

class EditProfile extends StatefulWidget {
  static String id = "EditProfile";
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  late OverlayEntry loader;
  String? Email = '';
  String? Name = '';
  File? personalProfilefile;
  String personalProfilepath = "";
  var imagePicker = ImagePicker();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final RegExp phoneRegex = new RegExp(r'^[6-9]\d{9}$');
  final RegExp emailRegex = new RegExp(
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");
  TextEditingController email = TextEditingController();
  TextEditingController userName = TextEditingController();

  Future updateProfileApi() async {
    print("create shop choose id is ");

    String url = BaseUrl + "profile/update";

    var request = http.MultipartRequest("POST", Uri.parse(url));
    print(url);
    print(Shared.pref.get("userPerticularId").toString());

    request.fields['user_id'] = Shared.pref.get("userPerticularId").toString();
    request.fields['name'] = userName.text;
    request.fields['email'] = email.text;

    if (personalProfilepath.isNotEmpty) {
      var profile_image = await http.MultipartFile.fromPath(
          "profile_image", (personalProfilepath));
      request.files.add(profile_image);
    }
    //business_kyc_doc

    print(request.files);
    print(request.fields);

    //   // var shop_images2 = await http.MultipartFile.fromPath(
    //   //     "shop_images[1]", shopImages[1].path);
    //   // request.files.add(shop_images2);
    // }

    print(url);
    request.send().then((response) => {
          http.Response.fromStream(response).then((value) {
            try {
              //print(value.body);
              // setState(() {
              //   Loader.hideLoader(loader);
              // });
              var data = jsonDecode(value.body);
              print(data);
              Fluttertoast.showToast(msg: 'Profile Updated');
              print("_______________________");
              print(data['data']['id'].toString());
              Shared.pref
                  .setString("UserName", data['data']['name'].toString());
              Shared.pref
                  .setString("mobileNumber", data['data']['phone'].toString());
              Shared.pref
                  .setString("UserEmail", data['data']['email'].toString());
              Shared.pref.setString(
                  "PROFILE_IMAGE", data['data']['profile_image'].toString());

<<<<<<< HEAD
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (BuildContext context) {
                return Profile();
              }));
=======
              // Navigator.pushReplacement(context,
              //     MaterialPageRoute(builder: (BuildContext context) {
              //   return Profile();
              // }));
              Navigator.pop(context);
>>>>>>> d06bd2fee0f4c9bb3f5c8ab81bac27d6a822498d
            } catch (error) {
              print("error data $error");
            }
          })
        });
//    ApiRepository().createShop(modal)
//    user_id:13
// shop_name:sdfsdkjxzhkjzxczx
// owner_name:dfskdjhfksjdhfk
// business_type:1dsfsd
// categories:[1,4,5,6]
// contact_number:9898767543
// address:Indore
// website_url:
// gst_number:
// personal_kyc_doc_name:
// personal_kyc_doc_number:
// business_kyc_doc_name:
// business_kyc_doc_number:
  }

  @override
  void initState() {
    var name = Shared.pref.getString('UserName').toString().isNotEmpty
        ? Shared.pref.getString('UserName').toString()
        : '';
    var useremail = Shared.pref.getString('UserEmail').toString().isNotEmpty
        ? Shared.pref.getString('UserEmail').toString()
        : '';
    var email2 = Shared.pref.getString('UserEmail').toString();
    if (email2 == null || email2 == "null") {
      email2 = "";
    }
    userName.text = name;
    email.text = email2;
  }

  @override
  Widget build(BuildContext context) {
    loader = Loader.overlayLoader(context);
    var profile_img_var;

<<<<<<< HEAD
    if (Shared.pref.getString("PROFILE_IMAGE").toString() == "") {
      profile_img_var =
          "https://th.bing.com/th/id/OIP.kcaJsnMsMsFRdU6d1m2v6AHaHa?pid=ImgDet&rs=1";
    } else {
      profile_img_var = Shared.pref.getString("PROFILE_IMAGE").toString();
    }
=======
    // if (Shared.pref.getString("PROFILE_IMAGE").toString() == "") {
    //   profile_img_var =
    //       "https://th.bing.com/th/id/OIP.kcaJsnMsMsFRdU6d1m2v6AHaHa?pid=ImgDet&rs=1";
    // } else {
    //   profile_img_var = Shared.pref.getString("PROFILE_IMAGE").toString();
    // }
>>>>>>> d06bd2fee0f4c9bb3f5c8ab81bac27d6a822498d
    var height = AppBar().preferredSize.height;
    return Scaffold(
        body: Form(
      key: _formKey,
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.25,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Image.asset(
                              'assets/images/back1.png',
                              scale: 1.2,
                            )),
                        Column(
                          children: [
                            CircleAvatar(
<<<<<<< HEAD
                              radius: 35,
                              backgroundColor: DarkBlue,
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(40),
                                  child: personalProfilepath.toString() != ""
                                      ? Image.file(
                                          File(personalProfilepath),
                                          scale: 1.5,
                                          fit: BoxFit.cover,
                                        )
                                      : Image.network(profile_img_var.toString()

                                          // Shared.pref
                                          //     .getString("PROFILE_IMAGE")
                                          //     .toString(),
                                          // fit: BoxFit.cover,
                                          )),
=======
                              maxRadius: 35,
                              foregroundImage:
                                  Shared.pref.getString("PROFILE_IMAGE") != ""
                                      ? NetworkImage(Shared.pref
                                          .getString("PROFILE_IMAGE")
                                          .toString())
                                      : NetworkImage(PROFILE_PLACE_HOLDER),
>>>>>>> d06bd2fee0f4c9bb3f5c8ab81bac27d6a822498d
                            ),

                            // CircleAvatar(
                            //   radius: 35,
                            //   backgroundColor: DarkBlue,
                            //   child:
                            //   ClipRRect(
                            //       borderRadius: BorderRadius.circular(40),
                            //       child: personalProfilepath
                            //           .toString()!=""
                            //           ? Image.file(File(personalProfilepath),scale: 1.5,fit: BoxFit.cover,)
                            //           : Image.network(profile_img_var.toString()

                            //         // Shared.pref
                            //         //     .getString("PROFILE_IMAGE")
                            //         //     .toString(),
                            //         // fit: BoxFit.cover,
                            //       )),
                            // ),
                            SizedBox(
                              height: 10,
                            ),
                            GestureDetector(
                              onTap: () {
                                getPersonalKycImage();
                              },
                              child: Text(
                                "Change Picture",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline1!
                                    .copyWith(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        color: DarkBlue),
                              ),
                            )
                          ],
                        ),
                        Icon(
                          Icons.edit,
                          color: Colors.white,
                          size: 30,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
                child: Container(
              width: MediaQuery.of(context).size.width * 1,
              decoration: BoxDecoration(
                  color: lightBlue,
                  borderRadius:
                      BorderRadius.only(topLeft: Radius.circular(70))),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: 50,
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Name',
                            style: Theme.of(context)
                                .textTheme
                                .headline1!
                                .copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: DarkBlue,
                                    fontSize: 20),
                          ),
                          // SizedBox(width: 20,),

                          InputField(
                            controller: userName,

                            //initialValue: Shared.pref.getString("UserName").toString(),
                            onChanged: (val) {
                              setState(() {
                                Name = val;
                              });
                            },
                            width: MediaQuery.of(context).size.width * 0.62,
                            validator: (value) {
                              if (value == null) {
                                return "Enter Name";
                              } else if (value.isEmpty) {
                                return "Enter Name";
                              }
                            },
                            keyboardType: TextInputType.emailAddress,
                            IsBorder: true,
                            hint: Shared.pref.getString('UserName').toString(),
                            IsStyle: true,
                            style: Theme.of(context)
                                .textTheme
                                .headline1!
                                .copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: orange.withOpacity(0.5),
                                    fontSize: 16),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Email',
                            style: Theme.of(context)
                                .textTheme
                                .headline1!
                                .copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: DarkBlue,
                                    fontSize: 20),
                          ),
                          // SizedBox(width: 20,),
                          InputField(
                            controller: email,
                            // initialValue: Email,
                            onChanged: (val) {
                              setState(() {
                                Email = val;
                              });
                            },
                            width: MediaQuery.of(context).size.width * 0.62,
                            // validator: (value) {
                            //   if (value == null) {
                            //     return "Enter Email";
                            //   } else if (value.isEmpty) {
                            //     return "Enter Email";
                            //   } else if (!emailRegex.hasMatch(value)) {
                            //     return 'Please Enter valid Email';
                            //   }
                            // },
                            keyboardType: TextInputType.emailAddress,
                            IsBorder: true,
                            hint: Shared.pref.getString('UserEmail') != "null"
                                ? Shared.pref.getString('UserEmail').toString()
                                : "Enter email",
                            IsStyle: true,
                            style: Theme.of(context)
                                .textTheme
                                .headline1!
                                .copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: orange.withOpacity(0.5),
                                    fontSize: 16),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Contact',
                            style: Theme.of(context)
                                .textTheme
                                .headline1!
                                .copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: DarkBlue,
                                    fontSize: 20),
                          ),
                          // SizedBox(width: 20,),
                          Container(
                            height: 60,
                            decoration: BoxDecoration(
                                color: color,
                                borderRadius: BorderRadius.circular(30)),
                            width: MediaQuery.of(context).size.width * 0.6,
<<<<<<< HEAD
                            child: Padding(
                              padding: const EdgeInsets.all(15),
                              child: Text(
                                Shared.pref
                                    .getString('mobileNumber')
                                    .toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .headline1!
                                    .copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: DarkBlue,
                                        fontSize: 16),
=======
                            child: Center(
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0),
                                    child: Text(
                                      Shared.pref
                                          .getString('mobileNumber')
                                          .toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline1!
                                          .copyWith(
                                              fontWeight: FontWeight.bold,
                                              color: DarkBlue,
                                              fontSize: 16),
                                    ),
                                  ),
                                ],
>>>>>>> d06bd2fee0f4c9bb3f5c8ab81bac27d6a822498d
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     Text(
                      //       'City',
                      //       style: Theme.of(context)
                      //           .textTheme
                      //           .headline1!
                      //           .copyWith(
                      //               fontWeight: FontWeight.bold,
                      //               color: orange,
                      //               fontSize: 20),
                      //     ),
                      //     Container(
                      //       height: 60,
                      //       decoration: BoxDecoration(
                      //           color: color,
                      //           borderRadius: BorderRadius.circular(20)),
                      //       width: MediaQuery.of(context).size.width * 0.6,
                      //       child: Padding(
                      //         padding: const EdgeInsets.all(15),
                      //         child: Text(
                      //           "Udaipur",
                      //           style: Theme.of(context)
                      //               .textTheme
                      //               .headline1!
                      //               .copyWith(
                      //                   fontWeight: FontWeight.bold,
                      //                   color: orange,
                      //                   fontSize: 16),
                      //         ),
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      SizedBox(
                        height: 50,
                      ),
                      InkWell(
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            Overlay.of(context)!.insert(loader);

                            updateProfileApi();
                            Loader.hideLoader(loader);
                          }
                          ;
                        },
                        child: ColorButton(
                          RoundCorner: true,
                          width: 200,
                          colorValue: DarkBlue,
                          title: 'Update',
                        ),
                      )
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

  Future getPersonalKycImage() async {
    PickedFile? image = await imagePicker.getImage(source: ImageSource.gallery);

    if (image == null) {
      Fluttertoast.showToast(msg: "Profile Image Not Selected");
    } else {
      setState(() {
        //shopImages.add(File(image.path));
        personalProfilefile = File(image.path);
        personalProfilepath = image.path;
        print(personalProfilepath);
        Fluttertoast.showToast(msg: "Profile Image Selected");
      });
    }
  }
}
