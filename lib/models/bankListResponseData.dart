class BankListResponseData {
  int? success;
  String? message;
  List<AccountDetail>? accountDetail;

  BankListResponseData({this.success, this.message, this.accountDetail});

  BankListResponseData.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['account_detail'] != null) {
      accountDetail = <AccountDetail>[];
      json['account_detail'].forEach((v) {
        accountDetail!.add(new AccountDetail.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.accountDetail != null) {
      data['account_detail'] =
          this.accountDetail!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AccountDetail {
  String? bankAccountId;
  String? accountNo;
  String? accountName;
  String? bankImage;
  String? ifscCode;
  String? branchName;
  String? address;
  String? userId;
  String? status;
  String? createdTime;
  String? updatedTime;
  bool? isSelected = false;

  AccountDetail({
    this.bankAccountId = '',
    this.accountNo = '',
    this.accountName = '',
    this.bankImage = '',
    this.ifscCode = '',
    this.branchName = '',
    this.address = '',
    this.userId = '',
    this.status = '',
    this.createdTime = '',
    this.isSelected = false,
    this.updatedTime = '',
  });

  AccountDetail.fromJson(Map<String, dynamic> json) {
    bankAccountId = json['bank_account_id'];
    accountNo = json['account_no'];
    accountName = json['account_name'];
    bankImage = json['bank_image'];
    ifscCode = json['ifsc_code'];
    branchName = json['branch_name'];
    address = json['address'];
    userId = json['user_id'];
    status = json['status'];
    createdTime = json['created_time'];
    updatedTime = json['updated_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bank_account_id'] = this.bankAccountId;
    data['account_no'] = this.accountNo;
    data['account_name'] = this.accountName;
    data['bank_image'] = this.bankImage;
    data['ifsc_code'] = this.ifscCode;
    data['branch_name'] = this.branchName;
    data['address'] = this.address;
    data['user_id'] = this.userId;
    data['status'] = this.status;
    data['created_time'] = this.createdTime;
    data['updated_time'] = this.updatedTime;
    return data;
  }
}
