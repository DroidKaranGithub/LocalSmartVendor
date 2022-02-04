class ShopModalClass {
  List<ShopData>? data;
  int? totalCount;
  int? perPage;
  bool? status;

  ShopModalClass({this.data, this.totalCount, this.perPage, this.status});

  ShopModalClass.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <ShopData>[];
      json['data'].forEach((v) {
        data!.add(new ShopData.fromJson(v));
      });
    }
    totalCount = json['total_count'];
    perPage = json['per_page'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['total_count'] = this.totalCount;
    data['per_page'] = this.perPage;
    data['status'] = this.status;
    return data;
  }
}

class ShopData {
  int? id;
  int? userId;
  String? shopName;
  Null? ownerName;
  String? businessType;
  String? contactNumber;
  Null? email;
  Null? address;
  Null? websiteUrl;
  Null? gstNumber;
  Null? personalKycDocName;
  Null? personalKycDocNumber;
  Null? businessKycDocName;
  Null? businessKycDocNumber;
  List<ShopImages>? shopImages;
  int? stateId;
  int? cityId;
  Null? pincode;
  Null? address1;
  Null? mapLocation;
  Null? zipCode;
  int? status;
  int? verifiedStatus;
  String? driveLink;
  Null? latitude;
  Null? longitude;
  Null? businessKycDocumentId;
  Null? businessUploadedDocumentId;
  String? createdAt;
  String? updatedAt;
  Null? deletedAt;

  ShopData(
      {this.id,
      this.userId,
      this.shopName,
      this.ownerName,
      this.businessType,
      this.contactNumber,
      this.email,
      this.address,
      this.websiteUrl,
      this.gstNumber,
      this.personalKycDocName,
      this.personalKycDocNumber,
      this.businessKycDocName,
      this.businessKycDocNumber,
      this.shopImages,
      this.stateId,
      this.cityId,
      this.pincode,
      this.address1,
      this.mapLocation,
      this.zipCode,
      this.status,
      this.verifiedStatus,
      this.driveLink,
      this.latitude,
      this.longitude,
      this.businessKycDocumentId,
      this.businessUploadedDocumentId,
      this.createdAt,
      this.updatedAt,
      this.deletedAt});

  ShopData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    shopName = json['shop_name'];
    ownerName = json['owner_name'];
    businessType = json['business_type'];
    contactNumber = json['contact_number'];
    email = json['email'];
    address = json['address'];
    websiteUrl = json['website_url'];
    gstNumber = json['gst_number'];
    personalKycDocName = json['personal_kyc_doc_name'];
    personalKycDocNumber = json['personal_kyc_doc_number'];
    businessKycDocName = json['business_kyc_doc_name'];
    businessKycDocNumber = json['business_kyc_doc_number'];
    if (json['shop_images'] != null) {
      shopImages = <ShopImages>[];
      json['shop_images'].forEach((v) {
        shopImages!.add(new ShopImages.fromJson(v));
      });
    }
    stateId = json['state_id'];
    cityId = json['city_id'];
    pincode = json['pincode'];
    address1 = json['address1'];
    mapLocation = json['map_location'];
    zipCode = json['zip_code'];
    status = json['status'];
    verifiedStatus = json['verified_status'];
    driveLink = json['drive_link'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    businessKycDocumentId = json['business_kyc_document_id'];
    businessUploadedDocumentId = json['business_uploaded_document_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['shop_name'] = this.shopName;
    data['owner_name'] = this.ownerName;
    data['business_type'] = this.businessType;
    data['contact_number'] = this.contactNumber;
    data['email'] = this.email;
    data['address'] = this.address;
    data['website_url'] = this.websiteUrl;
    data['gst_number'] = this.gstNumber;
    data['personal_kyc_doc_name'] = this.personalKycDocName;
    data['personal_kyc_doc_number'] = this.personalKycDocNumber;
    data['business_kyc_doc_name'] = this.businessKycDocName;
    data['business_kyc_doc_number'] = this.businessKycDocNumber;
    if (this.shopImages != null) {
      data['shop_images'] = this.shopImages!.map((v) => v.toJson()).toList();
    }
    data['state_id'] = this.stateId;
    data['city_id'] = this.cityId;
    data['pincode'] = this.pincode;
    data['address1'] = this.address1;
    data['map_location'] = this.mapLocation;
    data['zip_code'] = this.zipCode;
    data['status'] = this.status;
    data['verified_status'] = this.verifiedStatus;
    data['drive_link'] = this.driveLink;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['business_kyc_document_id'] = this.businessKycDocumentId;
    data['business_uploaded_document_id'] = this.businessUploadedDocumentId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}

class ShopImages {
  String? image;

  ShopImages({this.image});

  ShopImages.fromJson(Map<String, dynamic> json) {
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    return data;
  }
}
