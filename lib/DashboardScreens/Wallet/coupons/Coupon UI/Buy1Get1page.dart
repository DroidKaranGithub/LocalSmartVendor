import 'package:shop_project/Constants/Constant.dart';
import 'package:shop_project/DashboardScreens/Wallet/CommonWidgets/Commonwidgets.dart';
import 'package:shop_project/DashboardScreens/Wallet/coupons/Coupon%20UI/BuyCoupons.dart';
import 'package:flutter/material.dart';

import '../../../../ConstantDrawer.dart';

class buyOneGetONePage extends StatefulWidget {
  @override
  _buyOneGetONePageState createState() => _buyOneGetONePageState();
}

class _buyOneGetONePageState extends State<buyOneGetONePage> {
  var height;
  final GlobalKey<ScaffoldState> _key1 = GlobalKey();

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
          children: [buyOneGetOneUI()],
        ),
      ),
    ));
  }

  Widget buyOneGetOneUI() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 30.0, left: 16.0),
          child: Row(
            children: [
              IconButton(
                  onPressed: () {
                    _key1.currentState!.openDrawer();
                  },
                  icon: Icon(
                    Icons.menu,
                    size: 25,
                    color: Color(0xff09098A),
                  )),
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(right: 64.0),
                  alignment: Alignment.center,
                  child: Text(
                    "Buy 1 Get 1 Free",
                    style: Theme.of(context).textTheme.headline1!.copyWith(
                        color: DarkBlue,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          alignment: Alignment.centerLeft,
<<<<<<< HEAD
          margin: EdgeInsets.only(top: 32.0, left: 22.0, bottom: 8),
=======
          margin: EdgeInsets.only(top: 32.0, left: 24.0, bottom: 10),
>>>>>>> d06bd2fee0f4c9bb3f5c8ab81bac27d6a822498d
          child: Text(
            "couponS REEDEMED".toUpperCase(),
            style: commonTextStyles(),
          ),
        ),
        CommonListBuyOneGetOne(),
        // Container(
        //   height: MediaQuery.of(context).size.height/2.6,
        //   child: CommonListBuyOneGetOne(),),
<<<<<<< HEAD
        SizedBox(
          height: 15.0,
        ),

        SizedBox(
          height: 15,
        ),
        Container(
          padding: EdgeInsets.all(8.0),
          height: MediaQuery.of(context).size.height / 2.6,
          child: CommonListBuyOneGetOne(),
        ),
        Container(
          margin: EdgeInsets.only(top: 36.0),
          child: Buttons(),
        ),
        Container(
          alignment: Alignment.bottomCenter,
          height: 250,
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage(
                "assets/image/cartoon-friends-celebrating-birthday-with-balloons-gifts_74855-6951 1.png"),
            fit: BoxFit.cover,
          )),
        ),
=======
        // SizedBox(
        //   height: 15.0,
        // ),

        // SizedBox(
        //   height: 15,
        // ),
        // Expanded(child: CommonListBuyOneGetOne()),
        // Container(
        //   padding: EdgeInsets.all(8.0),
        //   height: MediaQuery.of(context).size.height / 2.6,
        //   child:
        //   CommonListBuyOneGetOne(),
        // ),
        Container(
          margin: EdgeInsets.only(top: 20.0, bottom: 20),
          child: Buttons(),
        ),
        // Container(
        //   alignment: Alignment.bottomCenter,
        //   height: 250,
        //   decoration: BoxDecoration(
        //       image: DecorationImage(
        //     image: AssetImage(
        //         "assets/image/cartoon-friends-celebrating-birthday-with-balloons-gifts_74855-6951 1.png"),
        //     fit: BoxFit.cover,
        //   )),
        // ),
>>>>>>> d06bd2fee0f4c9bb3f5c8ab81bac27d6a822498d
      ],
    );
  }

  Widget CommonListBuyOneGetOne() {
    return ListView.builder(
        itemCount: 5,
<<<<<<< HEAD
=======
        physics: ScrollPhysics(),
        shrinkWrap: true,
>>>>>>> d06bd2fee0f4c9bb3f5c8ab81bac27d6a822498d
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.all(16.0),
            elevation: 5.0,
            shadowColor: Colors.grey,
            shape: commonCardStyle(),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Coupon Code # ",
                          style: TextStyle(
                            color: Color(0xff09098A),
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "fF12SDGFLTF",
                          style: TextStyle(
                            color: Color(0xff09098A),
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Coupon Used On ",
                          style: TextStyle(
                            color: Color(0xff09098A),
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "2-nov-21",
                          style: TextStyle(
                            color: Color(0xff09098A),
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  backgoundImage() {
    return Container(
        alignment: Alignment.bottomCenter,
        child: Image(
            image: AssetImage(
                "assets/image/cartoon-friends-celebrating-birthday-with-balloons-gifts_74855-6951 1.png")));
  }

  Buttons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton.icon(
            style: commonBlueButtons(),
            onPressed: () {
              // Navigator.of(context).push(MaterialPageRoute(builder: (context)=> buyOneGetONePage()));
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_sharp,
              color: Color(0xffffffff),
            ),
            label: Text(
              "Back",
              style: commonBlueButtonTextStyles(),
            )),
        ElevatedButton.icon(
            style: commonBlueButtons(),
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => buyCouponsPage()));
            },
            icon: Icon(
              Icons.arrow_forward_ios,
              color: Color(0xffffffff),
            ),
            label: Text(
              "Next",
              style: commonBlueButtonTextStyles(),
            )),
      ],
    );
  }
}
