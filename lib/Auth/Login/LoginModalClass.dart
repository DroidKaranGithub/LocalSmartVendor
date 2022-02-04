class LoginModalClass {
  String? Mobile;
  String? Msg;
  bool? Status;
  int? Code;
  LoginUser? user;
  LoginModalClass({this.Mobile});

  LoginModalClass.fromJson(Map<String, dynamic> json) {
    //print(json['code'].runtimeType);
    //print(json['user']['id'].runtimeType);

    Code = json['code'];
    Msg = json['message'];
    print(Status);
    print(Msg);
    user = (json['user'] != null ? new LoginUser.fromJson(json['user']) : null);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['phone'] = Mobile;
    data['otp'] = data['type'] = "2";
    data['role_id'] = "2";
    return data;
  }
}

class LoginUser {
  String? id;
  String? roleId;
  String? role;
  String? name;
  String? email;
  String? phone;
  String? address;
  String? address2;
  String? cityId;
  String? stateId;
  String? driveLink;
  String? profile_image;
  String? currentLocation;
  String? emailVerifiedAt;
  String? verifiyStatus;
  String? otpVerified;
  String? otp;
  String? status;
  String? createdAt;
  String? profile;
  String? updatedAt;
  String? deletedAt;
  String? wallet_balance;
  LoginUser(
      {this.id,
      this.roleId,
      this.role,
      this.name,
      this.email,
      this.phone,
      this.address,
      this.address2,
      this.cityId,
      this.stateId,
      this.driveLink,
      this.profile_image,
      this.currentLocation,
      this.emailVerifiedAt,
      this.verifiyStatus,
      this.otpVerified,
      this.otp,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.profile,
      this.wallet_balance});

  LoginUser.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    roleId = json['role_id'].toString();
    role = json['role'].toString();
    name = json['name'].toString();
    email = json['email'].toString();
    phone = json['phone'].toString();
    address = json['address'].toString();
    address2 = json['address2'].toString();
    cityId = json['city_id'].toString();
    stateId = json['state_id'].toString();
    driveLink = json['drive_link'].toString();
    profile_image = json['profile_image'].toString();
    currentLocation = json['current_location'].toString();
    emailVerifiedAt = json['email_verified_at'].toString();
    verifiyStatus = json['verifiy_status'].toString();
    otpVerified = json['otp_verified'].toString();
    otp = json['otp'].toString().toString();
    status = json['status'].toString();
    createdAt = json['created_at'].toString();
    updatedAt = json['updated_at'].toString();
    deletedAt = json['deleted_at'].toString();
    profile = json['profile'].toString();
    wallet_balance = json['wallet_balance'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['role_id'] = this.roleId;
    data['role'] = this.role;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['address'] = this.address;
    data['address2'] = this.address2;
    data['city_id'] = this.cityId;
    data['state_id'] = this.stateId;
    data['drive_link'] = this.driveLink;
    data['profile_image'] = this.profile_image;
    data['current_location'] = this.currentLocation;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['verifiy_status'] = this.verifiyStatus;
    data['otp_verified'] = this.otpVerified;
    data['otp'] = this.otp;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    data['wallet_balance'] = this.wallet_balance;
    return data;
  }
}
