import 'package:flutter/material.dart';
import 'package:shop_project/DashboardScreens/CreateShop/CreateShop.dart';
import 'package:shop_project/DashboardScreens/ShopList/shopList.dart';

import 'Auth/Login/Login.dart';
import 'Constants/Constant.dart';
import 'DashboardScreens/Profile/Profile.dart';
import 'DashboardScreens/Wallet/Transactions/TransactionsUI/TransactionsScreen.dart';
import 'DashboardScreens/Wallet/coupons/Coupon UI/Coupons.dart';

class drawer extends StatefulWidget {
  const drawer({Key? key}) : super(key: key);

  @override
  _drawerState createState() => _drawerState();
}

class _drawerState extends State<drawer> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ClipRRect(
        borderRadius: BorderRadius.only(topRight: Radius.circular(20)),
        child: Drawer(
          child: Container(
            decoration: BoxDecoration(
                color: Color.fromRGBO(225, 225, 238, 1),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20),
                )),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 75,
                        height: 75,
                        decoration: BoxDecoration(
                            color: orange,
                            borderRadius: BorderRadius.circular(40)),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(40),
                            child: Shared.pref
                                        .getString("PROFILE_IMAGE")
                                        .toString() !=
                                    ''
                                ? FadeInImage.assetNetwork(
                                    placeholder:
                                        'assets/images/loading_animated.gif',
                                    image: Shared.pref
                                        .getString("PROFILE_IMAGE")
                                        .toString(),
                                    fit: BoxFit.cover,
                                  )
                                : Image.network(
                                    "https://th.bing.com/th/id/OIP.kcaJsnMsMsFRdU6d1m2v6AHaHa?pid=ImgDet&rs=1"
                                    // Shared.pref
                                    //     .getString("PROFILE_IMAGE")
                                    //     .toString(),
                                    // fit: BoxFit.cover,
                                    )),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        Shared.pref.getString("UserName").toString(),
                        style: Theme.of(context).textTheme.headline1!.copyWith(
                            color: DarkBlue,
                            fontWeight: FontWeight.bold,
                            fontSize: 23),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      // Text(
                      //   Shared.pref.getString("EMAIL").toString().isNotEmpty
                      //       ? Shared.pref.getString("EMAIL").toString()
                      //       : "",
                      //   style: TextStyle(color: orange),
                      // ),
                      // SizedBox(
                      //   height: 5,
                      // ),
                      Text(
                        Shared.pref.getString("mobileNumber").toString(),
                        style: TextStyle(color: DarkBlue),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return CreateShop();
                              }));
                            },
                            child: Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(
                                  Icons.home,
                                  color: Colors.black,
                                  size: 25,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Home',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline1!
                                        .copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: DarkBlue,
                                            fontSize: 20),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return Profile();
                              }));
                            },
                            child: Row(
                              children: [
                                Icon(
                                  Icons.person,
                                  color: Colors.black,
                                  size: 25,
                                ),
                                //  SizedBox(width: 20,),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Profile',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline1!
                                        .copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: DarkBlue,
                                            fontSize: 20),
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          // GestureDetector(
                          //   onTap: () {
                          //     Navigator.push(context,
                          //         MaterialPageRoute(builder: (context) {
                          //       return Inquries();
                          //     }));
                          //   },
                          //   child: Row(
                          //     children: [
                          //       Icon(
                          //         Icons.image_search_rounded,
                          //         color: Colors.black,
                          //         size: 25,
                          //       ),
                          //       //SizedBox(width: 20,),
                          //       // Padding(
                          //       //   padding: const EdgeInsets.all(8.0),
                          //       //   child: Text(
                          //       //     'Inquiries',
                          //       //     style: Theme.of(context)
                          //       //         .textTheme
                          //       //         .headline1!
                          //       //         .copyWith(
                          //       //             fontWeight: FontWeight.bold,
                          //       //             color: DarkBlue,
                          //       //             fontSize: 20),
                          //       //   ),
                          //       // )
                          //     ],
                          //   ),
                          // ),

                          // SizedBox(
                          //   height: 10,
                          // ),
                          InkWell(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return CouponsPage();
                              }));
                            },
                            child: Row(
                              children: [
                                Image.asset("assets/images/discount.png"),
                                // SizedBox(width: 20,),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Coupons',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline1!
                                        .copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: DarkBlue,
                                            fontSize: 20),
                                  ),
                                )
                              ],
                            ),
                          ),

                          SizedBox(
                            height: 10,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return ShopList();
                              }));
                            },
                            child: Row(
                              children: [
                                // Icon(
                                //   Icons.shop,
                                //   color: Colors.black,
                                //   size: 25,
                                // ),
                                InkWell(
                                  child: Image(
                                    image: AssetImage(
                                        "assets/images/shopList.png"),
                                    height: 20,
                                    width: 20,
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Shop List',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline1!
                                        .copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: DarkBlue,
                                            fontSize: 20),
                                  ),
                                )
                              ],
                            ),
                          ),
                          // GestureDetector(
                          //   onTap: (){
                          //     Navigator.push(context, MaterialPageRoute(builder: (context){
                          //       return ShopName();
                          //     }));
                          //   },
                          //   child: Row(
                          //     children: [
                          //       Image.asset("assets/images/bid.png"),
                          //       // SizedBox(width: 20,),
                          //       Padding(
                          //         padding: const EdgeInsets.all(8.0),
                          //         child: Text('Bid & Buy',style: Theme.of(context).textTheme.headline1!.copyWith(
                          //             fontWeight: FontWeight.bold,color: DarkBlue,fontSize: 20
                          //         ),),
                          //       )
                          //     ],
                          //   ),
                          // ),
                          SizedBox(
                            height: 10,
                          ),
                          // SizedBox(height: 10,),
                          //
                          // Row(
                          //   children: [
                          //     Image.asset("assets/images/help.png"),
                          //     //SizedBox(width: 20,),
                          //     Padding(
                          //       padding: const EdgeInsets.all(8.0),
                          //       child: Text('Help & Support',style: Theme.of(context).textTheme.headline1!.copyWith(
                          //           fontWeight: FontWeight.bold,color: DarkBlue,fontSize: 20
                          //       ),),
                          //     )
                          //
                          //   ],
                          // ),
                          InkWell(
                            onTap: () {
                              // Shared.pref.setBool("Login", false);
                              // Navigator.pushReplacementNamed(context, Login.id);
                              // transactionsScreen

                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return transactionsScreen();
                              }));
                            },
                            child: Row(
                              children: [
                                InkWell(
                                  child: Image(
                                    image: AssetImage(
                                        "assets/images/transaction.png"),
                                    height: 20,
                                    width: 20,
                                  ),
                                ),
                                // SizedBox(width: 20,),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Transaction',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline1!
                                        .copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: DarkBlue,
                                            fontSize: 20),
                                  ),
                                )
                              ],
                            ),
                          ),

                          SizedBox(
                            height: 10,
                          ),
                          InkWell(
                            onTap: () {
                              Shared.pref.clear();
                              Navigator.pushReplacement(context,
                                  MaterialPageRoute(builder: (cnt) {
                                return Login();
                              }));
                            },
                            child: Row(
                              children: [
                                Icon(
                                  Icons.exit_to_app,
                                  color: Colors.black,
                                  size: 25,
                                ),
                                // SizedBox(width: 20,),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Sign Out',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline1!
                                        .copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: DarkBlue,
                                            fontSize: 20),
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
