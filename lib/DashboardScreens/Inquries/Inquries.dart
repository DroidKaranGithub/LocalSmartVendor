import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_project/ApiRepository/ApiRepository.dart';
import 'package:shop_project/ConstantDrawer.dart';
import 'package:shop_project/Constants/Constant.dart';
import 'package:shop_project/DashboardScreens/CreateShop/CreateShop.dart';
import 'package:shop_project/DashboardScreens/Inquries/InquriesModalClass.dart';
import 'package:shop_project/DashboardScreens/Responses/Responses.dart';

class Inquries extends StatefulWidget {
  //static String id = "Inquries";
  @override
  _InquriesState createState() => _InquriesState();
}

class _InquriesState extends State<Inquries> {
  AssetsAudioPlayer assetsAudioPlayer = AssetsAudioPlayer();
  bool? IsPlaying;
  var prev1;
  List AudioValue = [];
  var AudioValueData;

  List<InquriesModalClass> inquriesData = [];
  // List ItemName=['ELECTORNICS','FURNITURE'];
  // String? UserId = Shared.pref.getString("UserID");
  bool StatusCode = false;

  Color selected = DarkBlue;
  Color unSelected = Colors.white;
  Color TextSelected = Colors.white;
  Color TextunSelected = DarkBlue;
  int Selected = 0;
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  List Button = ['All', 'Active', 'Completed', 'On Hold'];

  List Date = [];
  List ResponseCount = [];
  List Category = [];
  List Id = [];
  List Title = [];
  List Status = [];
  List AudioList = [];

  void getWalletAmount(quiryId) {
    print(" quiry id is $quiryId");
    print(Shared.pref.getInt("userPerticularId").toString());
    ApiRepository()
        .checkWalletAmount(
            quiryId, Shared.pref.getInt("userPerticularId").toString())
        .then((bodyData) {
      print("response ${bodyData.body}");
      var response = jsonDecode(bodyData.body);
      if (response['status']) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (cnt) {
          return Responses();
        }));
        // showDialog(
        //     barrierDismissible: true,
        //     context: context,
        //     builder: (cnt) {
        //       return Dialog(
        //         child: Container(
        //           height: MediaQuery.of(context).size.height / 2,
        //           //padding: EdgeInsets.all(10),
        //           child: Column(
        //             // crossAxisAlignment:
        //             //     CrossAxisAlignment.center,
        //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //             children: [
        //               CircleAvatar(
        //                   radius: 40,
        //                   backgroundColor: Colors.green.shade400,
        //                   child: Icon(
        //                     Icons.done,
        //                     size: 40,
        //                     color: Colors.white,
        //                   )),
        //               Text(
        //                 "${response['message']}",
        //                 textAlign: TextAlign.center,
        //                 style: TextStyle(
        //                     fontSize: 30, fontWeight: FontWeight.bold),
        //               ),
        //               ElevatedButton(
        //                   style: ButtonStyle(
        //                       padding: MaterialStateProperty.all(
        //                           EdgeInsets.symmetric(horizontal: 8.0))),
        //                   onPressed: () {
        //                     Navigator.pushReplacement(context,
        //                         MaterialPageRoute(builder: (cnt) {
        //                       return Responses();
        //                     }));
        //                   },
        //                   child: Text(
        //                     "Ok",
        //                     style: TextStyle(fontSize: 18, color: Colors.white),
        //                   ))
        //             ],
        //           ),
        //         ),
        //       );
        //     });
      } else {
        showDialog(
            barrierDismissible: true,
            context: context,
            builder: (cnt) {
              return Dialog(
                child: Container(
                  height: MediaQuery.of(context).size.height / 2,
                  padding: EdgeInsets.all(10),
                  child: Column(
                    // crossAxisAlignment:
                    //     CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CircleAvatar(
                          radius: 40,
                          backgroundColor: Colors.red.shade400,
                          child: Icon(
                            Icons.cancel,
                            size: 80,
                            color: Colors.white,
                          )),
                      Text(
                        "${response['message']}",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                      ElevatedButton(
                          style: ButtonStyle(
                              padding: MaterialStateProperty.all(
                                  EdgeInsets.symmetric(horizontal: 8.0))),
                          onPressed: () {
                            // Navigator.push(context,
                            //     MaterialPageRoute(builder: (cnt) {
                            //   return Responses();
                            // }));
                            Navigator.pop(context);
                          },
                          child: Text(
                            "Retry",
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ))
                    ],
                  ),
                ),
              );
            });
      }
    });
  }

  getData() {
    inquriesData.clear();
    print("inside get Data");
    print(Shared.pref.getString("shopId").toString());
    ApiRepository()
        .GetInquries(Shared.pref.getString("shopId").toString())
        .then((value) {
      var dataValue = jsonDecode(value.body);
      print("value of api $dataValue");
      if (dataValue['status'] == false) {
        Fluttertoast.showToast(
            msg: dataValue['message'], toastLength: Toast.LENGTH_LONG);
      } else {
        for (Map<String, dynamic> jsonData in dataValue['queries']) {
          setState(() {
            inquriesData.add(InquriesModalClass.fromJson(jsonData));
          });
        }
      }
      setState(() {
        StatusCode = true;
      });
      //       print(inquriesData.toList());
      //  }

      //   if (dataValue['status'] == true) {
      //     for (Map<String, dynamic> jsonData in dataValue['data']) {
      //       setState(() {
      //         inquriesData.add(InquriesModalClass.fromJson(jsonData));
      //       });
      //       setState(() {
      //         StatusCode = true;
      //       });
      //     }
      //     //       print(inquriesData.toList());
      //   } else {
      //     Fluttertoast.showToast(msg: "Something Went Wrong");
      //   }
    });
  }

  void initState() {
    super.initState();
    getData();
  }

  Widget UpperBody(BuildContext context) {
    //  print(inquriesData.length);
    var height = AppBar().preferredSize.height;
    return Column(
      children: [
        SizedBox(height: height),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
                onTap: () {
                  _key.currentState!.openDrawer();
                },
                child: Icon(
                  Icons.menu_rounded,
                  color: DarkBlue,
                )),
            Text(
              'Inquiries',
              style: Theme.of(context).textTheme.headline1!.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 40,
                    color: DarkBlue,
                  ),
            ),
            Visibility(
              visible: false,
              child: CircleAvatar(
                //radius: 50,
                backgroundColor: orange,
                child: Text(
                  '',
                  style: Theme.of(context).textTheme.headline1!.copyWith(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold),
                ),
              ),
            )
          ],
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: InkWell(
                onTap: () {
                  Selected = 0;
                  setState(() {});
                },
                child: Card(
                  elevation: 10,
                  child: Container(
                    // height: 20,
                    width: 100,
                    decoration: BoxDecoration(
                        color: Selected == 0 ? selected : unSelected,
                        borderRadius: BorderRadius.circular(5)),

                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                          child: Text(
                        Button[0],
                        style: Theme.of(context).textTheme.headline1!.copyWith(
                            color:
                                Selected == 0 ? TextSelected : TextunSelected,
                            fontSize: 10,
                            fontWeight: FontWeight.bold),
                      )),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: InkWell(
                onTap: () {
                  Selected = 1;
                  setState(() {});
                },
                child: Card(
                  elevation: 10,
                  child: Container(
                    // height: 20,
                    width: 100,
                    decoration: BoxDecoration(
                        color: Selected == 1 ? selected : unSelected,
                        borderRadius: BorderRadius.circular(5)),

                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                          child: Text(
                        Button[1],
                        style: Theme.of(context).textTheme.headline1!.copyWith(
                            color:
                                Selected == 1 ? TextSelected : TextunSelected,
                            fontSize: 10,
                            fontWeight: FontWeight.bold),
                      )),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: InkWell(
                onTap: () {
                  Selected = 3;
                  setState(() {});
                },
                child: Card(
                  elevation: 10,
                  child: Container(
                    // height: 20,
                    width: 100,
                    decoration: BoxDecoration(
                        color: Selected == 3 ? selected : unSelected,
                        borderRadius: BorderRadius.circular(5)),

                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                          child: Text(
                        Button[3],
                        style: Theme.of(context).textTheme.headline1!.copyWith(
                            color:
                                Selected == 3 ? TextSelected : TextunSelected,
                            fontSize: 10,
                            fontWeight: FontWeight.bold),
                      )),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: InkWell(
                onTap: () {
                  Selected = 2;
                  setState(() {});
                },
                child: Card(
                  elevation: 10,
                  child: Container(
                    // height: 20,
                    width: 100,
                    decoration: BoxDecoration(
                        color: Selected == 2 ? selected : unSelected,
                        borderRadius: BorderRadius.circular(5)),

                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                          child: Text(
                        Button[2],
                        style: Theme.of(context).textTheme.headline1!.copyWith(
                            color:
                                Selected == 2 ? TextSelected : TextunSelected,
                            fontSize: 10,
                            fontWeight: FontWeight.bold),
                      )),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        SizedBox(
          height: 30,
        ),
      ],
    );
  }

  Widget LowerBody(BuildContext context) {
    inquriesData.forEach((element) {
      print(element.title);
      print("id ${element.id}");
    });
    var height = AppBar().preferredSize.height;
    return Expanded(
      child: (inquriesData.length == 0)
          ? Center(
              child: Text("Data Not Found",
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)))
          : ListView.builder(
              itemCount: inquriesData.length,
              itemBuilder: (context, index) {
                return StatusCode
                    ? GestureDetector(
                        onTap: () {
                          // Navigator.push(context, MaterialPageRoute(builder: (context) {
                          //   return Responses(
                          //     QueryId: Id[index],
                          //   );
                          // }));
                        },
                        child: Stack(
                          overflow: Overflow.visible,
                          children: [
                            Column(
                              children: [
                                Card(
                                  elevation: 10,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Padding(
                                    padding: const EdgeInsets.all((10)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  'Title: ',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline1!
                                                      .copyWith(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 15),
                                                ),
                                                Text(
                                                  //                 Title[index] ?? Status[index],
                                                  inquriesData[index]
                                                      .title
                                                      .toString(),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline1!
                                                      .copyWith(
                                                          color: DarkBlue,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 15),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  'Date Posted: ',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline1!
                                                      .copyWith(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 15),
                                                ),
                                                Text(
                                                  inquriesData[index]
                                                      .date
                                                      .toString(),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline1!
                                                      .copyWith(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 15),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Visibility(
                                              visible: true,
                                              child: Row(
                                                children: [
                                                  Text(
                                                    'Responses: ',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headline1!
                                                        .copyWith(
                                                            color: Blue,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 15),
                                                  ),
                                                  Text(
                                                    "Waiting for Customer",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headline1!
                                                        .copyWith(
                                                            color: Blue,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 15),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                          ],
                                        ),
                                        InkWell(
                                            onTap: () {
                                              Shared.pref.setString(
                                                  "queryId",
                                                  inquriesData[index]
                                                      .id
                                                      .toString());
                                              Shared.pref.setString(
                                                  "category",
                                                  inquriesData[index]
                                                      .category
                                                      .toString());
                                              Shared.pref.setString(
                                                  "title",
                                                  inquriesData[index]
                                                      .title
                                                      .toString());
                                              getWalletAmount(
                                                  inquriesData[index]
                                                      .id
                                                      .toString());
                                            },
                                            child: Image.asset(
                                                "assets/images/reply.png")),
                                        InkWell(
                                            onTap: inquriesData[index].file ==
                                                    null
                                                ? () {
                                                    Fluttertoast.showToast(
                                                        msg:
                                                            "Audio file is not available");
                                                  }
                                                : () async {
                                                    if (IsPlaying == false) {
                                                      try {
                                                        print(
                                                            inquriesData[index]
                                                                .file!
                                                                .filePath
                                                                .toString());
                                                        await assetsAudioPlayer
                                                            .open(
                                                          Audio.network(
                                                              inquriesData[
                                                                      index]
                                                                  .file!
                                                                  .filePath
                                                                  .toString()),
                                                        );
                                                        assetsAudioPlayer
                                                            .play();
                                                        setState(() {
                                                          IsPlaying = true;
                                                        });
                                                        assetsAudioPlayer
                                                            .playlistFinished
                                                            .listen((event) {
                                                          if (event == true) {
                                                            setState(() {
                                                              IsPlaying = false;
                                                            });
                                                          }
                                                        });
                                                      } catch (t) {
                                                        //mp3 unreachable
                                                        print(t);
                                                      }
                                                    } else {
                                                      assetsAudioPlayer.stop();
                                                      setState(() {
                                                        IsPlaying = false;
                                                      });
                                                    }
                                                    print(inquriesData[index]
                                                        .file);
                                                  },
                                            child: IsPlaying == true
                                                ? CircleAvatar(
                                                    backgroundColor: DarkBlue,
                                                    child: Icon(
                                                      Icons.pause,
                                                      color: Colors.white,
                                                    ),
                                                  )
                                                : Image.asset(
                                                    "assets/images/play.png"))
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                              ],
                            ),
                            Visibility(
                              visible: true,
                              child: Positioned(
                                top: MediaQuery.of(context).size.height * 0.10,
                                right: 70,
                                left: 70,
                                child: Container(
                                  width: 130,
                                  //height: 30,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(6)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(4),
                                    child: Center(
                                      child: Text(
                                        inquriesData[index].category.toString(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline1!
                                            .copyWith(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15,
                                                color: DarkBlue),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    : Container(
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
                        ),
                      );
              },
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var height = AppBar().preferredSize.height;
    return WillPopScope(
      onWillPop: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return CreateShop();
        }));
        return Future<bool>.value(true);
      },
      child: Scaffold(
          drawer: drawer(),
          drawerEnableOpenDragGesture: false,
          key: _key,
          backgroundColor: Colors.white,
          body: Container(
              height: MediaQuery.of(context).size.height * 1,
              width: MediaQuery.of(context).size.width * 1,
              child: StatusCode
                  ? Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        children: [UpperBody(context), LowerBody(context)],
                      ),
                    )
                  : Container())),
    );
  }
}
