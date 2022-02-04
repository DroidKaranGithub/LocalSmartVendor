class TransactionAvailableBalanceModalClass {
  String? id;
  String? wallet_balance;



  TransactionAvailableBalanceModalClass({
    this.id,
    this.wallet_balance,

  });

  TransactionAvailableBalanceModalClass.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    wallet_balance = json['wallet_balance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['wallet_balance'] = this.wallet_balance;
    return data;
  }
}
