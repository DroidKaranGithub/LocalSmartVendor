import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_project/ConstantDrawer.dart';
import 'package:shop_project/Constants/Constant.dart';
import 'package:shop_project/DashboardScreens/Wallet/CommonWidgets/Commonwidgets.dart';
import 'package:flutter/material.dart';
import 'package:shop_project/DashboardScreens/Wallet/Transactions/API/TransactionApi.dart';
import 'package:shop_project/DashboardScreens/Wallet/Transactions/Models/TransactionModalClass.dart';
import 'package:shop_project/DashboardScreens/Wallet/wallet/Wallet%20UI/Wallet.dart';
import '';

class transactionsScreen extends StatefulWidget {
  @override
  _transactionsScreenState createState() => _transactionsScreenState();
}

class _transactionsScreenState extends State<transactionsScreen> {
  final GlobalKey<ScaffoldState> _key1 = GlobalKey();
  String? abalance;
  bool loadBalance = false;
  List<TransactionModalClass> transactionList = [];
  bool loadTransaction = false;

  getData() {
    transactionList.clear();
    print("inside get Data");
    int? userId = Shared.pref.getInt("userPerticularId");
    TransactionApi().GetTransactionList(userId).then((value) {
      var dataValue = jsonDecode(value.body);
      print(dataValue);
      if (dataValue['status'] == false) {
        Fluttertoast.showToast(
            msg: 'no transaction', toastLength: Toast.LENGTH_LONG);
        setState(() {
          loadTransaction = true;
        });
      } else {
        for (Map<String, dynamic> jsonData in dataValue['data']) {
          setState(() {
            transactionList.add(TransactionModalClass.fromJson(jsonData));
          });
        }
      }
      setState(() {
        loadTransaction = true;
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

  void getAbalanseData() {
    int? userId = Shared.pref.getInt("userPerticularId");
    TransactionApi().GetAvailableBalance(userId).then((value) {
      var response = jsonDecode(value.body);
      print("Balanse Data ${response}");
      print(response['data']['id']);
      setState(() {
        abalance = response['data']['wallet_balance'].toString();
        loadBalance = true;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAbalanseData();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      key: _key1,
      drawer: drawer(),
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                TransactionsUI(),
              ],
            ),
          ),
          Positioned(
            bottom: 15.0,
            left: 0.0,
            right: 0.0,
            child: Center(
              child: Container(
                margin: EdgeInsets.only(top: 28.0, left: 16.0),
                child: ElevatedButton.icon(
                    style: commonBlueButtons(),
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => walletUI()));
                    },
                    icon: Icon(
                      Icons.add_circle_outline,
                      color: Color(0xffffffff),
                    ),
                    label: Text(
                      "Add Funds",
                      style: commonBlueButtonTextStyles(),
                    )),
              ),
            ),
          ),
        ],
      ),
    ));
  }

  Widget TransactionsUI() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(top: 28.0, left: 10.0),
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
                    "Transactions",
                    style: Theme.of(context).textTheme.headline1!.copyWith(
                        color: DarkBlue,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                    // style: TextStyle(
                    //   fontSize: 24,
                    //   fontWeight: FontWeight.w800,
                    //   color: Color(0xff09098A),
                    // ),
                  ),
                ),
              ),
            ],
          ),
        ),
        TransactionCard(),
        Container(
            margin: EdgeInsets.only(left: 40.0),
            child: Text(
              "Past transaction",
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff09098A)),
            )),
        Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 8),
          child: Divider(),
        ),
        Container(height: 400, child: CaditDebitList()),
        Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 8),
          child: Divider(),
        ),
<<<<<<< HEAD
        Center(
          child: Container(
            margin: EdgeInsets.only(top: 28.0, left: 16.0),
            child: ElevatedButton.icon(
                style: commonBlueButtons(),
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => walletUI()));
                },
                icon: Icon(
                  Icons.add_circle_outline,
                  color: Color(0xffffffff),
                ),
                label: Text(
                  "Add Funds",
                  style: commonBlueButtonTextStyles(),
                )),
          ),
        ),
=======
>>>>>>> d06bd2fee0f4c9bb3f5c8ab81bac27d6a822498d
      ],
    );
  }

  Widget TransactionDateFormated(date_str) {
    var dateFormate =
        DateFormat("d MMM yy, h:m").format(DateTime.parse(date_str));
    return Text("$dateFormate");
  }

  Widget TransactionCard() {
    return Card(
      elevation: 5.0,
      shape: commonCardStyle(),
      margin: EdgeInsets.all(30.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextButton(
                  onPressed: () {},
                  child: Text(
                    "Available Balance",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Color(0xff09098A),
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                loadBalance
                    ? Text(
                        "₹ $abalance",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                        ),
                      )
                    : CircularProgressIndicator(),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: CircleAvatar(
              radius: 20,
              backgroundColor: Color(0xff09098A),
              child: Text(
                "₹",
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget CaditDebitList() {
    // var dateFormate = DateFormat("d MMM yy, h:m").format(DateTime.parse("2022-01-22T05:24:54.000000Z"));

    return ListView.builder(
        itemCount: transactionList.length,
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              setState(() {
                transactionBottomSheet(context, transactionList[index]);
              });
            },
<<<<<<< HEAD
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                        height: 50,
                        width: 50,
                        margin: EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [Color(0xff1D5AF0), Color(0xffAEBEE3)]),
                            borderRadius: BorderRadius.circular(25)),
                        child: Icon(
                          Icons.arrow_downward_outlined,
                          color: Colors.white,
                        )),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          transactionList[index].transaction_type.toString(),
                          style: commonTextStyles(),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TransactionDateFormated(
                            transactionList[index].created_at.toString()),
                      ],
                    ),
                    Spacer(),
                    Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              "₹",
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.w700),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              transactionList[index].amount.toString(),
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Completed",
                          style: commonTextStyles(),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.arrow_forward_ios,
                        color: Color(0xff09098A),
                        size: 18,
                      ),
                    )
                  ],
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 16.0, right: 16.0, top: 8),
                  child: Divider(),
                ),
              ],
=======
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                          height: 50,
                          width: 50,
                          margin: EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Color(0xff1D5AF0),
                                    Color(0xffAEBEE3)
                                  ]),
                              borderRadius: BorderRadius.circular(25)),
                          child: Icon(
                            Icons.arrow_downward_outlined,
                            color: Colors.white,
                          )),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            transactionList[index].transaction_type.toString(),
                            style: commonTextStyles(),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TransactionDateFormated(
                              transactionList[index].created_at.toString()),
                        ],
                      ),
                      Spacer(),
                      Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                "₹",
                                style: TextStyle(
                                    fontSize: 22, fontWeight: FontWeight.w700),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                transactionList[index].amount.toString(),
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w700),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Completed",
                            style: commonTextStyles(),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.arrow_forward_ios,
                          color: Color(0xff09098A),
                          size: 18,
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 16.0, right: 16.0, top: 8),
                    child: Divider(),
                  ),
                ],
              ),
>>>>>>> d06bd2fee0f4c9bb3f5c8ab81bac27d6a822498d
            ),
          );
        });
  }

  transactionBottomSheet(context, TransactionModalClass trns) {
    var trns_txt = "";
    var amt = trns.amount;
    if (trns.transaction_type == "credit") {
      trns_txt = "Deposit Amount";
    } else {
      trns_txt = "Widrawal Amount";
    }
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
<<<<<<< HEAD
              return Container(
                height: 600,
                color: Color(0xffF1F2FB),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            height: 50,
                            width: 50,
                            margin: EdgeInsets.all(16.0),
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Color(0xff1D5AF0),
                                      Color(0xffAEBEE3)
                                    ]),
                                borderRadius: BorderRadius.circular(25)),
                            child: Icon(
                              Icons.arrow_downward_outlined,
                              color: Colors.white,
                            )),
                        Padding(
                          padding: const EdgeInsets.only(right: 16.0),
                          child: Text(
                            trns.transaction_type.toString(),
                            style: commonTextStyles(),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 18.0,
                        right: 18.0,
                      ),
                      child: Divider(),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("$trns_txt", style: commonTextStyles()),
                          Text(
                            "$amt INR",
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 15,
=======
              return SingleChildScrollView(
                child: Container(
                  // height: 600,
                  color: Color(0xffF1F2FB),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              height: 45,
                              width: 45,
                              margin: EdgeInsets.only(
                                  top: 10.0,
                                  bottom: 5.0,
                                  right: 16.0,
                                  left: 16.0),
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Color(0xff1D5AF0),
                                        Color(0xffAEBEE3)
                                      ]),
                                  borderRadius: BorderRadius.circular(25)),
                              child: Icon(
                                Icons.arrow_downward_outlined,
                                color: Colors.white,
                              )),
                          Padding(
                            padding: const EdgeInsets.only(right: 16.0),
                            child: Text(
                              trns.transaction_type.toString(),
                              style: commonTextStyles(),
>>>>>>> d06bd2fee0f4c9bb3f5c8ab81bac27d6a822498d
                            ),
                          ),
                        ],
                      ),
<<<<<<< HEAD
                    ),
                    Column(
                      children: [
                        Container(
                          margin: EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Status",
                                style: commonTextStyles(),
                              ),
                              Text(
                                "Completed".toUpperCase(),
                                style: commonTextStyles(),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 18.0,
                            right: 18.0,
                          ),
                          child: Divider(),
                        ),
                        Container(
                          margin: EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Payment Method",
                                style: commonTextStyles(),
                              ),
                              Text(
                                "UPI Payment Option 1",
                                style: commonTextStyles(),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 18.0,
                            right: 18.0,
                          ),
                          child: Divider(),
                        ),
                        Container(
                          margin: EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Created At",
                                style: commonTextStyles(),
                              ),
                              TransactionDateFormated(
                                  trns.created_at.toString()),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 18.0,
                            right: 18.0,
                          ),
                          child: Divider(),
                        ),
                        Container(
                          margin: EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "updated At",
                                style: commonTextStyles(),
                              ),
                              TransactionDateFormated(
                                  trns.updated_at.toString()),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 18.0,
                            right: 18.0,
                          ),
                          child: Divider(),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Container(
                            margin: EdgeInsets.all(2.0),
                            height: 30,
                            width: MediaQuery.of(context).size.width,
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Text(
                                "Transaction Successful",
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            decoration: BoxDecoration(
                              color: Color(0xffAEBEE3),
                              borderRadius: BorderRadius.circular(18),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
=======
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 20.0,
                          right: 20.0,
                        ),
                        child: Divider(),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("$trns_txt", style: commonTextStyles()),
                            Text(
                              "$amt INR",
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Status",
                                  style: commonTextStyles(),
                                ),
                                Text(
                                  "Completed".toUpperCase(),
                                  style: commonTextStyles(),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 18.0,
                              right: 18.0,
                            ),
                            child: Divider(),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Payment Method",
                                  style: commonTextStyles(),
                                ),
                                Text(
                                  "UPI Payment Option 1",
                                  style: commonTextStyles(),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 18.0,
                              right: 18.0,
                            ),
                            child: Divider(),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Created At",
                                  style: commonTextStyles(),
                                ),
                                TransactionDateFormated(
                                    trns.created_at.toString()),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 18.0,
                              right: 18.0,
                            ),
                            child: Divider(),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "updated At",
                                  style: commonTextStyles(),
                                ),
                                TransactionDateFormated(
                                    trns.updated_at.toString()),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 18.0,
                              right: 18.0,
                            ),
                            child: Divider(),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Container(
                              margin: EdgeInsets.all(2.0),
                              // height: 30,
                              width: MediaQuery.of(context).size.width,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0, vertical: 8.0),
                                child: Text(
                                  "Transaction Successful",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              decoration: BoxDecoration(
                                color: Color(0xffAEBEE3),
                                borderRadius: BorderRadius.circular(18),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5.0,
                          )
                        ],
                      ),
                    ],
                  ),
>>>>>>> d06bd2fee0f4c9bb3f5c8ab81bac27d6a822498d
                ),
              );
            },
          );
        });
  }
}
