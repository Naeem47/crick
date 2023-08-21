class ScheduleResponseData {
  int? success;
  String? message;
  List<ShedualData>? shedualData;

  ScheduleResponseData({this.success, this.message, this.shedualData});

  ScheduleResponseData.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['shedual_data'] != null) {
      shedualData = <ShedualData>[];
      json['shedual_data'].forEach((v) {
        shedualData!.add(new ShedualData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.shedualData != null) {
      data['shedual_data'] = this.shedualData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ShedualData {
  int? matchId;
  String? match;
  String? preSquad;
  int? competitionId;
  String? seriesName;
  String? isResult;
  String? dateStart;
  String? timeStart;
  TeamLogo? teamLogo;
  String? lineupsOut;
  String? teamAName;
  String? teamBName;

  ShedualData({
    this.matchId,
    this.match,
    this.preSquad,
    this.competitionId,
    this.seriesName,
    this.dateStart,
    this.lineupsOut,
    this.isResult = '',
    this.timeStart,
    this.teamLogo,
  });

  ShedualData.fromJson(Map<String, dynamic> json) {
    matchId = json['match_id'];
    match = json['match'];
    preSquad = json['pre_squad'];
    competitionId = json['competition_id'];
    seriesName = json['series_name'];
    dateStart = json['date_start'];
    lineupsOut = json['lineups_out'];
    timeStart = json['time_start'];
    teamLogo = json['team_logo'] != null ? new TeamLogo.fromJson(json['team_logo']) : null;
    isResult = '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['match_id'] = this.matchId;
    data['match'] = this.match;
    data['pre_squad'] = this.preSquad;
    data['lineups_out'] = this.lineupsOut;
    data['competition_id'] = this.competitionId;
    data['series_name'] = this.seriesName;
    data['date_start'] = this.dateStart;
    data['time_start'] = this.timeStart;
    if (this.teamLogo != null) {
      data['team_logo'] = this.teamLogo!.toJson();
    }
    return data;
  }
}

class TeamLogo {
  TeamData? a;
  TeamData? b;

  TeamLogo({this.a, this.b});

  TeamLogo.fromJson(Map<String, dynamic> json) {
    a = json['a'] != null ? new TeamData.fromJson(json['a']) : null;
    b = json['b'] != null ? new TeamData.fromJson(json['b']) : null;
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

class TeamData {
  int? teamId;
  String? name;
  String? shortName;
  String? logoUrl;

  TeamData({this.teamId, this.name, this.shortName, this.logoUrl});

  TeamData.fromJson(Map<String, dynamic> json) {
    teamId = json['team_id'];
    name = json['name'];
    shortName = json['short_name'];
    logoUrl = json['logo_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['team_id'] = this.teamId;
    data['name'] = this.name;
    data['short_name'] = this.shortName;
    data['logo_url'] = this.logoUrl;
    return data;
  }
}
