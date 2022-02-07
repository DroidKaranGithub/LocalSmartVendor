// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:shop_project/ConstantDrawer.dart';
import 'package:shop_project/Constants/Constant.dart';
import 'package:shop_project/DashboardScreens/CreateShop/CreateShop.dart';
import 'package:shop_project/DashboardScreens/CreateShop/EditShop.dart';
import 'package:shop_project/DashboardScreens/Inquries/Inquries.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_project/DashboardScreens/Shop/ShopModalClass.dart';
import 'package:shop_project/DashboardScreens/ShopList/shopListModelClass.dart';

class ShopList extends StatefulWidget {
  static String id = "ShopList";
  @override
  _ShopListState createState() => _ShopListState();
}

class _ShopListState extends State<ShopList> {
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

  DateTime? currentBackPressTime;
  List<ShopListData> shopListData = [];
  List<ShopData> shopDataAll = [];

  var height;
  final GlobalKey<ScaffoldState> _key1 = GlobalKey();

  void getShopList() async {
    shopListData.clear();
    shopDataAll.clear();
    //https://viragtea.com/localsmart/public/api/shops?user_id=47
    //Shared.pref.setString("UserID", body1.id.toString());

    int? userId = Shared.pref.getInt("userPerticularId");
    print("my user id is $userId");
    String url =
        "https://viragtea.com/localsmart/public/api/shops?user_id=$userId&page=1";
    debugPrint("URL-->$url");
    var response = await Dio()
        .get(
      url,
    )
        .then((value) {
      print(value.data);
      //log(value.data['data'].toString());

      for (Map<String, dynamic> shopData in value.data['data']) {
        print("data : $shopData");
        setState(() {
          shopListData.add(ShopListData.fromJson(shopData));
          //shopDataAll.add(ShopData.fromJson(shopData));
        });
      }
    }).catchError((err) {
      print(err);
    });
    //print(response.data.toString());
    print(shopListData);
    setState(() {
      checkData = true;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getShopList();
  }

  bool checkData = false;
  @override
  Widget build(BuildContext context) {
    height = AppBar().preferredSize.height;
    return Scaffold(
      key: _key1,
      backgroundColor: white,
      drawerEnableOpenDragGesture: false,
      drawer: drawer(),
      body: SingleChildScrollView(
        //  physics: ScrollPhysics(),
        child: Container(
          height: MediaQuery.of(context).size.height * 1.1,
          width: MediaQuery.of(context).size.width * 2,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(
                  height: 30,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  //color: Colors.red,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                        onPressed: () {
                          _key1.currentState!.openDrawer();
                        },
                        icon: Icon(
                          Icons.menu_rounded,
                          size: 25,
                          color: DarkBlue,
                        ),
                      ),
                      // Expanded(
                      //   flex: 1,
                      //   child: Padding(
                      //     padding: const EdgeInsets.only(left: 16.0),
                      //     child: InkWell(
                      //         onTap: () {
                      //           _key1.currentState!.openDrawer();
                      //         },
                      //         child: Icon(
                      //           Icons.menu_rounded,
                      //           size: 30,
                      //           color: DarkBlue,
                      //         )),
                      //   ),
                      // ),
                      Expanded(
                        flex: 10,
                        child: Container(
                          //        color: Colors.green,
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                top: 8,
                                right: 30,
                              ),
                              child: Text(
                                'Shop List',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline1!
                                    .copyWith(
                                        color: DarkBlue,
                                        fontSize: 28,
                                        fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 40,
                      ),
                    ],
                  ),
                ),
                // SizedBox(
                //   height: 20,
                // ),
                checkData
                    ? Expanded(
                        flex: 4,
                        child: ListView.builder(
                            //reverse: true,
                            //shrinkWrap: true,
                            itemCount: shopListData.length,
                            itemBuilder: (cnt, index) {
                              return Container(
<<<<<<< HEAD
                                margin: EdgeInsets.all(20),
                                padding: EdgeInsets.all(10),
                                // ignore: prefer _const_constructors
                                decoration: BoxDecoration(
                                    // ignore: prefer_const_literals_to_create_immutables
                                    boxShadow: [
                                      BoxShadow(
                                          color: Color.fromRGBO(0, 0, 0, 0.2))
                                    ],
                                    // ignore: prefer _const_constructors
                                    color: Color.fromRGBO(237, 237, 237,
                                        1), //background: rgba(237, 237, 237, 1);

                                    borderRadius: BorderRadius.all(
                                        Radius.circular(10.0))),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Container(
//                                          color: Colors.red,
                                        padding: EdgeInsets.symmetric(
                                            vertical: 20, horizontal: 15),
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 10),
                                        //width: 50,
                                        //    height: 70,
                                        child: GestureDetector(
                                          onTap: () {
                                            // EditShop
                                            Navigator.push(context,
                                                MaterialPageRoute(
                                                    builder: (cnt) {
                                              return EditShop(
                                                  shop_id:
                                                      shopListData[index].id);
                                            }));
                                          },
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                shopListData[index]
                                                    .shop_name
=======
                                margin: EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 10,
                                ),
                                // padding: EdgeInsets.all(5),
                                // ignore: prefer _const_constructors
                                decoration: BoxDecoration(
                                  // ignore: prefer_const_literals_to_create_immutables
                                  boxShadow: [
                                    BoxShadow(
                                        color: Color.fromRGBO(0, 0, 0, 0.2))
                                  ],
                                  // ignore: prefer _const_constructors
                                  color: Color.fromRGBO(237, 237, 237,
                                      1), //background: rgba(237, 237, 237, 1);
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.0),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 20, horizontal: 10),
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      //width: 50,
                                      //    height: 70,
                                      child: GestureDetector(
                                        onTap: () {
                                          // EditShop
                                          Navigator.push(context,
                                              MaterialPageRoute(builder: (cnt) {
                                            return EditShop(
                                              shop_id: shopListData[index].id,
                                            );
                                          }));
                                        },
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              shopListData[index]
                                                  .shop_name
                                                  .toString(),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline1!
                                                  .copyWith(
                                                      color: DarkBlue,
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold),
                                              textAlign: TextAlign.center,
                                            ),
                                            SizedBox(height: 5),
                                            Container(
                                              decoration: BoxDecoration(
                                                  // boxShadow: [
                                                  //   BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.2))
                                                  // ],
                                                  // shape: BoxShape.circle,
                                                  gradient: LinearGradient(
                                                    colors: [
                                                      Color.fromRGBO(
                                                          181, 197, 255, 1),
                                                      Color.fromRGBO(
                                                          111, 138, 235, 0),
                                                    ],
                                                  ),
                                                  // color: Color.fromRGBO(
                                                  //     225,
                                                  //     225,
                                                  //     238,
                                                  //     1), //background: rgba(237, 237, 237, 1);

                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              10.0))),
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10, vertical: 5),
                                              child: Text(
                                                shopListData[index]
                                                    .category
>>>>>>> d06bd2fee0f4c9bb3f5c8ab81bac27d6a822498d
                                                    .toString(),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline1!
                                                    .copyWith(
                                                        color: DarkBlue,
<<<<<<< HEAD
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                textAlign: TextAlign.center,
                                              ),
                                              SizedBox(height: 5),
                                              Container(
                                                decoration: BoxDecoration(
                                                    // boxShadow: [
                                                    //   BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.2))
                                                    // ],
                                                    // shape: BoxShape.circle,
                                                    gradient: LinearGradient(
                                                      colors: [
                                                        Color.fromRGBO(
                                                            181, 197, 255, 1),
                                                        Color.fromRGBO(
                                                            111, 138, 235, 0),
                                                      ],
                                                    ),
                                                    // color: Color.fromRGBO(
                                                    //     225,
                                                    //     225,
                                                    //     238,
                                                    //     1), //background: rgba(237, 237, 237, 1);

                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10.0))),
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 20,
                                                    vertical: 5),
                                                child: Text(
                                                  shopListData[index]
                                                      .category
                                                      .toString(),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline1!
                                                      .copyWith(
                                                          color: DarkBlue,
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                ),
                                              )
                                            ],
                                          ),
=======
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold),
                                              ),
                                            )
                                          ],
>>>>>>> d06bd2fee0f4c9bb3f5c8ab81bac27d6a822498d
                                        ),
                                        // color: Colors.blue,
                                      ),
<<<<<<< HEAD
                                    ),
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: () {
                                          print(
                                              "list shop ${shopListData[index].id.toString()}");
                                          Shared.pref.setString(
                                              "shopId",
                                              shopListData[index]
                                                  .id
                                                  .toString());
                                          Navigator.push(context,
                                              MaterialPageRoute(builder: (cnt) {
                                            return Inquries();
                                          }));
                                        },
=======
                                      // color: Colors.blue,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        print(
                                            "list shop ${shopListData[index].id.toString()}");
                                        Shared.pref.setString("shopId",
                                            shopListData[index].id.toString());
                                        Navigator.push(context,
                                            MaterialPageRoute(builder: (cnt) {
                                          return Inquries();
                                        }));
                                      },
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 10.0),
>>>>>>> d06bd2fee0f4c9bb3f5c8ab81bac27d6a822498d
                                        child: Container(
                                          child: CircleAvatar(
                                            backgroundColor: Colors.transparent,
                                            radius: 40,
                                            child: Container(
                                              padding: EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                gradient: LinearGradient(
                                                  colors: [
                                                    Color.fromRGBO(
                                                        181, 197, 255, 1),
                                                    Color.fromRGBO(
                                                        111, 138, 235, 0),
                                                  ],
                                                ),
                                              ),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    shopListData[index]
                                                        .inquiry
                                                        .toString(),
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headline1!
                                                        .copyWith(
                                                            color: DarkBlue,
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                  ),
                                                  Text(
                                                    "Enquiry",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headline1!
                                                        .copyWith(
                                                            color: DarkBlue,
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          //   color: Colors.yellow,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }),
                      )
                    : Container(
<<<<<<< HEAD
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              child: CircularProgressIndicator(),
                              height: 40,
                              width: 40,
                            )
                          ],
=======
                        child: Expanded(
                          child: Container(
                            child: Center(
                              child: CircularProgressIndicator(
                                color: DarkBlue,
                              ),
                            ),
                          ),
>>>>>>> d06bd2fee0f4c9bb3f5c8ab81bac27d6a822498d
                        ),
                      ),
                checkData
                    ? Expanded(
                        flex: 2,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (cnt) {
                                  return CreateShop();
                                }));
                              },
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(DarkBlue),
                                  fixedSize:
                                      MaterialStateProperty.all(Size(200, 20)),
                                  shape: MaterialStateProperty.all(
                                      StadiumBorder())),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'assets/images/Vector.png',
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    "Add Shop",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline1!
                                        .copyWith(
                                            color: Colors.white,
                                            fontSize: 22,
                                            letterSpacing: 1,
                                            fontWeight: FontWeight.bold),
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
                      )
                    : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
