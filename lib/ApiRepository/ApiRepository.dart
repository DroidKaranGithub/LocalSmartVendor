import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:shop_project/Constants/Constant.dart';

class ApiRepository {
  Future<http.Response> RegisterOTPVerification(Object modal) async {
    print("inside verification $modal");
    String Url = BaseUrl + "verification";
    print("REQUEST---> $Url");
    var body = await http.post(Uri.parse(Url), body: modal);
    print("Response--> ${body.body}");
    return body;
  }
  //https://viragtea.com/localsmart/public/api/shop/store

  //   Future<http.Response> createShop(Object modal) async {
  //   String Url = BaseUrl + "shop/store";
  //   var body = await http.post(Uri.parse(Url), body: modal);
  //   return body;
  // }

  Future<http.Response> LoginOTPVerification(Object modal) async {
    String Url = BaseUrl + "verification";
    var body = await http.post(Uri.parse(Url), body: modal);
    return body;
  }

  Future<http.Response> Register(Map<String, dynamic> modal) async {
    print(modal);
    String Url = BaseUrl + "register";

    print(Url);
    var body = await http.post(Uri.parse(Url), body: modal);
    print("API_REQUEST-->${body.body}");
    return body;
  }

  Future<http.Response> Login(Object modal) async {
    print("login $modal");
    String Url = BaseUrl + "login";
    print("API_REQUEST-->$Url");
    var body = await http.post(Uri.parse(Url), body: modal);
    print("API_REQUEST-->${body.body}");
    return body;
  }

  Future<http.Response> RecordingUploader(Object modal) async {
    String Url = BaseUrl + "query/store";
    var body = await http.post(Uri.parse(Url), body: modal);
    return body;
  }

  Future<http.Response> AskFormUpload(Object modal) async {
    String Url = BaseUrl + "query/update/3";
    var body = await http.post(Uri.parse(Url), body: modal);
    return body;
  }

  Future<http.Response> GetInquries(shopId) async {
    //https://viragtea.com/localsmart/public/api/shop/query/list?shop_id=1
    String Url = BaseUrl + "get-shop-notify-queries/$shopId";
    debugPrint("GET_INQUIRY_URL-->$Url");
    var body = await http.get(
      Uri.parse(Url),
    );
    return body;
  }

  Future<http.Response> GetResponse() async {
    String Url = BaseUrl + "shop/query/details/1";
    var body = await http.get(
      Uri.parse(Url),
    );
    return body;
  }

  Future<http.Response> GetShopDetail(int userId) async {
    String Url = BaseUrl + "shops?user_id=$userId";
    var body = await http.get(
      Uri.parse(Url),
    );
    return body;
  }

  Future<http.Response> GetCategory() async {
    String Url = BaseUrl + "get-categories-list";
    var body = await http.get(
      Uri.parse(Url),
    );
    return body;
  }

  Future<http.Response> checkWalletAmount(quiryId, String userID) async {
    String Url = BaseUrl + "check-vendor-wallet-amount";
    var body = await http.post(Uri.parse(Url),
        body: {"user_id": "$userID", "query_id": "$quiryId"});
    return body;
  }

  Future<http.Response> ResendOtp(modal) async {
    String Url = BaseUrl + "resend";
    var body = await http.post(Uri.parse(Url), body: modal);
    return body;
  }
}
