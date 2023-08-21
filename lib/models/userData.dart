class UserData {
  String? userId;
  String? email;
  String? mobileNumber;
  String? cashBonus;
  String? balance;
  String? deposit;
  String? winingAmount;
  String? referral;
  String? name;
  String? dob;
  String? gender;
  String? favouriteTeams;
  String? address;
  String? city;
  String? state;
  String? country;
  String? pincode;
  String? pancardNumber;
  String? bankName;
  String? bankAccountNumber;
  String? bankAccountName;
  String? bankIfsc;
  String? isVeryfy;
  String? createdTime;
  String? updatedTime;
  String? isDelete;
  String? image;
  String? referralCode;
  String? totalLeague;
  String? totalMatches;
  String? totalSeries;
  String? totalWins;

  UserData({
    this.userId = '',
    this.email = '',
    this.mobileNumber = '',
    this.cashBonus = '',
    this.balance = '0',
    this.winingAmount = '',
    this.referral = '',
    this.name = '',
    this.dob = '',
    this.gender = '',
    this.favouriteTeams = '',
    this.address = '',
    this.city = '',
    this.state = '',
    this.country = '',
    this.pincode = '',
    this.pancardNumber = '',
    this.bankName = '',
    this.bankAccountNumber = '',
    this.bankAccountName = '',
    this.bankIfsc = '',
    this.isVeryfy = '',
    this.createdTime = '',
    this.updatedTime = '',
    this.isDelete = '',
    this.image = '',
    this.referralCode = '',
    this.totalLeague = '',
    this.totalMatches = '',
    this.deposit = '',
    this.totalSeries = '',
    this.totalWins = '',
  });

  UserData.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'] ?? '';
    email = json['email'] ?? '';
    mobileNumber = json['mobile_number'] ?? '';
    cashBonus = json['cash_bonus'] ?? '';
    balance = json['balance'] ?? '0';
    winingAmount = json['wining_amount'] ?? '';
    referral = json['referral'] ?? '';
    name = json['name'] ?? '';
    dob = json['dob'] ?? '';
    gender = json['gender'] ?? '';
    favouriteTeams = json['favourite_teams'] ?? '';
    address = json['address'] ?? '';
    city = json['city'] ?? '';
    state = json['state'] ?? '';
    country = json['country'] ?? '';
    pincode = json['pincode'] ?? '';
    pancardNumber = json['pancard_number'] ?? '';
    bankName = json['bank_name'] ?? '';
    bankAccountNumber = json['bank_account_number'] ?? '';
    bankAccountName = json['bank_account_name'] ?? '';
    bankIfsc = json['bank_ifsc'] ?? '';
    isVeryfy = json['is_veryfy'] ?? '';
    createdTime = json['created_time'] ?? '';
    updatedTime = json['updated_time'] ?? '';
    isDelete = json['is_delete'] ?? '';
    image = json['image'] ?? '';
    referralCode = json['referral_code'] ?? '';
    totalLeague = json['total_league'] ?? '';
    totalMatches = json['total_matches'] ?? '';
    deposit = json['deposit'] ?? '';
    totalSeries = json['total_series']?? '';
    totalWins = json['total_wins']?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['email'] = this.email;
    data['mobile_number'] = this.mobileNumber;
    data['cash_bonus'] = this.cashBonus;
    data['balance'] = this.balance;
    data['wining_amount'] = this.winingAmount;
    data['referral'] = this.referral;
    data['name'] = this.name;
    data['dob'] = this.dob;
    data['gender'] = this.gender;
    data['favourite_teams'] = this.favouriteTeams;
    data['address'] = this.address;
    data['city'] = this.city;
    data['state'] = this.state;
    data['country'] = this.country;
    data['pincode'] = this.pincode;
    data['pancard_number'] = this.pancardNumber;
    data['bank_name'] = this.bankName;
    data['bank_account_number'] = this.bankAccountNumber;
    data['bank_account_name'] = this.bankAccountName;
    data['bank_ifsc'] = this.bankIfsc;
    data['is_veryfy'] = this.isVeryfy;
    data['created_time'] = this.createdTime;
    data['updated_time'] = this.updatedTime;
    data['is_delete'] = this.isDelete;
    data['image'] = this.image;
    data['referral_code'] = this.referralCode;
    data['total_league'] = this.totalLeague;
    data['total_matches'] = this.totalMatches;
    data['deposit'] = this.deposit;
    data['total_series'] = this.totalSeries;
    data['total_weries'] = this.totalWins;
    return data;
  }
}
