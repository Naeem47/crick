class AppVersionResponce {
  List<Setting>? setting;
  int? success;
  String? message;

  AppVersionResponce({this.setting, this.success, this.message});

  AppVersionResponce.fromJson(Map<String, dynamic> json) {
    if (json['setting'] != null) {
      setting = <Setting>[];
      json['setting'].forEach((v) {
        setting!.add(new Setting.fromJson(v));
      });
    }
    success = json['success'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.setting != null) {
      data['setting'] = this.setting!.map((v) => v.toJson()).toList();
    }
    data['success'] = this.success;
    data['message'] = this.message;
    return data;
  }
}

class Setting {
  String? vId;
  String? vDeatil;
  String? siteUrl;
  String? updatedTime;

  Setting({this.vId, this.vDeatil, this.siteUrl, this.updatedTime});

  Setting.fromJson(Map<String, dynamic> json) {
    vId = json['v_id'] ?? '';
    vDeatil = json['v_deatil'] ?? '';
    siteUrl = json['site_url'] ?? '';
    updatedTime = json['updated_time'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['v_id'] = this.vId;
    data['v_deatil'] = this.vDeatil;
    data['site_url'] = this.siteUrl;
    data['updated_time'] = this.updatedTime;
    return data;
  }
}
