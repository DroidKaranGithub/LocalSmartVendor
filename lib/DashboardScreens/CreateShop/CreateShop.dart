// import 'dart:io';

// import 'package:client_ajay_user_panel/ConstantDrawer.dart';
// import 'package:client_ajay_user_panel/Constants/ColorButton.dart';
// import 'package:client_ajay_user_panel/Constants/Constant.dart';
// import 'package:client_ajay_user_panel/DashboardScreens/Ask/AskForm/AskForm.dart';
// import 'package:client_ajay_user_panel/DashboardScreens/Ask/Coupons.dart';
// import 'package:client_ajay_user_panel/DashboardScreens/Inquries/Inquries.dart';
// import 'package:client_ajay_user_panel/DashboardScreens/Responses/Responses.dart';
// import 'package:client_ajay_user_panel/DashboardScreens/Shop/Shop.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';

// //import 'Recording/Recording.dart'website

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:searchfield/searchfield.dart';
import 'package:shop_project/Constants/LoaderClass.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:shop_project/ConstantDrawer.dart';
import 'package:shop_project/Constants/ColorButton.dart';
import 'package:shop_project/Constants/Constant.dart';
import 'package:shop_project/DashboardScreens/CreateShop/CategoryModalClass.dart';
import 'package:shop_project/DashboardScreens/ShopList/shopList.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_project/ApiRepository/ApiRepository.dart';

class CreateShop extends StatefulWidget {
  static String id = "Ask";
  @override
  _CreateShopState createState() => _CreateShopState();
}

class _CreateShopState extends State<CreateShop> {
  final _FormKey = GlobalKey<FormState>();
  bool isLoading = false;
  String? userId;
  File? bussinessKycfile;
  File? personalKycfile;
  String bussinessKycpath = "";
  String personalKycpath = "";
  var imagePicker = ImagePicker();
  List<File> shopImages = [];
  List<String> category = [];
  List<String> categoryID = [];
  bool productCheck = false;
  bool serviceCheck = false;
  String productData = "";
  String ServiceData = "";
  String chooseCategory = "--Choose Category--";
  String? chooseCategoryId;
  String personalKyc = "--Select--";
  String bussinessKyc = "--Select--";
  TextEditingController shopName = TextEditingController();
  TextEditingController ownerName = TextEditingController();
  TextEditingController contactNumber = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController shopAddress = TextEditingController();
  TextEditingController websiteUrl = TextEditingController();
  TextEditingController gstNumber = TextEditingController();

  Future createShopApi(chooseCategoryId) async {
    setState(() {
      isLoading = true;
    });
    print("create shop choose id is ${chooseCategoryId.toString()}");

    String url = BaseUrl + "shop/store";

    var request = http.MultipartRequest("POST", Uri.parse(url));
    print(userId);

    request.fields['user_id'] = userId.toString();
    request.fields['shop_name'] = shopName.text;
    request.fields['owner_name'] = ownerName.text;
    request.fields['email'] = email.text;
    request.fields['business_type'] =
        "${productData.toString()} ${ServiceData.toString()}";

    request.fields['categories'] = [chooseCategoryId].toList().toString();
    request.fields['contact_number'] = contactNumber.text.toString();
    request.fields['address'] = shopAddress.text;

    request.fields['website_url'] = websiteUrl.text.toString();
    request.fields['gst_number'] = gstNumber.text.toString();
    request.fields['personal_kyc_doc_name'] = personalKyc.toString();

    if (personalKycpath.isNotEmpty && bussinessKycpath.isNotEmpty) {
      var personal_kyc_doc = await http.MultipartFile.fromPath(
          "personal_kyc_doc", (personalKycpath));
      request.files.add(personal_kyc_doc);

      var business_kyc_doc = await http.MultipartFile.fromPath(
          "business_kyc_doc", (bussinessKycpath));
      request.files.add(business_kyc_doc);
    }
    //business_kyc_doc

    request.fields['personal_kyc_doc_number'] = "";
    request.fields['business_kyc_doc_name'] = bussinessKyc.toString();
    request.fields['business_kyc_doc_number'] = "";
    //shop_images[0]

    // var shop_images1 =
    //     await http.MultipartFile.fromPath("shop_images[0]", shopImages[0].path);
    // request.files.add(shop_images1);
    // var shop_images2 =
    //     await http.MultipartFile.fromPath("shop_images[1]", shopImages[1].path);
    // request.files.add(shop_images2);

    if (shopImages.isNotEmpty) {
      for (var i = 0; i < shopImages.length; i++) {
        var shop_images = await http.MultipartFile.fromPath(
            "shop_images[$i]", shopImages[i].path);
        request.files.add(shop_images);
      }
    }
    print(request.files);
    print(request.fields);
    // if (shopImages.isEmpty ||
    //     shopImages[0].path.toString().isEmpty ||
    //     shopImages[1].path.toString().isEmpty) {
    //   print("object");
    // } else {

    //   // var shop_images2 = await http.MultipartFile.fromPath(
    //   //     "shop_images[1]", shopImages[1].path);
    //   // request.files.add(shop_images2);
    // }

    print(request.fields);
    print(request.files);
    print(url);
    request.send().then((response) => {
          http.Response.fromStream(response).then((value) {
            setState(() {
              isLoading = false;
            });
            try {
              //print(value.body);
              // setState(() {
              //   Loader.hideLoader(loader);
              // });
              var data = jsonDecode(value.body);
              print(data);
              // Fluttertoast.showToast(msg: data["message"]);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Colors.red,
                  content: Text(
                    data["message"],
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                    ),
                  ),
                ),
              );
              print("_______________________");
              print(data['id'].toString());
              Shared.pref.setString("shopId", data['id'].toString());

              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (BuildContext context) {
                return ShopList();
              }));
            } catch (error) {
              print("error data $error");
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Colors.red,
                  content: Text(
                    error.toString(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                    ),
                  ),
                ),
              );
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

  Future getBussinessKycImage() async {
    var image = await imagePicker.getImage(source: ImageSource.gallery);
    if (image == null) {
      Fluttertoast.showToast(msg: "Document Not Selected");
    } else {
      setState(() {
        //shopImages.add(File(image.path));
        bussinessKycfile = File(image.path);
        bussinessKycpath = image.path;
        Fluttertoast.showToast(msg: "Document Selected");
      });
    }
  }

  Future getPersonalKycImage() async {
    PickedFile? image = await imagePicker.getImage(source: ImageSource.gallery);

    if (image == null) {
      Fluttertoast.showToast(msg: "Document Not Selected");
    } else {
      setState(() {
        //shopImages.add(File(image.path));
        personalKycfile = File(image.path);
        personalKycpath = image.path;
        Fluttertoast.showToast(msg: "Document Selected");
      });
    }
  }

  Future getImage() async {
    PickedFile? image = await imagePicker.getImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        shopImages.add(File(image.path));
        Fluttertoast.showToast(msg: "Image Selected");
      });
    } else {
      Fluttertoast.showToast(msg: "Image Not Selected");
    }
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

  void getUserId() async {
    SharedPreferences s = await SharedPreferences.getInstance();
    userId = s.getInt("userPerticularId").toString();
  }

  void getCattegoryData() {
    category.clear();
    categoryID.clear();
    ApiRepository().GetCategory().then((value) {
      var response = jsonDecode(value.body);
      print("cattegory Data ${response}");
      for (Map<String, dynamic> data in response['data']) {
        var categories = CategoryModalClass.fromJson(data);
        category.add(categories.name.toString());
        categoryID.add(categories.id.toString());
      }
      print(category);
      setState(() {});
    });
    setState(() {
      checkStatus = true;
    });
  }

  @override
  void initState() {
    super.initState();
    getUserId();
    getCattegoryData();
  }

  late OverlayEntry loader;
  DateTime? currentBackPressTime;
  var height;
  var checkStatus = false;
  final GlobalKey<ScaffoldState> _key1 = GlobalKey();
  @override
  Widget build(BuildContext context) {
    loader = Loader.overlayLoader(context);
    Loader.hideLoader(loader);
    height = AppBar().preferredSize.height;
    return WillPopScope(
        onWillPop: onWillPop,
        child: Stack(
          children: [
            Scaffold(
              key: _key1,
              backgroundColor: white,
              drawerEnableOpenDragGesture: false,
              drawer: drawer(),
              body: checkStatus
                  ? SingleChildScrollView(
                      //  physics: ScrollPhysics(),
                      child: Container(
                        //height: MediaQuery.of(context).size.height * 3,
                        //          width: MediaQuery.of(context).size.width * 1,
                        child: Form(
                          key: _FormKey,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 30,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                //color: Colors.red,
                                child: Row(
                                  //crossAxisAlignment: CrossAxisAlignment.start,
                                  //mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        _key1.currentState!.openDrawer();
                                      },
                                      icon: Icon(
                                        Icons.menu_rounded,
                                        color: DarkBlue,
                                      ),
                                    ),
                                    Expanded(
                                      flex: 10,
                                      child: Container(
                                        //color: Colors.green,
                                        child: Center(
                                          child: Text(
                                            'Create Shop',
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline1!
                                                .copyWith(
                                                    color: DarkBlue,
                                                    fontSize: 30,
                                                    fontWeight:
                                                        FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Column(
                                        children: [
                                          //wallet
                                          InkWell(
                                              child: Image.asset(
                                                  'assets/images/edit.png')),
                                          // SizedBox(
                                          //   height: 5,
                                          // ),
                                          // Row(
                                          //   mainAxisAlignment: MainAxisAlignment.center,
                                          //   children: [
                                          //     Image.asset('assets/images/rupee.png'),
                                          //     Text("10.05")
                                          //   ],
                                          // )
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: 15.0,
                                    ),
                                  ],
                                ),
                              ),
                              // Center(
                              //   child: Text(
                              //     'Welcome User !',
                              //     style: Theme.of(context).textTheme.headline1!.copyWith(
                              //         color: lightBlue,
                              //         fontSize: 17,
                              //         fontWeight: FontWeight.bold),
                              //   ),
                              // ),
                              SizedBox(
                                height: 20,
                              ),
                              SingleChildScrollView(
                                physics: ScrollPhysics(),
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height * 1.3,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 5),
                                  //color: Colors.red,
                                  child: Container(
                                    //color: Colors.red,
                                    //padding: EdgeInsets.only(bottom: 10),

                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                'Shop Name',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline1!
                                                    .copyWith(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: DarkBlue,
                                                        fontSize: 18),
                                              ),
                                            ),
                                            // SizedBox(
                                            //   width: 20,
                                            // ),
                                            Expanded(
                                              child: TextFormField(
                                                validator: (value) {
                                                  if (value
                                                      .toString()
                                                      .isEmpty) {
                                                    return "Shop Name Can't Be Empty";
                                                  }
                                                },
                                                autocorrect: false,
                                                //textDirection: TextDirection.ltr,

                                                controller: shopName,
                                                // onChanged: (value) {
                                                //   print(value);
                                                //   shopName.text = value;
                                                // },
                                                inputFormatters: [
                                                  FilteringTextInputFormatter
                                                      .allow(
                                                          RegExp(r'[a-zA-Z ]'))
                                                ],
                                                decoration: InputDecoration(
                                                    hintText: "Shop Name",
                                                    hintStyle: TextStyle(
                                                        color: lightBlue),
                                                    contentPadding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 10,
                                                            vertical: 10),
                                                    border: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    10)))),
                                              ),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                'Owner Name',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline1!
                                                    .copyWith(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: DarkBlue,
                                                        fontSize: 18),
                                              ),
                                            ),
                                            Expanded(
                                              child: TextFormField(
                                                validator: (value) {
                                                  if (value
                                                      .toString()
                                                      .isEmpty) {
                                                    return "Owner Name Can't Be Empty";
                                                  }
                                                  return null;
                                                },
                                                autocorrect: false,
                                                controller: ownerName,
                                                onChanged: (value) {
                                                  print(value);
                                                },
                                                inputFormatters: [
                                                  FilteringTextInputFormatter
                                                      .allow(
                                                          RegExp(r'[a-zA-Z ]'))
                                                ],
                                                decoration: InputDecoration(
                                                    hintText: "Owner Name",
                                                    hintStyle: TextStyle(
                                                        color: lightBlue),
                                                    contentPadding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 10,
                                                            vertical: 10),
                                                    border: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    10)))),
                                              ),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                'Business Type',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline1!
                                                    .copyWith(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: DarkBlue,
                                                        fontSize: 18),
                                              ),
                                            ),
                                            // Expanded(
                                            //     child: Checkbox(
                                            //         activeColor: lightBlueWithLowOpacity,
                                            //         value: false,
                                            //         onChanged: (value) {
                                            //           setState(() {

                                            //           });
                                            //         }
                                            //         ),

                                            //     // child: TextField(
                                            //     //   decoration: InputDecoration(
                                            //     //       hintText: "Bussiness Name",
                                            //     //       hintStyle: TextStyle(color: lightBlue),
                                            //     //       contentPadding: EdgeInsets.symmetric(
                                            //     //           horizontal: 10, vertical: 10),
                                            //     //       border: OutlineInputBorder(
                                            //     //           borderRadius: BorderRadius.all(
                                            //     //               Radius.circular(10)))

                                            //     //               ),
                                            //     // ),
                                            //     )
                                            Checkbox(
                                                activeColor: lightBlue,
                                                value: productCheck,
                                                onChanged: (value) {
                                                  setState(() {
                                                    productCheck = value!;
                                                    productData = "Product";
                                                  });
                                                }),
                                            Text(
                                              "Product",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline1!
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: DarkBlue,
                                                      fontSize: 16),
                                            ),
                                            Checkbox(
                                                activeColor: lightBlue,
                                                value: serviceCheck,
                                                onChanged: (value) {
                                                  setState(() {
                                                    serviceCheck = value!;
                                                    ServiceData = "Services";
                                                  });
                                                }),
                                            Text(
                                              "Services",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline1!
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: DarkBlue,
                                                      fontSize: 16),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              flex: 2,
                                              child: Text(
                                                'Choose Category',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline1!
                                                    .copyWith(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: DarkBlue,
                                                        fontSize: 18),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 2,
                                              child: SearchField(
                                                suggestions: category,
                                                hint: "Search Category",
                                                maxSuggestionsInViewPort: 6,
                                                validator: (x) {
                                                  if (!category.contains(x)) {
                                                    return 'Please Enter a valid category';
                                                  }
                                                  return null;
                                                },
                                                onTap: (value) {
                                                  setState(() {
                                                    print(value.toString());
                                                    chooseCategory = value!;
                                                    chooseCategoryId = category
                                                        .indexOf(value)
                                                        .toString();

                                                    print(categoryID[int.parse(
                                                            chooseCategoryId!)]
                                                        .toString());
                                                    // print(
                                                    //     int.parse(chooseCategoryId!) +
                                                    //         1);
                                                  });
                                                },
                                              ),
                                            )
                                            // DropdownButton<String>(
                                            //   hint: Text(chooseCategory),
                                            //   style: Theme.of(context)
                                            //       .textTheme
                                            //       .headline1!
                                            //       .copyWith(
                                            //           fontWeight: FontWeight.bold,
                                            //           color: DarkBlue,
                                            //           fontSize: 16),
                                            //   items: category.map((value) {
                                            //     return DropdownMenuItem<String>(
                                            //       value: value,
                                            //       child: Text(value),
                                            //     );
                                            //   }).toList(),
                                            //   onChanged: (value) {
                                            //     print(value);
                                            //     setState(() {
                                            //       chooseCategory = value!;
                                            //       chooseCategoryId = category
                                            //           .indexOf(value)
                                            //           .toString();

                                            //       print(chooseCategory);
                                            //       print(int.parse(chooseCategoryId!) +
                                            //           1);
                                            //     });
                                            //   },
                                            // )
                                          ],
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                'Contact Number',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline1!
                                                    .copyWith(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: DarkBlue,
                                                        fontSize: 18),
                                              ),
                                            ),
                                            Expanded(
                                              child: TextFormField(
                                                validator: (value) {
                                                  if (value
                                                      .toString()
                                                      .isEmpty) {
                                                    return "Contact Number Can't Be Empty";
                                                  }
                                                },
                                                autocorrect: false,
                                                maxLength: 10,
                                                keyboardType:
                                                    TextInputType.phone,
                                                controller: contactNumber,
                                                inputFormatters: [
                                                  FilteringTextInputFormatter
                                                      .allow(RegExp(r'[0-9]'))
                                                ],
                                                decoration: InputDecoration(
                                                    hintText: "Contact Number",
                                                    hintStyle: TextStyle(
                                                        color: lightBlue),
                                                    contentPadding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 10,
                                                            vertical: 10),
                                                    border: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    10)))),
                                              ),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                'Email(Optional)',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline1!
                                                    .copyWith(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: DarkBlue,
                                                        fontSize: 18),
                                              ),
                                            ),
                                            // SizedBox(width: 20,),
                                            Expanded(
                                              child: TextFormField(
                                                autocorrect: false,
                                                // onChanged: (value) {
                                                //   bool emailValid = RegExp(
                                                //           r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                                //       .hasMatch(value);
                                                //   print(emailValid);
                                                //   if (emailValid != true) {
                                                //     Fluttertoast.showToast(
                                                //         msg: "Invalid Email");
                                                //   }
                                                // },
                                                controller: email,
                                                inputFormatters: [
                                                  FilteringTextInputFormatter
                                                      .allow(RegExp(
                                                          r'[a-z0-9A-Z@.]'))
                                                ],
                                                decoration: InputDecoration(
                                                    hintText: "Email",
                                                    hintStyle: TextStyle(
                                                        color: lightBlue),
                                                    contentPadding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 10,
                                                            vertical: 10),
                                                    border: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    10)))),
                                              ),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                'Shop Address',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline1!
                                                    .copyWith(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: DarkBlue,
                                                        fontSize: 18),
                                              ),
                                            ),
                                            // SizedBox(width: 20,),
                                            Expanded(
                                              child: TextFormField(
                                                validator: (value) {
                                                  if (value
                                                      .toString()
                                                      .isEmpty) {
                                                    return "Shop Address Can't Be Empty";
                                                  }
                                                },
                                                autocorrect: false,
                                                controller: shopAddress,
                                                decoration: InputDecoration(
                                                    hintText: "Shop Address",
                                                    hintStyle: TextStyle(
                                                        color: lightBlue),
                                                    contentPadding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 10,
                                                            vertical: 10),
                                                    border: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    10)))),
                                              ),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                'Website URL(Optional)',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline1!
                                                    .copyWith(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: DarkBlue,
                                                        fontSize: 18),
                                              ),
                                            ),
                                            // SizedBox(width: 20,),
                                            Expanded(
                                              child: TextFormField(
                                                autocorrect: false,
                                                controller: websiteUrl,
                                                decoration: InputDecoration(
                                                    hintText: "Website URL",
                                                    hintStyle: TextStyle(
                                                        color: lightBlue),
                                                    contentPadding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 10,
                                                            vertical: 10),
                                                    border: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    10)))),
                                              ),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                'GST Number (Optional)',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline1!
                                                    .copyWith(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: DarkBlue,
                                                        fontSize: 16),
                                              ),
                                            ),
                                            // SizedBox(width: 20,),
                                            Expanded(
                                              child: TextFormField(
                                                // validator: (value){
                                                //   if(value.toString().isEmpty){
                                                //     return "GST Number Can't Be Empty";
                                                //   }
                                                // },
                                                controller: gstNumber,
                                                decoration: InputDecoration(
                                                    hintText: "GST Number",
                                                    hintStyle: TextStyle(
                                                        color: lightBlue),
                                                    contentPadding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 10,
                                                            vertical: 10),
                                                    border: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    10)))),
                                              ),
                                            )
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 20.0, bottom: 10.0),
                                          child: Row(
                                            children: [
                                              Text(
                                                'Personal KYC',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline1!
                                                    .copyWith(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: DarkBlue,
                                                        fontSize: 20),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              flex: 2,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 32.0),
                                                child: DropdownButtonFormField<
                                                    String>(
                                                  //   validator: (value)=> value == null ? "Select Personal KYC" : null,

                                                  isExpanded: true,
                                                  //elevation: 5,
                                                  hint: Text(
                                                    personalKyc,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headline1!
                                                        .copyWith(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: DarkBlue,
                                                            fontSize: 18),
                                                  ),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline1!
                                                      .copyWith(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: DarkBlue,
                                                          fontSize: 16),
                                                  items: <String>[
                                                    'Aadhar Card',
                                                    'PAN',
                                                    'Driving Licence',
                                                    'Other'
                                                  ].map((String value) {
                                                    return DropdownMenuItem<
                                                        String>(
                                                      value: value,
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(value),
                                                          //        Icon(Icons.arrow_right)
                                                        ],
                                                      ),
                                                    );
                                                  }).toList(),
                                                  onChanged: (value) {
                                                    print(value);
                                                    setState(() {
                                                      personalKyc = value!;
                                                    });
                                                  },
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: InkWell(
                                                onTap: () {
                                                  getPersonalKycImage();
                                                },
                                                child: ColorButton(
                                                  RoundCorner: true,
                                                  // width: 200,
                                                  colorValue: DarkBlue,
                                                  title: 'Upload',
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        (personalKycfile != null)
                                            ? Row(
                                                children: [
                                                  Text(
                                                    "$personalKyc : ${personalKycfile?.path.split("/").last.substring(12)} Selected",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headline1!
                                                        .copyWith(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: lightBlue,
                                                            fontSize: 12),
                                                    textAlign: TextAlign.start,
                                                  ),
                                                ],
                                              )
                                            : Container(),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 20.0, bottom: 10.0),
                                          child: Row(
                                            children: [
                                              Text(
                                                'Business KYC',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline1!
                                                    .copyWith(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: DarkBlue,
                                                        fontSize: 20),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              flex: 2,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 32.0),
                                                child: DropdownButton<String>(
                                                  isExpanded: true,
                                                  //elevation: 5,
                                                  hint: Text(
                                                    bussinessKyc,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headline1!
                                                        .copyWith(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: DarkBlue,
                                                            fontSize: 18),
                                                  ),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline1!
                                                      .copyWith(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: DarkBlue,
                                                          fontSize: 16),
                                                  items: <String>[
                                                    'Business Registration',
                                                    'GST Number',
                                                    'Other'
                                                  ].map((String value) {
                                                    return DropdownMenuItem<
                                                        String>(
                                                      value: value,
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(value),
                                                          //    Icon(Icons.arrow_right)
                                                        ],
                                                      ),
                                                    );
                                                  }).toList(),
                                                  onChanged: (value) {
                                                    print(value);
                                                    setState(() {
                                                      bussinessKyc = value!;
                                                    });
                                                  },
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: InkWell(
                                                onTap: () {
                                                  getBussinessKycImage();
                                                },
                                                child: ColorButton(
                                                  RoundCorner: true,
                                                  // width: 200,
                                                  colorValue: DarkBlue,
                                                  title: 'Upload',
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        (bussinessKycfile != null)
                                            ? Row(
                                                children: [
                                                  Text(
                                                    "$bussinessKyc : ${bussinessKycfile?.path.split("/").last.substring(12)} Selected",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headline1!
                                                        .copyWith(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: lightBlue,
                                                            fontSize: 12),
                                                    textAlign: TextAlign.start,
                                                  ),
                                                ],
                                              )
                                            : Container(),
                                        SizedBox(height: 10),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              flex: 2,
                                              child: Text(
                                                'Shop Image \n(minimum : 2)',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline1!
                                                    .copyWith(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: DarkBlue,
                                                        fontSize: 18),
                                              ),
                                            ),
                                            SizedBox(width: 5),
                                            Expanded(
                                              flex: 1,
                                              child: InkWell(
                                                onTap: () {
                                                  getImage();
                                                },
                                                child: ColorButton(
                                                  RoundCorner: true,
                                                  // width: 200,
                                                  colorValue: DarkBlue,
                                                  title: 'Upload',
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 10),
                                        (shopImages.isNotEmpty)
                                            ? Expanded(
                                                child: Container(
                                                  child: GridView.builder(
                                                      itemCount:
                                                          shopImages.length,
                                                      gridDelegate:
                                                          SliverGridDelegateWithFixedCrossAxisCount(
                                                              crossAxisCount:
                                                                  2),
                                                      itemBuilder:
                                                          (cnt, index) {
                                                        return Stack(children: [
                                                          Container(
                                                              //height: 20,
                                                              width: MediaQuery
                                                                      .of(
                                                                          context)
                                                                  .size
                                                                  .width,
                                                              margin: EdgeInsets
                                                                  .all(10.0),
                                                              decoration: BoxDecoration(
                                                                  color: Colors
                                                                      .grey
                                                                      .shade400,
                                                                  borderRadius:
                                                                      BorderRadius.all(Radius
                                                                          .circular(
                                                                              20))),
                                                              child: Image.file(
                                                                File(shopImages[
                                                                        index]
                                                                    .path),
                                                                fit: BoxFit
                                                                    .fitWidth,
                                                              )),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .end,
                                                            children: [
                                                              IconButton(
                                                                  onPressed:
                                                                      () {
                                                                    shopImages
                                                                        .removeAt(
                                                                            index);
                                                                    setState(
                                                                        () {});
                                                                  },
                                                                  icon: Icon(Icons
                                                                      .cancel_rounded)),
                                                            ],
                                                          )
                                                        ]);
                                                      }),
                                                ),
                                              )
                                            : Container(),
                                        SizedBox(
                                          height: 20.0,
                                        ),
                                        ElevatedButton(
                                          //                          widget: Icon(Icons.ac_unit),
                                          // RoundCorner: true,

                                          onPressed: () async {
                                            if (_FormKey.currentState!
                                                .validate()) {
                                              Overlay.of(context)!
                                                  .insert(loader);

                                              createShopApi(int.parse(
                                                  categoryID[int.parse(
                                                      chooseCategoryId!)]));
                                              Loader.hideLoader(loader);
                                            }

                                            // FocusScope.of(context).unfocus();
                                            // Overlay.of(context)!.insert(loader);

                                            //https://viragtea.com/localsmart/public/api/shops?user_id=47

                                            // Navigator.pushReplacement(context,
                                            //     MaterialPageRoute(
                                            //         builder: (BuildContext context) {
                                            //   return ShopList();
                                            // }));
                                            // FocusScope.of(context).unfocus();
                                            // Overlay.of(context)!.insert(loader);
                                            // if (shopName.text.isEmpty ||
                                            //     ownerName.text.isEmpty ||
                                            //     contactNumber.text.isEmpty ||
                                            //     shopAddress.text.isEmpty) {
                                            //   Fluttertoast.showToast(
                                            //       msg: "Field's cannot be empty",
                                            //       toastLength: Toast.LENGTH_SHORT);
                                            //   Loader.hideLoader(loader);
                                            // } else {
                                            //   createShopApi(int.parse(categoryID[
                                            //       int.parse(chooseCategoryId!)]));
                                            // }
                                            //     .then((value) => {Loader.hideLoader(loader)});
                                          },
                                          style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                      DarkBlue),
                                              fixedSize:
                                                  MaterialStateProperty.all(
                                                      Size(200, 50)),
                                              shape: MaterialStateProperty.all(
                                                  StadiumBorder())),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Image.asset(
                                                'assets/images/Arrow.png',
                                                color: Colors.white,
                                              ),
                                              Text(
                                                "Submit",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline1!
                                                    .copyWith(
                                                        color: Colors.white,
                                                        fontSize: 22,
                                                        letterSpacing: 1,
                                                        fontWeight:
                                                            FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                          // width: 200,
                                          //    height: 50,
                                          // colorValue: DarkBlue,
                                          // title: 'Create Shop',
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  : Center(
                      child: CircularProgressIndicator(
                        color: DarkBlue,
                      ),
                    ),
            ),
            if (isLoading)
              Center(
                child: Center(
                  child: CircularProgressIndicator(color: DarkBlue),
                ),
              )
          ],
        ));
  }
}
