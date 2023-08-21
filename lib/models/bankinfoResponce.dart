class BankinfoResponce {
  String? success;
  String? message;
  List<PancardDetail>? pancardDetail;

  BankinfoResponce({this.success, this.message, this.pancardDetail});

  BankinfoResponce.fromJson(Map<String, dynamic> json) {
    success = '${json['success']}';
    message = json['message'];
    if (json['pancard_detail'] != null) {
      pancardDetail = <PancardDetail>[];
      json['pancard_detail'].forEach((v) {
        pancardDetail!.add(new PancardDetail.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.pancardDetail != null) {
      data['pancard_detail'] =
          this.pancardDetail!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PancardDetail {
  String? accountNo;
  String? accountName;
  String? ifscCode;
  String? branchName;
  String? address;
  String? accountPhoto;

  PancardDetail({
    this.accountNo = '',
    this.accountName = '',
    this.ifscCode = '',
    this.branchName = '',
    this.address = '',
    this.accountPhoto = '',
  });

  PancardDetail.fromJson(Map<String, dynamic> json) {
    accountNo = json['account_no'] ?? '';
    accountName = json['account_name'] ?? '';
    ifscCode = json['ifsc_code'] ?? '';
    branchName = json['branch_name'] ?? '';
    address = json['address'] ?? '';
    accountPhoto = json['account_photo'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['account_no'] = this.accountNo;
    data['account_name'] = this.accountName;
    data['ifsc_code'] = this.ifscCode;
    data['branch_name'] = this.branchName;
    data['address'] = this.address;
    data['account_photo'] = this.accountPhoto;
    return data;
  }
}
