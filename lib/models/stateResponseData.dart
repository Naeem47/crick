// ignore_for_file: unnecessary_null_comparison

class StateResponseData {
  int? success;
  List<StateList>? stateList;

  StateResponseData({this.success, this.stateList});

  StateResponseData.fromJson(Map<String, dynamic> json) {
    success = int.tryParse('${json['success']}') ?? 0;
    if (json['StateList'] != null) {
      stateList = <StateList>[];
      json['StateList'].forEach((v) {
        stateList!.add(new StateList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Success'] = this.success;
    if (this.stateList != null) {
      data['StateList'] = this.stateList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class StateList {
  String? stateId;
  String? name;
  String? countryId;

  StateList({this.stateId, this.name, this.countryId});

  StateList.fromJson(Map<String, dynamic> json) {
    stateId = json['state_id'];
    name = json['name'];
    countryId = json['country_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['state_id'] = this.stateId;
    data['name'] = this.name;
    data['country_id'] = this.countryId;
    return data;
  }
}