class CoutnryResponseData {
  int? success;
  List<CountryList>? countryList;

  CoutnryResponseData({this.success, this.countryList});

  CoutnryResponseData.fromJson(Map<String, dynamic> json) {
    success = json['Success'];
    if (json['CountryList'] != null) {
      countryList = <CountryList>[];
      json['CountryList'].forEach((v) {
        countryList!.add(new CountryList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Success'] = this.success;
    if (this.countryList != null) {
      data['CountryList'] = this.countryList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CountryList {
  String? countryId;
  String? name;
  String? phonecode;

  CountryList({this.countryId, this.name, this.phonecode});

  CountryList.fromJson(Map<String, dynamic> json) {
    countryId = json['country_id'];
    name = json['name'];
    phonecode = json['phonecode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['country_id'] = this.countryId;
    data['name'] = this.name;
    data['phonecode'] = this.phonecode;
    return data;
  }
}