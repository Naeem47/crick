class MatchInfoList {
  int? success;
  String? message;
  List<ShedualInfoData>? shedualData;

  MatchInfoList({this.success, this.message, this.shedualData});

  MatchInfoList.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['shedual_data'] != null) {
      shedualData = <ShedualInfoData>[];
      json['shedual_data'].forEach((v) {
        shedualData!.add(new ShedualInfoData.fromJson(v));
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

class ShedualInfoData {
  String? match;
  int? competitionId;
  String? seriesName;
  String? dateStart;
  String? timeStart;
  String? umpires;
  String? referee;
  String? venue;
  String? location;
  String? matchFormat;
  TeamLogo? teamLogo;

  ShedualInfoData(
      {this.match,
      this.competitionId,
      this.seriesName,
      this.dateStart,
      this.timeStart,
      this.umpires,
      this.referee,
      this.venue,
      this.matchFormat,
      this.location,
      this.teamLogo});

  ShedualInfoData.fromJson(Map<String, dynamic> json) {
    match = json['match'];
    competitionId = json['competition_id'];
    seriesName = json['series_name'];
    dateStart = json['date_start'];
    timeStart = json['time_start'];
    umpires = json['umpires'];
    referee = json['referee'];
    venue = json['venue'];
    location = json['location'];
    matchFormat = json['match_format'];
    teamLogo = json['team_logo'] != null
        ? new TeamLogo.fromJson(json['team_logo'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['match'] = this.match;
    data['competition_id'] = this.competitionId;
    data['series_name'] = this.seriesName;
    data['date_start'] = this.dateStart;
    data['time_start'] = this.timeStart;
    data['umpires'] = this.umpires;
    data['referee'] = this.referee;
    data['venue'] = this.venue;
    data['match_format'] = this.matchFormat;
    data['location'] = this.location;
    if (this.teamLogo != null) {
      data['team_logo'] = this.teamLogo!.toJson();
    }
    return data;
  }
}

class TeamLogo {
  A? a;
  B? b;

  TeamLogo({this.a, this.b});

  TeamLogo.fromJson(Map<String, dynamic> json) {
    a = json['a'] != null ? new A.fromJson(json['a']) : null;
    b = json['b'] != null ? new B.fromJson(json['b']) : null;
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

class A {
  int? teamId;
  String? name;
  String? shortName;
  String? logoUrl;

  A({this.teamId, this.name, this.shortName, this.logoUrl});

  A.fromJson(Map<String, dynamic> json) {
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

class B {
  int? teamId;
  String? name;
  String? shortName;
  String? logoUrl;

  B({this.teamId, this.name, this.shortName, this.logoUrl});

  B.fromJson(Map<String, dynamic> json) {
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
