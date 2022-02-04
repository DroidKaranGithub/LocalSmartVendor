import 'package:shop_project/Constants/LoaderClass.dart';
import 'package:shop_project/DashboardScreens/Wallet/coupons/Coupon%20UI/Coupons.dart';
import 'package:flutter/material.dart';
import 'package:shop_project/DashboardScreens/Wallet/CommonWidgets/Commonwidgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../../../../ConstantDrawer.dart';

class walletUI extends StatefulWidget {
  @override
  _walletUIState createState() => _walletUIState();
}

class _walletUIState extends State<walletUI> {
  late OverlayEntry loader;
  late Razorpay _razorpay;
  String textField = '';
  var height;
  final GlobalKey _TextKey = GlobalKey<FormState>();
  final TextEditingController AmountText = TextEditingController();
  FocusNode _focus = new FocusNode();
  bool _showKeyboard = false;

  String textToShowCard = "";
  late int FrstNo;
   String? res;
  late String opr;
  bool isbuttonsText = false;


  void btnClick(String buttonsText){
    print(buttonsText);
    if(buttonsText == null){
      "Enter Ammount";
    }else{
      res = int.parse(textToShowCard + buttonsText).toString();
      opr = buttonsText ;
      textToShowCard = " ";


    }
    setState(() {
      if(res.toString().isNotEmpty){
         AmountText.clear();

      }
      textToShowCard = res.toString();



    });

  }
  @override


  void initState() {
    // TODO: implement initState
    super.initState();
    _focus.addListener(_onFocusChange);
    res;

    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }
  void _onFocusChange() {
    setState(() {
      _showKeyboard = _focus.hasFocus;
    });
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _razorpay.clear();
  }
  final GlobalKey<ScaffoldState> _key1 = GlobalKey();

  @override
  Widget build(BuildContext context) {
    loader = Loader.overlayLoader(context);
    height = AppBar().preferredSize.height;
    return SafeArea(
      child: Scaffold(
        key: _key1,
        drawer: drawer(),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [Ui()],
          ),
        ),
      ),
    );
  }

  Widget Ui() {
    var buttonsText;
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: 32.0, left: 16.0),
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
                        "Wallet",
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w800,
                            color: Color(0xff09098A)),
                      )))
            ],
          ),
        ),
        Center(
          child: Container(
            margin: EdgeInsets.only(top: 32.0),
              child: Text(
            "How much do you want to add?",
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w800,
                color: Color(0xff09098A)),
          )),
        ),
        Container(
          margin: EdgeInsets.only(top: 32.0),
          width: 350,
          child: Form(
            key: _TextKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  margin: EdgeInsets.all(8.0),
                  shape: commonCardStyle(),
                  elevation: 5.0,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      onChanged: (wvalue){
                        textField = wvalue;
                      },
                      validator: (value){
                        value.toString().isEmpty ? "Enter Amount" : "";
                      },
                      focusNode: _focus,
                      controller: AmountText,
                      cursorHeight: 25,
                      textAlign: TextAlign.left,
                      decoration: InputDecoration(
                        prefixIcon: Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Text("₹",textAlign: TextAlign.center, style: TextStyle(fontSize: 25),),
                        ),
                        hintText:   res != null ? textToShowCard :"Enter Amount",
                        hintStyle: res != null ? TextStyle(
                          fontSize: 18,
                          color: Colors.black
                        ) :TextStyle(
                            fontSize: 18,
                            color: Colors.grey
                        ) ,
                        border: InputBorder.none,

                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 32.0, top: 8.0),
                  child: Text("Min. ₹ 50", style: TextStyle(fontSize: 16.0,color: Colors.grey),),
                ),
              ],
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.all(32.0),
          child: _shortcutKeyboard(),
        ),

        SizedBox(
          height: 100,
        ),
        // ElevatedButton(
        //     onPressed: (){
        //       // Navigator.of(context).push(MaterialPageRoute(builder: (context)=> CouponsPage()) );
        //     },
        //     style: commonContinueButtonStyle(),
        //     child: Text("Continue",style: TextStyle(fontSize: 20.0),)),
        // SizedBox(height: 50,),
        // Center(child: Text("OR")),
        // SizedBox(height: 50,),
        ElevatedButton(
          style:  commonContinueButtonStyle(),
            onPressed: () => openCheckOut(),
    child: Text("ADD MONEY",style: TextStyle(fontSize: 20.0),
    )


    ),
              // Navigator.of(context).push(MaterialPageRoute(builder: (context) =>) );


      ],
    );
  }
  Widget MoneyButtonCard(String buttonsText) {
    return InkWell(
      onTap: () {
        btnClick(buttonsText);
      } ,
      child: Card(
        elevation: 5.0,
        shadowColor: Colors.grey,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text("₹ ${buttonsText}"),
        ),
      ),
    );
  }
  Widget _shortcutKeyboard() {
    var keyboardKeys = [
      "50",
      "100",
      "200",
      "500",
      "1000",
    ];
    return Container(
        height: 53.0,
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: keyboardKeys.length,
          itemBuilder: (_, index) {
            var key = keyboardKeys[index];
            return InkWell(
              onTap: () {
                setState(() {
                  AmountText.text = key;
                });
              } ,
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
                  ),
                  elevation: 5.0,
                  shadowColor: Colors.grey,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(child: Text("₹ ${key}")),
                  ),
                ),
              ),
            );
          },
        ));
  }
  // Widget MoneyButtons(){
  //   return Container(
  //     margin: EdgeInsets.all(32.0),
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.spaceAround,
  //       children: [
  //         InkWell(
  //           onTap: (){},
  //           child: Card(
  //             elevation: 5.0,
  //             shadowColor: Colors.grey,
  //             child: Padding(
  //               padding: const EdgeInsets.all(10.0),
  //               child: Text("₹ 50"),
  //             ),
  //           ),
  //         ),
  //         InkWell(
  //           onTap: (){},
  //           child: Card(
  //             elevation: 5.0,
  //             shadowColor: Colors.grey,
  //             child: Padding(
  //               padding: const EdgeInsets.all(10.0),
  //               child: Text("₹ 100"),
  //             ),
  //
  //           ),
  //         ),
  //         InkWell(
  //           onTap: (){},
  //           child: Card(
  //             elevation: 5.0,
  //             shadowColor: Colors.grey,
  //             child: Padding(
  //               padding: const EdgeInsets.all(10.0),
  //               child: Text("₹ 150"),
  //             ),),
  //         ),
  //         InkWell(
  //           onTap: (){},
  //           child: Card(
  //             elevation: 5.0,
  //             shadowColor: Colors.grey,
  //             child: Padding(
  //               padding: const EdgeInsets.all(10.0),
  //               child: Text("₹ 200"),
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }




  // RESZOR PAY METHODS FOR SUccess AND all will be writ here...............
  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Do something when payment succeeds
    Fluttertoast.showToast(
        msg: "SUCCESS: " + response.paymentId!, toastLength: Toast.LENGTH_LONG);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
    Fluttertoast.showToast(
        msg: "ERROR: " + response.code.toString() + " - " + response.message!,
        toastLength: Toast.LENGTH_SHORT);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet was selected\
    Fluttertoast.showToast(
        msg: "EXTERNAL_WALLET: " + response.walletName!, toastLength: Toast.LENGTH_SHORT);
  }

  // REZOR PAY API AND KEY WILL BE  HERE.........................................
  void openCheckOut() async{
    int amountToPay = int.parse(AmountText.text.toString()) * 100; 
    var options = {
      'key': 'rzp_test_lngdtn4RvXhjcg',  /*Your online Key only key not keyID */
      'amount': "${amountToPay.toString()}",
      'name': 'Acme Corp',  /*name*/
      'description': 'Fine T-Shirt', /*desc.*/
      'prefill': {
        'contact': '8888888888', /*REgistor NO WILL BE HERE AS TEXTCANTROLLER*/
        'email': 'test@razorpay.com' /*REgistor email WILL BE HERE AS TEXTCANTROLLER   By USing Conatroctor*/
      },
      // 'external': {
      //   'wallets': ['paytm']
      // }
    };

    try{
      _razorpay.open(options);
    }catch(e){
      debugPrint('Error in Paymrngt : ${e.toString()}');

    }
  }

}
class MyDrawer extends StatefulWidget {
  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
