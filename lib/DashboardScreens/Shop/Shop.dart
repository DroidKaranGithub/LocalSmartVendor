import 'dart:convert';
import 'package:shop_project/ApiRepository/ApiRepository.dart';
import 'package:shop_project/ConstantDrawer.dart';
import 'package:shop_project/Constants/Constant.dart';
import 'package:shop_project/Constants/RoundedCard.dart';
import 'package:shop_project/DashboardScreens/Shop/ShopModalClass.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ShopName extends StatefulWidget {
  // String? ShopId;
  // ShopName({this.ShopId});
  static String id = "ShopName";
  @override
  _ShopNameState createState() => _ShopNameState();
}

class _ShopNameState extends State<ShopName> {
  List ImagesList = [];
  String? ShopName;

  String? OwnerName;
  String? Category;
  String? Address;
  String? Url;
  String? UserId = Shared.pref.getString("UserID");
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  int Imageindex = 0;
  Widget UpperBody(BuildContext context) {
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
                  color: orange,
                )),
            Text(
              ShopName ?? "",
              style: Theme.of(context).textTheme.headline1!.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 40,
                    color: orange,
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

  Widget MiddleBody(BuildContext context) {
    var height = AppBar().preferredSize.height;
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
              height: 160,
              aspectRatio: 16 / 9,
              viewportFraction: 1,
              initialPage: 0,
              //enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              //  autoPlayInterval: Duration(seconds: 3),
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              // enlargeCenterPage: true,
              scrollDirection: Axis.horizontal,
              onPageChanged: (val, page) {
                Imageindex = val;
                setState(() {});
              }),
          items: [
            for (int i = 0; i < ImagesList.length; i++)
              Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(20)),
                width: 200,
                child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    elevation: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.network(
                        ImagesList[i],
                        fit: BoxFit.cover,
                      ),
                    )),
              )
          ],
        ),
        // new DotsIndicator(
        //     dotsCount: ImagesList.length, position: Imageindex.toDouble()),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/rupee.png",
            ),
            Text(
              '15,000/-',
              style: Theme.of(context).textTheme.headline1!.copyWith(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          ],
        ),
        SizedBox(
          height: 8,
        ),
        Text(
          'Sofa',
          style: Theme.of(context).textTheme.headline1!.copyWith(
              fontSize: 22, fontWeight: FontWeight.bold, color: orange),
        ),
        SizedBox(
          height: 10,
        ),
        Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: ExpansionTile(
            initiallyExpanded: true,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Additional Details',
                  style: Theme.of(context).textTheme.headline1!.copyWith(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                CircleAvatar(
                    radius: 12,
                    backgroundColor: orange,
                    child: Image.asset(
                      "assets/images/shop.png",
                    )),
              ],
            ),
            children: [],
            //subtitle: LowerBody(context),
          ),
        ),
        Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: ExpansionTile(
            initiallyExpanded: false,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'About the Author',
                  style: Theme.of(context).textTheme.headline1!.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                Image.asset(
                  "assets/images/phone.png",
                ),
              ],
            ),
            children: [LowerBody(context)],
          ),
        )
      ],
    );
  }

  Widget LowerBody(BuildContext context) {
    TextStyle style = Theme.of(context)
        .textTheme
        .headline2!
        .copyWith(color: Colors.black, fontSize: 12);
    var height = AppBar().preferredSize.height;
    return Card(
      elevation: 5,
      color: Color(0xFFF8F5F5),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Shop Name',
                  style: Theme.of(context).textTheme.headline1!.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                RoundedCard(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(ShopName.toString(),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: style),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Owner Name',
                  style: Theme.of(context).textTheme.headline1!.copyWith(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                RoundedCard(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(OwnerName.toString(), style: style),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Category',
                  style: Theme.of(context).textTheme.headline1!.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                RoundedCard(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(' Furniture', style: style),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Shop Address',
                  style: Theme.of(context).textTheme.headline1!.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                RoundedCard(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(Address!, style: style),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Website Url',
                  style: Theme.of(context).textTheme.headline1!.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                RoundedCard(
                    child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text(Url!, style: style)))
              ],
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  getData() {
    print(UserId.toString());
    ApiRepository().GetShopDetail(int.parse(UserId!)).then((value) {
      var body = ShopModalClass.fromJson(jsonDecode(value.body));
      if (body.status.toString() == "true") {
        body.data!.forEach((element) {
          ShopName = element.shopName;
          OwnerName = element.ownerName;
          Address = element.address;
          Url = element.websiteUrl;
          element.shopImages!
              .forEach((element) => ImagesList.add(element.image));
        });
      }
    });
  }

  void initState() {
    super.initState();
//    getData();
  }

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
          padding: const EdgeInsets.all(15),
          child: SingleChildScrollView(
            child: Column(
              children: [
                UpperBody(context),
                SizedBox(
                  height: 30,
                ),
                MiddleBody(context),
                SizedBox(
                  height: 30,
                ),
                Card(
                  elevation: 10,
                  child: Container(
                    // height: 20,
                    width: MediaQuery.of(context).size.width * 0.6,
                    decoration: BoxDecoration(
                        color: orange, borderRadius: BorderRadius.circular(5)),

                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.phone,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Call Now",
                            style: Theme.of(context)
                                .textTheme
                                .headline1!
                                .copyWith(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
