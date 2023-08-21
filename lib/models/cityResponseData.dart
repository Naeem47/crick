class CityResponseData {
  int? success;
  List<CityList>? cityList;

  CityResponseData({this.success, this.cityList});

  CityResponseData.fromJson(Map<String, dynamic> json) {
    success = json['Success'];
    if (json['CityList'] != null) {
      cityList = <CityList>[];
      json['CityList'].forEach((v) {
        cityList!.add(new CityList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Success'] = this.success;
    if (this.cityList != null) {
      data['CityList'] = this.cityList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CityList {
  String? cityId;
  String? name;
  String? stateId;
  String? countryId;

  CityList({this.cityId, this.name, this.stateId, this.countryId});

  CityList.fromJson(Map<String, dynamic> json) {
    cityId = json['city_id'];
    name = json['name'];
    stateId = json['state_id'];
    countryId = json['country_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['city_id'] = this.cityId;
    data['name'] = this.name;
    data['state_id'] = this.stateId;
    data['country_id'] = this.countryId;
    return data;
  }
}