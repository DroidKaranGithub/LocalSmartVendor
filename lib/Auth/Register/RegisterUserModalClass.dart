class RegisterUserModalClass {
  String? Name;
  String? Email;
  String? Mobile;
  var Msg;
  var Status;

  RegisterUserModalClass({this.Mobile, this.Email, this.Name});

  RegisterUserModalClass.fromJson(Map<String, dynamic> json) {
    Status = json['code'];
    Msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = Name;
    data['city'] = "Udaipur";
    data['phone'] = Mobile;
    data['email'] = "";
    data['role_id'] = "2";
    return data;
  }
}
