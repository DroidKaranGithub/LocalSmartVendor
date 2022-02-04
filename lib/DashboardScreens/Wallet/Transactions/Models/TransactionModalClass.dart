class TransactionModalClass {
  String? id;
  String? transaction_id;
  String? user_id;
  String? transaction_type;
  String? amount;
  String? attachment;
  String? comment;
  String? created_at;
  String? updated_at;

  var message;
  var status;


  TransactionModalClass({
    this.id,
    this.transaction_id,
    this.transaction_type,
    this.amount,
    this.created_at,
    this.updated_at,
    this.comment,
    this.attachment,
    this.user_id,

  });

  TransactionModalClass.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    transaction_type = json['transaction_type'];
    transaction_id = json['transaction_id'];
    amount = json['amount'].toString();
    created_at = json['created_at'];
    updated_at = json['updated_at'];
    comment = json['comment'];
    attachment = json['attachment'];
    user_id = json['user_id'].toString();


  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.user_id;
    data['id'] = this.id;
    data['transaction_id'] = this.transaction_id;
    data['transaction_type'] = this.transaction_type;
    data['amount'] = this.amount;
    data['comment'] = this.comment;
    data['attachment'] = this.attachment;
    data['created_at'] = this.created_at;
    data['updated_at'] = this.updated_at;
    return data;
  }
}
