import 'package:shop_project/Constants/ColorButton.dart';
import 'package:shop_project/Constants/Constant.dart';
import 'package:shop_project/Constants/LoaderClass.dart';
import 'package:shop_project/DashboardScreens/Profile/EditProfile.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  static String id = "Profile";
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  OverlayEntry? loader;

  @override
  Widget build(BuildContext context) {
    loader = Loader.overlayLoader(context);
    var email = Shared.pref.getString('UserEmail').toString();
    if (email == null || email == "null") {
      email = "No email";
    }

    var height = AppBar().preferredSize.height;

    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            SizedBox(
              height: height,
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
                              radius: 35,
                              backgroundColor: DarkBlue,
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(40),
                                  child: Shared.pref
                                              .getString("PROFILE_IMAGE")
                                              .toString() !=
                                          ""
                                      ? Image.network(
                                          Shared.pref
                                              .getString("PROFILE_IMAGE")
                                              .toString(),
                                          scale: 1,
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
                              style: Theme.of(context)
                                  .textTheme
                                  .headline1!
                                  .copyWith(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: DarkBlue),
                            )
                          ],
                        ),
                        InkWell(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return EditProfile();
                              }));
                            },
                            child: Icon(
                              Icons.edit,
                              color: DarkBlue,
                              size: 30,
                            ))
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
                          Container(
                            decoration: BoxDecoration(
                                color: color,
                                borderRadius: BorderRadius.circular(20)),
                            width: MediaQuery.of(context).size.width * 0.6,
                            child: Padding(
                              padding: const EdgeInsets.all(15),
                              child: Text(
                                email,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline1!
                                    .copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: lightBlue,
                                        fontSize: 16),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
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
                            decoration: BoxDecoration(
                                color: color,
                                borderRadius: BorderRadius.circular(20)),
                            width: MediaQuery.of(context).size.width * 0.6,
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
                                        color: lightBlue,
                                        fontSize: 16),
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
                      //       decoration: BoxDecoration(
                      //           color: color,
                      //           borderRadius: BorderRadius.circular(20)),
                      //       width: MediaQuery.of(context).size.width * 0.6,
                      //       child: Padding(
                      //         padding: const EdgeInsets.all(15),
                      //         child: Text(
                      //           "",
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
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return EditProfile();
                          }));
                        },
                        child: ColorButton(
                          RoundCorner: true,
                          width: 200,
                          colorValue: DarkBlue,
                          // color: color,
                          title: 'Edit',
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
    );
  }
}
