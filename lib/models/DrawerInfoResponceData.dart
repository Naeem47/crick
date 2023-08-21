import 'package:tempalteflutter/models/userData.dart';

class UserDetail {
  String? success;
  String? message;
  UserData? data;

  UserDetail({this.success, this.message, this.data});

  UserDetail.fromJson(Map<String, dynamic> json) {
    success = json['success'].toString();
    message = json['message'];
    data = json['data'] != null ? new UserData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}
