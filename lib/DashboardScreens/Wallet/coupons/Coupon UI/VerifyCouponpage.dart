import 'package:shop_project/DashboardScreens/Wallet/CommonWidgets/Commonwidgets.dart';
import 'package:shop_project/DashboardScreens/Wallet/Transactions/TransactionsUI/TransactionsScreen.dart';
import 'package:flutter/material.dart';


class VerifyCouponPage extends StatefulWidget {
  @override
  _VerifyCouponPageState createState() => _VerifyCouponPageState();
}

class _VerifyCouponPageState extends State<VerifyCouponPage> {
  bool isVisible = false;
  bool isVerify = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              VErifyUi(),
            ],
          ),
        ),
      ),
    );
  }

  Widget VErifyUi() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(top: 28.0, left: 16.0),
            child: Row(
              children: [
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.menu,
                      size: 35,
                      color: Color(0xff09098A),
                    )),
                Expanded(
                  child: Container(
                      padding: EdgeInsets.only(right: 64.0),
                      alignment: Alignment.center,
                      child: Text(
                        "Verify Coupons",
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w800,
                            color: Color(0xff09098A)),
                      )),
                ),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Visibility(
                    visible: isVisible,
                    child:  Container(
                      width: 400,
                      height: 50,
                      color: Colors.green[200],
                      child: Center(child: Text("Coupon is verified", style: TextStyle(
                          color: Color(0xff516B00),
                          fontWeight: FontWeight.w600,
                          fontSize: 20),)),
                    )
                ),
              ),
              Visibility(
                visible: isVerify,
                child: Container(
                    width: 400,
                    height: 50,
                    color: Colors.red[200],
                    child: Center(child: Text("Coupon is verified",style: TextStyle(
                        color: Color(0xff8A0909),
                        fontWeight: FontWeight.w800,
                        fontSize: 20),))
                ),
              ),
            ],
          ),

          Container(
            margin: EdgeInsets.only(top: 28.0, left: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Enter Customer Code",
                  style: commonTextStyles(),
                ),
                SizedBox(
                  height: 16,
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
                        border: InputBorder.none,
                      ),
                    ),
                  ),
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

                  },
                  icon: Icon(
                    Icons.check_circle,
                    color: Color(0xffffffff),
                  ),
                  label: Text(
                    "Verify",
                    style: commonBlueButtonTextStyles(),
                  )),
            ),
          ),
          Center(
            child: Container(
              margin: EdgeInsets.only(top: 28.0, left: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      InkWell(
                        onTap:(){
                          setState(() {
                            isVisible = !isVisible;
                          });
                        } ,
                        child: CircleAvatar(
                          radius: 35,
                          backgroundColor: Colors.green,
                          child: Icon(Icons.check),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "Use",
                        style: TextStyle(
                            color: Color(0xff09098A),
                            fontWeight: FontWeight.w600,
                            fontSize: 20),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      InkWell(
                        onTap: (){
                          setState(() {
                            isVerify = !isVerify;

                          });
                        },
                        child: CircleAvatar(
                          radius: 35,
                          backgroundColor: Colors.red,
                          child: Icon(Icons.close),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "Cancel",
                        style: TextStyle(
                            color: Color(0xff09098A),
                            fontWeight: FontWeight.w600,
                            fontSize: 20),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          Center(
            child: Container(
              margin: EdgeInsets.only(top: 28.0, left: 16.0),
              child: ElevatedButton.icon(
                  style: commonBlueButtons(),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=> transactionsScreen()));
                  },
                  icon: Icon(
                    Icons.check_circle,
                    color: Color(0xffffffff),
                  ),
                  label: Text(
                    "Transactions Screen",
                    style: commonBlueButtonTextStyles(),
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
