class NotificationRespo {
  int? success;
  String? message;
  List<NotificationData>? notificationData;

  NotificationRespo({this.success, this.message, this.notificationData});

  NotificationRespo.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['notification_data'] != null) {
      notificationData = <NotificationData>[];
      json['notification_data'].forEach((v) {
        notificationData!.add(new NotificationData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.notificationData != null) {
      data['notification_data'] =
          this.notificationData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class NotificationData {
  String? type;
  String? notificationDetail;
  String? date;

  NotificationData({this.type, this.notificationDetail, this.date});

  NotificationData.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    notificationDetail = json['notification_detail'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['notification_detail'] = this.notificationDetail;
    data['date'] = this.date;
    return data;
  }
}