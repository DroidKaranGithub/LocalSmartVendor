import 'package:shop_project/DashboardScreens/Wallet/CommonWidgets/Commonwidgets.dart';
import 'package:shop_project/DashboardScreens/Wallet/coupons/Coupon%20UI/VerifyCouponpage.dart';
import 'package:flutter/material.dart';

import '../../../../ConstantDrawer.dart';

class buyCouponsPage extends StatefulWidget {
  @override
  _buyCouponsPageState createState() => _buyCouponsPageState();
}

class _buyCouponsPageState extends State<buyCouponsPage> {
  var height;
  final GlobalKey<ScaffoldState> _key1 = GlobalKey();

  bool isVisible = false;
  bool isVisiblea = false;
  bool isVisibleb = false;
  bool isVisiblebc = false;
  var selectedType;
  static List<String> _TypeDropDown = <String>[
    "Buy 1 Get 1 Free",
    "Buy 2 Get 1 Free",
    "Buy 3 Get 2 Free",
    "Others"
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      key: _key1,
      drawerEnableOpenDragGesture: false,
      drawer: drawer(),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BuyCouponsFormUI(),
          ],
        ),
      ),
    ));
  }

  Widget BuyCouponsFormUI() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(top: 30.0, left: 16.0),
          child: Row(
            children: [
              IconButton(
                  onPressed: () {
                    _key1.currentState!.openDrawer();
                  },
                  icon: Icon(
                    Icons.menu,
                    size: 30,
                    color: Color(0xff09098A),
                  )),
              Expanded(
                child: Container(
                    padding: EdgeInsets.only(right: 64.0, top: 4.0),
                    alignment: Alignment.center,
                    child: Text(
                      "Buy Coupons",
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                          color: Color(0xff09098A)),
                    )),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 28.0, left: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Type: ",
                style: commonTextStyles(),
              ),
              SizedBox(
                width: 15.0,
              ),
              Expanded(
                child: Card(
                  shape: commonCardStyle(),
                  elevation: 5.0,
                  child: DropdownButtonHideUnderline(
                    child: DropdownButtonFormField(
                      isExpanded: true,
                      items: _TypeDropDown.map(
                        (value) => DropdownMenuItem(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 32.0),
                            child: Text(
                              value,
                              style: TextStyle(
                                fontSize: 16,
                                color: Color(0xff09098A),
                              ),
                            ),
                          ),
                          value: value,
                        ),
                      ).toList(),
                      validator: (value) => value == null ? "--Select--" : null,
                      onChanged: (_TypeDropDown) {
                        setState(() {
                          selectedType = _TypeDropDown;
                          selectedType == "Others" ? isVisible = true : "";
                          selectedType == "Buy 1 Get 1 Free"
                              ? isVisible = false
                              : "";
                          selectedType == "Buy 2 Get 1 Free"
                              ? isVisible = false
                              : "";
                          selectedType == "Buy 3 Get 2 Free"
                              ? isVisible = false
                              : "";
                        });
                      },
                      value: selectedType,
                      hint: Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: Text(
                          "--Select--",
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white, width: 1),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white, width: 1),
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Visibility(
          visible: isVisible,
          child: Container(
            margin: EdgeInsets.only(top: 28.0, left: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Other (Please specify)",
                  style: commonTextStyles(),
                ),
                Card(
                  margin: EdgeInsets.all(8.0),
                  shape: commonCardStyle(),
                  elevation: 5.0,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      cursorHeight: 25,
                      maxLines: 2,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        // Container(
        //   margin: EdgeInsets.only(top: 28.0, left: 16.0),
        //   child: Column(
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //
        //     children: [
        //       Text(
        //         "Other (Please specify)",
        //         style: commonTextStyles(),
        //       ),
        //       Card(
        //         margin: EdgeInsets.all(8.0),
        //         shape: commonCardStyle(),
        //         elevation: 5.0,
        //         child: Padding(
        //           padding: const EdgeInsets.all(8.0),
        //           child: TextField(
        //             cursorHeight: 25,
        //             maxLines: 2,
        //             decoration: InputDecoration(
        //               border: InputBorder.none,
        //             ),
        //           ),
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
        Container(
          margin: EdgeInsets.only(top: 28.0, left: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Description",
                style: commonTextStyles(),
              ),
              Card(
                margin: EdgeInsets.all(8.0),
                shape: commonCardStyle(),
                elevation: 5.0,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    cursorHeight: 25,
                    maxLines: 2,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 28.0, left: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Number of coupons",
                style: commonTextStyles(),
              ),
              Card(
                margin: EdgeInsets.all(8.0),
                shape: commonCardStyle(),
                elevation: 5.0,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    cursorHeight: 25,
                    maxLines: 1,
                    decoration: InputDecoration(
                      suffixIcon: Column(
                        children: [
                          Icon(Icons.keyboard_arrow_up),
                          Icon(Icons.keyboard_arrow_down),
                        ],
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        Container(
          margin: EdgeInsets.only(top: 28.0, left: 16.0),
          child: Row(
            children: [
              Text(
                "Total Price : ",
                style: commonTextStyles(),
              ),
              Text(
                "Rs 100",
                style: TextStyle(color: Color(0xffff09098A)),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),

        Center(
          child: Container(
            margin: EdgeInsets.only(top: 28.0, left: 16.0),
            child: ElevatedButton.icon(
                style: commonBlueButtons(),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => VerifyCouponPage()));
                },
                icon: Icon(
                  Icons.shopping_cart,
                  color: Color(0xffffffff),
                ),
                label: Text(
                  "Buy",
                  style: commonBlueButtonTextStyles(),
                )),
          ),
        ),
      ],
    );
  }
}
