class TransactionResponseData {
  List<Transaction>? transaction;
  int? success;
  String? message;

  TransactionResponseData({this.transaction, this.success, this.message});

  TransactionResponseData.fromJson(Map<String, dynamic> json) {
    if (json['transaction'] != null) {
      transaction = <Transaction>[];
      json['transaction'].forEach((v) {
        transaction!.add(new Transaction.fromJson(v));
      });
    }
    success = int.tryParse('${json['success']}') ?? 0;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.transaction != null) {
      data['transaction'] = this.transaction!.map((v) => v.toJson()).toList();
    }
    data['success'] = this.success;
    data['message'] = this.message;
    return data;
  }
}

class TransactionModiFiedDataList {
  List<Transaction>? transaction;
  String? date = '';

  TransactionModiFiedDataList({this.transaction, this.date});
}

class Transaction {
  String? transactionId;
  String? type;
  String? remark;
  String? amount;
  String? teamName;
  String? time;
  String? statusRequest;
  String? statusProcess;
  String? statusCredit;

  bool? isExpanded;

  Transaction({
    this.transactionId,
    this.type,
    this.remark,
    this.amount,
    this.teamName,
    this.statusRequest,
    this.statusCredit,
    this.statusProcess,
    this.time,
    this.isExpanded = false,
  });

  Transaction.fromJson(Map<String, dynamic> json) {
    transactionId = json['transaction_id'] ?? '';
    type = json['type'] ?? '';
    remark = json['remark'] ?? '';
    amount = json['amount'] ?? '';
    teamName = json['team_name'] ?? '';
    time = json['time'] ?? '';
    statusRequest = json['status_request'] ?? '';
    statusProcess = json['status_process'] ?? '';
    statusCredit = json['status_credit'] ?? '';
    isExpanded = false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['transaction_id'] = this.transactionId;
    data['type'] = this.type;
    data['remark'] = this.remark;
    data['amount'] = this.amount;
    data['team_name'] = this.teamName;
    data['time'] = this.time;
    return data;
  }
}
