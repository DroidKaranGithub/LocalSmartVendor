import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shop_project/ApiRepository/ApiRepository.dart';
import 'package:shop_project/ConstantDrawer.dart';
import 'package:shop_project/Constants/ColorButton.dart';
import 'package:shop_project/Constants/Constant.dart';
import 'package:shop_project/Constants/LoaderClass.dart';
import 'package:shop_project/DashboardScreens/Inquries/InquriesModalClass.dart';
import 'package:shop_project/DashboardScreens/Responses/ResponsesModalClass.dart';
import 'package:shop_project/DashboardScreens/Shop/Shop.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_project/DashboardScreens/ShopList/shopList.dart';
import 'package:url_launcher/url_launcher.dart';

class Responses extends StatefulWidget {
  //int? QueryId;
  //Responses({this.QueryId});
  static String id = "Responses";
  @override
  _ResponsesState createState() => _ResponsesState();
}

class _ResponsesState extends State<Responses> {
  late OverlayEntry loader;
  String? UserId = Shared.pref.getInt("userPerticularId").toString();
  List Rate = [];
  List Response = [];
  List MobileNumber = [];
  List Title = [];
  List Address = [];
  List Shop = [];
  List Id = [];
  List Images = [];
  bool? Status;

  File? catalogFile;
  String? catalogFilePath;
  String? responseMessage;
  var imagePicker = ImagePicker();
  List<File> responseImages = [];
  var shopImageUpload = "Upload";
  List<ResponseModalClass> responseDetails = [];
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  AssetsAudioPlayer assetsAudioPlayer = AssetsAudioPlayer();
  bool? IsPlaying;
  var prev1;
  List AudioValue = [];
  var AudioValueData;

  Future _makingPhoneCall(String mobile) async {
    String url = "tel:" + mobile;
    print(url);
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future getCatalogPdf() async {
    PickedFile? image = await imagePicker.getImage(source: ImageSource.gallery);

    if (image == null) {
      Fluttertoast.showToast(msg: "Pdf Not Selected");
    } else {
      setState(() {
        //shopImages.add(File(image.path));
        catalogFile = File(image.path);
        catalogFilePath = image.path;
        Fluttertoast.showToast(msg: "PDF Selected");
      });
    }
  }

  Future getProductImages() async {
    PickedFile? image = await imagePicker.getImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        if (responseImages.length < 10) {
          responseImages.add(File(image.path));
          setState(() {
            shopImageUpload = "Add More";
          });
          Fluttertoast.showToast(msg: "Image Selected");
        } else {
          Fluttertoast.showToast(msg: "Max 10 Files Allow to Upload");
        }
      });
    } else {
      Fluttertoast.showToast(msg: "Image Not Selected");
    }
  }

  submitResponseData(queryId, shopId) async {
    print(
        "Shop id is $shopId and query id is $queryId and price is ${productPrice.text.toString()}");
    String url = BaseUrl + "response/store";
    debugPrint("URL--> $url");

    var request = http.MultipartRequest("POST", Uri.parse(url));

    request.fields['query_id'] = "$queryId";
    request.fields['shop_id'] = "$shopId";
    // request.fields['title'] = "";
    request.fields['price'] = "${productPrice.text.toString()}";

    request.fields['response'] = productDescription.text.toString();
    request.fields['response_link'] = catalogLink.text.toString();

    //response_pdf
    if (catalogFilePath != null) {
      var response_pdf = await http.MultipartFile.fromPath(
          "response_pdf", catalogFilePath.toString());
      request.files.add(response_pdf);
    }
    if (responseImages.isEmpty) {
      print("object");
    } else {
      if (responseImages.isNotEmpty) {
        for (var i = 0; i < responseImages.length; i++) {
          var response_images1 = await http.MultipartFile.fromPath(
              "response_images[$i]", responseImages[i].path);
          request.files.add(response_images1);
        }
      }
      //   if (responseImages[0].path.isNotEmpty) {
      //     var response_images1 = await http.MultipartFile.fromPath(
      //         "response_images[0]", responseImages[0].path);
      //     request.files.add(response_images1);
      //   }
      // if (responseImages[0].path.isNotEmpty) {
      //   var response_images2 = await http.MultipartFile.fromPath(
      //       "response_images[1]", responseImages[1].path);
      //   request.files.add(response_images2);
      // }
      // if (responseImages[1].path.isNotEmpty) {
      //   var response_images3 = await http.MultipartFile.fromPath(
      //       "response_images[2]", responseImages[2].path);
      //   request.files.add(response_images3);
      // }
    }
    print(request.files);
    print(request.fields);
    request.send().then((response) => {
          http.Response.fromStream(response).then((value) {
            try {
              //print(value.body);
              // setState(() {
              //   Loader.hideLoader(loader);
              // });
              var data = jsonDecode(value.body);
              print(data);
              print(data['message']);
//              Fluttertoast.showToast(msg: data["message"]);
              if (data['status']) {
                showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (cnt) {
                      return Dialog(
                        child: Container(
                          height: MediaQuery.of(context).size.height / 2,
                          //padding: EdgeInsets.all(10),
                          child: Column(
                            // crossAxisAlignment:
                            //     CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              CircleAvatar(
                                  radius: 40,
                                  backgroundColor: Colors.green.shade400,
                                  child: Icon(
                                    Icons.done,
                                    size: 40,
                                    color: Colors.white,
                                  )),
                              Text(
                                "${data['message']}",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.bold),
                              ),
                              ElevatedButton(
                                  style: ButtonStyle(
                                      padding: MaterialStateProperty.all(
                                          EdgeInsets.symmetric(
                                              horizontal: 8.0))),
                                  onPressed: () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (cnt) {
                                      return ShopList();
                                    }));
                                  },
                                  child: Text(
                                    "Ok",
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.white),
                                  ))
                            ],
                          ),
                        ),
                      );
                    });
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
                                "${data['message']}",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.bold),
                              ),
                              ElevatedButton(
                                  style: ButtonStyle(
                                      padding: MaterialStateProperty.all(
                                          EdgeInsets.symmetric(
                                              horizontal: 8.0))),
                                  onPressed: () {
                                    // Navigator.push(context,
                                    //     MaterialPageRoute(builder: (cnt) {
                                    //   return Responses();
                                    // }));
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    "Add Amount",
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.white),
                                  ))
                            ],
                          ),
                        ),
                      );
                    });
              }
              // Navigator.pushReplacement(context,
              //     MaterialPageRoute(builder: (BuildContext context) {
              //   return ShopList();
              // }));
            } catch (error) {
              log(error.toString());
            }
          })
        });
  }

  getData() {
    print("shop id is ");
    print(Shared.pref.getString("shopId"));
    print("queery id is ");
    print(Shared.pref.getString("queryId"));
    responseDetails.clear();
    ApiRepository().GetResponse().then((value) {
      print(jsonDecode(value.body));
      //var body = ResponseModalClass.fromJson(jsonDecode(value.body));
      //Status = body.status;
      //setState(() {});
      var bodyData = jsonDecode(value.body);
      if (bodyData['status'] == true) {
        setState(() {
          if (bodyData['data'] != null) {
            print(bodyData);
            responseDetails.add(ResponseModalClass.fromJson(bodyData['data']));
            AudioValueData = bodyData['data']['file']['file_path'];
          } else {
            print("object");
            print(responseDetails.length);
          }
          checkStatus = true;
        });
//        var body1 = ResponseModalClass.fromJson(jsonDecode(value.body)).data;
        // if (body1!.isEmpty) {
        //   Fluttertoast.showToast(msg: "Data is not available");
        // }
        // print("hello");

      } else {
        Fluttertoast.showToast(msg: "Data is not available");
      }
      //else {
      //     body1.forEach((element) {
      //       Title.add(element.title);
      //       MobileNumber.add(element.shop!.contactNumber);
      //       Rate.add(element.price);
      //       Images.add(element.productImage);
      //       Id.add(element.shop!.id);
      //       Shop.add(element.shop!.shopName);
      //       Address.add(element.shop!.address);
      //     });
      //   }
      // }
    });
  }

  void initState() {
    super.initState();
    getData();
  }

  bool checkStatus = false;
  Widget UpperBody(BuildContext context) {
    loader = Loader.overlayLoader(context);
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
              'Response Details',
              style: Theme.of(context).textTheme.headline1!.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
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
      ],
    );
  }

  Widget LowerBody(BuildContext context) {
    print(responseDetails);

    print(responseDetails.length);
    TextStyle style = Theme.of(context)
        .textTheme
        .headline1!
        .copyWith(color: orange, fontWeight: FontWeight.bold, fontSize: 15);
    var height = AppBar().preferredSize.height;
    return Expanded(
      child: ListView.builder(
        itemCount: 1,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              // Navigator.push(context, MaterialPageRoute(builder: (context){
              //   return ShopName();
              // }));
            },
            child: Container(
              //height: 800,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //SizedBox(height: height / 5),
                  // Text(Shared.pref.getString("category").toString(),
                  //     style: Theme.of(context).textTheme.headline1!.copyWith(
                  //           fontWeight: FontWeight.bold,
                  //           fontSize: 40,
                  //           color: Color.fromRGBO(21, 166, 255,
                  //               1), //background: rgba(21, 166, 255, 1);
                  //         )),
                  // SizedBox(height: height / 5),
                  Text(Shared.pref.getString("title").toString(),
                      style: Theme.of(context).textTheme.headline1!.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 28,
                            color: DarkBlue,
                          )),
                  SizedBox(height: height / 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                          // onTap: inquriesData[index] == null
                          //     ? () {
                          //         Fluttertoast.showToast(
                          //             msg: "Audio file is not available");
                          //       }
                          //     : () {
                          //         if (IsPlaying == true) {
                          //           print("if");
                          //           if (index == prev1) {
                          //             print("second if");
                          //             if (IsPlaying == true) {
                          //               print("second if if");
                          //               assetsAudioPlayer.stop();
                          //               AudioValue[index] = false;
                          //               prev1 = index;
                          //               IsPlaying = false;
                          //               setState(() {});
                          //             } else {
                          //               print("second if else");
                          //               AudioValue[index] = true;
                          //               prev1 = index;
                          //               IsPlaying = true;
                          //               assetsAudioPlayer
                          //                   .open(Audio(AudioList[index]))
                          //                   .then((value) {
                          //                 assetsAudioPlayer
                          //                     .playlistFinished
                          //                     .listen((event) {
                          //                   if (event == true) {
                          //                     setState(() {
                          //                       AudioValue[index] = false;
                          //                       prev1 = index;
                          //                       IsPlaying = false;
                          //                     });
                          //                   }
                          //                 });
                          //               });
                          //               setState(() {});
                          //             }
                          //           } else {
                          //             print("if else");
                          //             AudioValue[index] = true;
                          //             AudioValue[prev1] = false;
                          //             prev1 = index;
                          //             assetsAudioPlayer
                          //                 .open(Audio(AudioList[index]))
                          //                 .then((value) {
                          //               assetsAudioPlayer.playlistFinished
                          //                   .listen((event) {
                          //                 if (event == true) {
                          //                   setState(() {
                          //                     AudioValue[index] = false;
                          //                     prev1 = index;
                          //                     IsPlaying = false;
                          //                   });
                          //                 }
                          //               });
                          //             });
                          //             setState(() {});
                          //           }
                          //         } else {
                          //           print('else');
                          //           IsPlaying = true;
                          //           AudioValue[index] = true;
                          //           prev1 = index;
                          //           assetsAudioPlayer
                          //               .open(Audio(AudioList[index]))
                          //               .then((value) {
                          //             assetsAudioPlayer.playlistFinished
                          //                 .listen((event) {
                          //               if (event == true) {
                          //                 setState(() {
                          //                   AudioValue[index] = false;
                          //                   prev1 = index;
                          //                   IsPlaying = false;
                          //                 });
                          //               }
                          //             });
                          //           });
                          //           setState(() {});
                          //         }
                          //       },
                          // child:()
                          //     ? CircleAvatar(
                          //         backgroundColor: orange,
                          //         child: Icon(
                          //           Icons.pause,
                          //           color: Colors.white,
                          //         ),
                          //       )
                          //     :
                          onTap: AudioValueData == null || AudioValueData == ""
                              ? () {
                                  print('no audio');
                                  Fluttertoast.showToast(
                                      msg: "Audio file is not available");
                                }
                              : () async {
                                  print(AudioValueData.toString());
                                  if (IsPlaying == false) {
                                    try {
                                      print(AudioValueData.toString());
                                      await assetsAudioPlayer.open(
                                        Audio.network(
                                            AudioValueData.toString()),
                                      );
                                      assetsAudioPlayer.play();
                                      setState(() {
                                        IsPlaying = true;
                                      });
                                      assetsAudioPlayer.playlistFinished
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
                                  // print(inquriesData[index].file);
                                },
                          child: IsPlaying == true
                              ? CircleAvatar(
                                  backgroundColor: DarkBlue,
                                  child: Icon(
                                    Icons.pause,
                                    color: Colors.white,
                                  ),
                                )
                              : Image.asset("assets/images/play.png")),
                      IsPlaying == true
                          ? Text("Stop",
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline1!
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 40,
                                    color: Color.fromRGBO(21, 166, 255,
                                        1), //background: rgba(21, 166, 255, 1);
                                  ))
                          : Text("Play",
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline1!
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 40,
                                    color: Color.fromRGBO(21, 166, 255,
                                        1), //background: rgba(21, 166, 255, 1);
                                  )),
                    ],
                  ),
                  SizedBox(height: height / 5),
                  (responseDetails.length > 0)
                      ? Card(
                          elevation: 20,
                          child: Container(
                              child: Image.network(
                            responseDetails[index].file_upload.toString(),
                            fit: BoxFit.cover,
                          )),
                        )
                      : Container(),

                  SizedBox(height: height / 3),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 3,
                        child: Text("Description : ",
                            style: Theme.of(context)
                                .textTheme
                                .headline1!
                                .copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25,
                                    letterSpacing: 1,
                                    color: DarkBlue)),
                      ),
                      Expanded(
                        flex: 4,
                        child: Container(
                            //   color: Colors.red,
                            //  height: 20,
                            child: (responseDetails.length > 0)
                                ? Text(
                                    responseDetails[index]
                                        .description
                                        .toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline1!
                                        .copyWith(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                            //letterSpacing: 1,
                                            color: lightBlue))
                                : Text("Description Not Available",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline1!
                                        .copyWith(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                            //letterSpacing: 1,
                                            color: lightBlue))),
                      )
                    ],
                  ),
                  SizedBox(height: height / 3),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 3,
                        child: Text("Product URL: ",
                            style: Theme.of(context)
                                .textTheme
                                .headline1!
                                .copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25,
                                    letterSpacing: 1,
                                    color: DarkBlue)),
                      ),
                      Expanded(
                        flex: 4,
                        child: Container(
                            //   color: Colors.red,
                            //  height: 20,
                            child: (responseDetails.length > 0)
                                ? Text(
                                    responseDetails[index]
                                        .product_url
                                        .toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline1!
                                        .copyWith(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                            //letterSpacing: 1,
                                            color: lightBlue))
                                : Text("Product url not Available",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline1!
                                        .copyWith(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                            //letterSpacing: 1,
                                            color: lightBlue))),
                      )
                    ],
                  ),
                  SizedBox(height: height),
                  Text("Your Response",
                      style: Theme.of(context).textTheme.headline1!.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          //letterSpacing: 1,
                          color: Color.fromRGBO(21, 166, 255, 1))),
                  SizedBox(height: height / 3),
                  Row(
                    children: [
                      Text("Product Description :",
                          style:
                              Theme.of(context).textTheme.headline1!.copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22,
                                  //letterSpacing: 1,
                                  color: DarkBlue)),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  TextField(
                    //textDirection: TextDirection.ltr,
                    autocorrect: false,
                    minLines: 3,
                    maxLines: 3,
                    controller: productDescription,
                    // onChanged: (value) {
                    //   print(value);
                    //   shopName.text = value;
                    // },
                    // inputFormatters: [
                    //   FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z ]'))
                    // ],

                    decoration: InputDecoration(
                        hintText: "Enter Description",
                        hintStyle: TextStyle(color: lightBlue),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10)))),
                  ),
                  SizedBox(height: height / 3),
                  Row(
                    children: [
                      Text("Product Price :",
                          style:
                              Theme.of(context).textTheme.headline1!.copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22,
                                  //letterSpacing: 1,
                                  color: DarkBlue)),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  TextField(
                    //textDirection: TextDirection.ltr,
                    autocorrect: false,

                    controller: productPrice,
                    // onChanged: (value) {
                    //   print(value);
                    //   shopName.text = value;
                    // },
                    // inputFormatters: [
                    //   FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z ]'))
                    // ],

                    decoration: InputDecoration(
                        hintText: "Enter Product Price",
                        hintStyle: TextStyle(color: lightBlue),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10)))),
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Text(
                          'Catalog',
                          style: Theme.of(context)
                              .textTheme
                              .headline1!
                              .copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: DarkBlue,
                                  fontSize: 22),
                        ),
                      ),
                      Expanded(
                          child: Container(
                        child: Row(
                          children: [
                            Radio(
                                value: "Pdf",
                                groupValue: selectedFileRationButton,
                                onChanged: (value) {
                                  setState(() {
                                    selectedFileRationButton = value.toString();
                                  });
                                  print(value);
                                }),
                            Text(
                              'PDF',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline1!
                                  .copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: DarkBlue,
                                      fontSize: 22),
                            ),
                            Radio(
                                value: "Link",
                                groupValue: selectedFileRationButton,
                                onChanged: (value) {
                                  setState(() {
                                    selectedFileRationButton = value.toString();
                                  });
                                  print(value);
                                }),
                            Text(
                              'LINK',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline1!
                                  .copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: DarkBlue,
                                      fontSize: 22),
                            ),
                          ],
                        ),
                      ))
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      (selectedFileRationButton.toString().contains("Pdf"))
                          ? Expanded(
                              flex: 2,
                              child: Card(
                                elevation: 5,
                                child: Container(
                                  padding: EdgeInsets.all(5),
                                  child: Text(
                                    'Upload',
                                    //textAlign: TextAlign.center,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline1!
                                        .copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: DarkBlue,
                                            fontSize: 22),
                                  ),
                                ),
                              ),
                            )
                          : Expanded(
                              //flex: 2,
                              child: Container(
                                padding: EdgeInsets.all(5),
                                child: TextField(
                                  //textDirection: TextDirection.ltr,
                                  //maxLines: 4,
                                  //maxLength: 100,
                                  controller: catalogLink,
                                  decoration: InputDecoration(
                                      hintText: "Enter Link",
                                      hintStyle: TextStyle(color: lightBlue),
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 10),
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)))),
                                ),
                              ),
                            ),
                      SizedBox(width: 5),
                      (selectedFileRationButton.toString().contains("Pdf"))
                          ? Expanded(
                              flex: 1,
                              child: InkWell(
                                onTap: () {
                                  //getImage();
                                  getCatalogPdf();
                                },
                                child: ColorButton(
                                  RoundCorner: true,
                                  // width: 200,
                                  colorValue: DarkBlue,
                                  title: 'Upload',
                                ),
                              ),
                            )
                          : Text(""),
                    ],
                  ),

                  SizedBox(height: height / 3),
                  Row(
                    children: [
                      Text("Product image:",
                          style:
                              Theme.of(context).textTheme.headline1!.copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22,
                                  //letterSpacing: 1,
                                  color: DarkBlue)),
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Card(
                          elevation: 5,
                          child: Container(
                            padding: EdgeInsets.all(5),
                            child: Text(
                              "Upload",
                              //textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline1!
                                  .copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: DarkBlue,
                                      fontSize: 22),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 5),
                      Expanded(
                        flex: 1,
                        child: InkWell(
                          onTap: () {
                            //getImage();
                            getProductImages();
                          },
                          child: ColorButton(
                            RoundCorner: true,
                            // width: 200,
                            colorValue: DarkBlue,
                            title: shopImageUpload,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  // (responseImages.isNotEmpty)
                  //     ?
                  Container(
                      height: MediaQuery.of(context).size.height / 6,
                      //  color: Colors.red,
                      child: ListView.builder(
                          itemCount: responseImages.length,
                          itemBuilder: (cnt, index) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "${responseImages[index].path.split("/").last.substring(12)}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline1!
                                      .copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: lightBlue,
                                          fontSize: 14),
                                  textAlign: TextAlign.start,
                                ),
                                InkWell(
                                  onTap: () {
                                    responseImages.removeAt(index);
                                    setState(() {});
                                    // print(responseImages
                                    //     .removeAt(index)
                                    //     .toString());
                                  },
                                  child: Icon(
                                    Icons.cancel,
                                    size: 22,
                                  ),
                                )
                              ],
                            );
                          }))
                  // ? Container(
                  //     color: Colors.red,
                  //     padding: EdgeInsets.all(5),
                  //     child: Row(
                  //       children: [
                  //         Text(
                  //           "${responseImages[index].path.split("/").last.substring(12)}",
                  //           style: Theme.of(context)
                  //               .textTheme
                  //               .headline1!
                  //               .copyWith(
                  //                   fontWeight: FontWeight.bold,
                  //                   color: lightBlue,
                  //                   fontSize: 14),
                  //           textAlign: TextAlign.start,
                  //         ),
                  //         InkWell(
                  //           onTap: () {
                  //             responseImages.removeAt(index);
                  //             setState(() {});
                  //             // print(responseImages
                  //             //     .removeAt(index)
                  //             //     .toString());
                  //           },
                  //           child: Icon(
                  //             Icons.cancel,
                  //             size: 22,
                  //           ),
                  //         )
                  //       ],
                  //     ),
                  //   )
                  //: Container(),
                  ,
                  Container(),
                  SizedBox(height: height / 3),
                  if (responseMessage != null)
                    Text(
                      responseMessage.toString(),
                      style: Theme.of(context).textTheme.headline1!.copyWith(
                          color: Colors.red,
                          fontSize: 18,
                          fontWeight: FontWeight.normal),
                    ),
                  ElevatedButton(
                    //                          widget: Icon(Icons.ac_unit),
                    // RoundCorner: true,

                    onPressed: () async {
                      if (selectedFileRationButton.toString().contains("Pdf") &&
                          productDescription.text.toString().isEmpty) {
                        Fluttertoast.showToast(
                            msg: "Descriptin Field cannot be blank");
                        setErrorMsg('Descriptin Field cannot be blank');
                      } else if (selectedFileRationButton
                              .toString()
                              .contains("Link") &&
                          catalogLink.text.toString().isEmpty) {
                        Fluttertoast.showToast(
                            msg: "Link Field cannot be blank");
                        setErrorMsg('Link Field cannot be blank');
                      } else {
                        Overlay.of(context)!.insert(loader);

                        //  print(responseDetails[index].id.toString());
                        submitResponseData(
                            Shared.pref.getString("queryId").toString(),
                            Shared.pref.getString("shopId").toString());
                        Loader.hideLoader(loader);
                      }
                    },
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(DarkBlue),
                        fixedSize: MaterialStateProperty.all(Size(200, 50)),
                        shape: MaterialStateProperty.all(StadiumBorder())),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
            ),
          );
        },
      ),
    );
  }

  void setErrorMsg(String msg) {
    setState(() {
      responseMessage = msg;
    });
  }

  String? selectedFileRationButton = "Pdf";
  TextEditingController productDescription = TextEditingController();
  TextEditingController catalogLink = TextEditingController();
  TextEditingController productPrice = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var height = AppBar().preferredSize.height;
    return Scaffold(
      key: _key,
      drawerEnableOpenDragGesture: false,
      drawer: drawer(),
      backgroundColor: Colors.white,
      body: Container(
        height: MediaQuery.of(context).size.height * 1,
        width: MediaQuery.of(context).size.width * 1,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: checkStatus == true
              ? Column(
                  children: [UpperBody(context), LowerBody(context)],
                )
              : Center(
                  child: CircularProgressIndicator(),
                ),
        ),
      ),
    );
  }
}
