import 'package:shop_project/DashboardScreens/Shop/ShopModalClass.dart';

class ShopListData {
  String? shop_name;
  String? category;
  String? inquiry;
  String? id;
  // ShopData? shopData;
  ShopListData({this.shop_name, this.category, this.inquiry, this.id,
    //this.shopData
  });

  factory ShopListData.fromJson(Map<String, dynamic> json) {
    return ShopListData(
        shop_name: json['shop_name'],
        category: json['category'],
        id: json['id'].toString(),
        inquiry: json['shpo_queries_count'].toString(),
       // shopData: ShopData.fromJson(json)
    );

  }
}
