class PlayerMachPointResponse {
  List<PlayerData>? playerData;
  double? totalPoint;
  int? success;
  String? message;

  PlayerMachPointResponse(
      {this.playerData, this.totalPoint, this.success, this.message});

  PlayerMachPointResponse.fromJson(Map<String, dynamic> json) {
    if (json['player_data'] != null) {
      playerData = <PlayerData>[];
      json['player_data'].forEach((v) {
        playerData!.add(new PlayerData.fromJson(v));
      });
    }
    totalPoint = double.parse('${json['total_point']}');
    success = json['success'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.playerData != null) {
      data['player_data'] = this.playerData!.map((v) => v.toJson()).toList();
    }
    data['total_point'] = this.totalPoint;
    data['success'] = this.success;
    data['message'] = this.message;
    return data;
  }
}

class PlayerData {
  int? matchId;
  TeamLogo? teamLogo;
  String? playedDate;
  String? playerPoint;

  PlayerData({this.matchId, this.teamLogo, this.playedDate, this.playerPoint});

  PlayerData.fromJson(Map<String, dynamic> json) {
    matchId = json['match_id'];
    teamLogo = json['team_logo'] != null
        ? new TeamLogo.fromJson(json['team_logo'])
        : null;
    playedDate = json['played_date'];
    playerPoint = json['player_point'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['match_id'] = this.matchId;
    if (this.teamLogo != null) {
      data['team_logo'] = this.teamLogo!.toJson();
    }
    data['played_date'] = this.playedDate;
    data['player_point'] = this.playerPoint;
    return data;
  }
}

class TeamLogo {
  TeamLogoData? a;
  TeamLogoData? b;

  TeamLogo({this.a, this.b});

  TeamLogo.fromJson(Map<String, dynamic> json) {
    a = json['a'] != null ? new TeamLogoData.fromJson(json['a']) : null;
    b = json['b'] != null ? new TeamLogoData.fromJson(json['b']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.a != null) {
      data['a'] = this.a!.toJson();
    }
    if (this.b != null) {
      data['b'] = this.b!.toJson();
    }
    return data;
  }
}

class TeamLogoData {
  String? name;
  String? logoUrl;

  TeamLogoData({this.name, this.logoUrl});

  TeamLogoData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    logoUrl = json['logo_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['logo_url'] = this.logoUrl;
    return data;
  }
}
