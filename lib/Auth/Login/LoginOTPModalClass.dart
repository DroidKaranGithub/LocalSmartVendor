class LoginOTPModalClass {
  String? phone;
  String? otp;
  bool? Status;
  String? Msg;
  LoginOTPModalClass({this.phone, this.otp});

  LoginOTPModalClass.fromJson(Map<String, dynamic> json) {
    otp = json['otp'].toString();
    Msg = json['msg'];
    Status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['phone'] = phone;
    data['type'] = "2";
    data['otp'] = otp.toString();
    data['role_id'] = "2";
    return data;
  }
}
