import 'package:shop_project/DashboardScreens/Wallet/CommonWidgets/Commonwidgets.dart';
import 'package:shop_project/DashboardScreens/Wallet/coupons/Coupon%20UI/Buy1Get1page.dart';
import 'package:flutter/material.dart';
import 'package:shop_project/ConstantDrawer.dart';

class CouponsPage extends StatefulWidget {
  static String id = "/CouponsPage";
  @override
  _CouponsPageState createState() => _CouponsPageState();
}

class _CouponsPageState extends State<CouponsPage> {
  var height;
  final GlobalKey<ScaffoldState> _key1 = GlobalKey();

  @override
  Widget build(BuildContext context) {
    height = AppBar().preferredSize.height;
    return SafeArea(
        child: Scaffold(
      key: _key1,
      drawerEnableOpenDragGesture: false,
      drawer: drawer(),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            CouponsPageUi(),
          ],
        ),
      ),
    ));
  }

  Widget CouponsPageUi() {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width * 2,
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 28.0, left: 16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                      padding: EdgeInsets.only(right: 64.0),
                      alignment: Alignment.center,
                      child: Text(
                        "Coupons",
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w800,
                            color: Color(0xff09098A)),
                      )),
                )
              ],
            ),
          ),
          Center(
            child: Container(
                margin: EdgeInsets.only(top: 32.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton.icon(
                        style: commonSmallButtonStyle(),
                        onPressed: () {},
                        icon: Icon(
                          Icons.shopping_cart,
                          color: Color(0xff09098A),
                        ),
                        label: Text(
                          "BUY",
                          style: commonWhiteButtonTextStyles(),
                        )),
                    ElevatedButton.icon(
                        style: commonSmallButtonStyle(),
                        onPressed: () {},
                        icon: Icon(
                          Icons.check_sharp,
                          color: Color(0xff09098A),
                        ),
                        label: Text(
                          "Verify",
                          style: commonWhiteButtonTextStyles(),
                        ))
                  ],
                )),
          ),
          Container(child: CoupenDetailForm()),
          SizedBox(
            height: 35,
          ),
        ],
      ),
    );
  }

  Widget CoupenDetailForm() {
    return ListView.builder(
        itemCount: 1,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.all(16.0),
            child: Card(
              shape: commonCardStyle(),
              elevation: 10.0,
              shadowColor: Colors.grey,
              margin: EdgeInsets.all(16.0),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width / 3,
                            child: Text(
                              "Type: ",
                              style: commonTextStyles(),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              child: Text(
                                "Buy 2 Get 1 Free",
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.left,
                                style: commonTextStyles(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Description: ",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: commonTextStyles(),
                          ),
                          SizedBox(
                            width: 30.0,
                          ),
                          Container(
                            child: Expanded(
                              child: Text(
                                "Buy discounted product in multiples of 3 & get 33% off",
                                overflow: TextOverflow.ellipsis,
                                maxLines: 3,
                                softWrap: true,
                                style: TextStyle(
                                  color: Color(0xff09098A),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Total coupons: ",
                            style: commonTextStyles(),
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Expanded(
                            child: Text(
                              "10",
                              style: commonTextStyles(),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Date Created: ",
                            style: commonTextStyles(),
                          ),
                          SizedBox(
                            width: 20.0,
                          ),
                          Expanded(
                            child: Text(
                              "25-oct-21",
                              style: commonTextStyles(),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Coupon Used: ",
                                style: commonTextStyles(),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                "2",
                                style: commonTextStyles(),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text(
                            "Vallid upto: ",
                            style: commonTextStyles(),
                          ),
                          SizedBox(
                            width: 40,
                          ),
                          Text(
                            "25-Dec-21",
                            style: commonTextStyles(),
                          ),
                        ],
                      ),
                    ),
                    Center(
                      child: Container(
                        margin: EdgeInsets.only(top: 28.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton.icon(
                                style: commonBlueButtons(),
                                onPressed: () {},
                                icon: Icon(
                                  Icons.remove_red_eye_outlined,
                                  color: Color(0xffffffff),
                                ),
                                label: Text(
                                  "View",
                                  style: commonBlueButtonTextStyles(),
                                )),
                            ElevatedButton.icon(
                                style: commonBlueButtons(),
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          buyOneGetONePage()));
                                },
                                icon: Icon(
                                  Icons.check_sharp,
                                  color: Color(0xffffffff),
                                ),
                                label: Text(
                                  "Verify",
                                  style: commonBlueButtonTextStyles(),
                                ))
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
