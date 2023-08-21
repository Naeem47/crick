class PanCardResponse {
  String? success;
  String? message;
  List<PancardDetail>? pancardDetail;

  PanCardResponse({this.success, this.message, this.pancardDetail});

  PanCardResponse.fromJson(Map<String, dynamic> json) {
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
  String? pancardNo;
  String? pancardName;
  String? dob;
  String? pancardPhoto;

  PancardDetail({
    this.pancardNo = '',
    this.pancardName = '',
    this.dob = '',
    this.pancardPhoto = '',
  });

  PancardDetail.fromJson(Map<String, dynamic> json) {
    pancardNo = json['pancard_no'] ?? '';
    pancardName = json['pancard_name'] ?? '';
    dob = json['dob'] ?? '';
    pancardPhoto = json['pancard_photo'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pancard_no'] = this.pancardNo;
    data['pancard_name'] = this.pancardName;
    data['dob'] = this.dob;
    data['pancard_photo'] = this.pancardPhoto;
    return data;
  }
}
