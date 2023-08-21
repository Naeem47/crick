class SquadsResponseData {
  int? success = 0;
  String? message = '';
  List<Players>? playerList;

  SquadsResponseData({this.success, this.message, this.playerList});

  SquadsResponseData.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['player_list'] != null) {
      playerList = <Players>[];
      json['player_list'].forEach((v) {
        playerList!.add(new Players.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.playerList != null) {
      data['player_list'] = this.playerList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Players {
  int? pid;
  String? title;
  String? shortName;
  String? firstName;
  String? lastName;
  String? middleName;
  String? birthdate;
  String? birthplace;
  String? country;
  String? playingRole;
  String? battingStyle;
  String? bowlingStyle;
  String? fieldingPosition;
  String? teamName;
  int? fantasyPlayerRating;
  String? nationality;
  int? teamId;
  String? playing11;
  double? point;
  bool? isSelcted;
  bool? isVC;
  bool? isC;

  Players({
    this.pid,
    this.title,
    this.shortName,
    this.firstName,
    this.lastName,
    this.middleName,
    this.birthdate,
    this.birthplace,
    this.country,
    this.playingRole,
    this.battingStyle,
    this.bowlingStyle,
    this.fieldingPosition,
    this.teamName,
    this.fantasyPlayerRating,
    this.nationality,
    this.teamId,
    this.point = 0.0,
    this.isSelcted = false,
    this.isVC = false,
    this.isC = false,
    this.playing11,
  });

  Players.fromJson(Map<String, dynamic> json) {
    pid = json['pid'];
    title = json['title'];
    shortName = json['short_name'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    middleName = json['middle_name'];
    birthdate = json['birthdate'] ?? '';
    birthplace = json['birthplace'];
    country = json['country'];
    playingRole = json['playing_role'];
    battingStyle = json['batting_style'] ?? '';
    bowlingStyle = json['bowling_style'] ?? '';
    fieldingPosition = json['fielding_position'];
    teamName = json['team_name'];
    fantasyPlayerRating = json['fantasy_player_rating'];
    nationality = json['nationality'] ?? '';
    teamId = json['team_id'];
    isSelcted = false;
    isVC = false;
    point = 0.0;
    isC = false;
    playing11 = json['playing11'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pid'] = this.pid;
    data['title'] = this.title;
    data['short_name'] = this.shortName;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['middle_name'] = this.middleName;
    data['birthdate'] = this.birthdate;
    data['birthplace'] = this.birthplace;
    data['country'] = this.country;
    data['playing_role'] = this.playingRole;
    data['batting_style'] = this.battingStyle;
    data['bowling_style'] = this.bowlingStyle;
    data['fielding_position'] = this.fieldingPosition;
    data['team_name'] = this.teamName;
    data['fantasy_player_rating'] = this.fantasyPlayerRating;
    data['nationality'] = this.nationality;
    data['team_id'] = this.teamId;
    data['playing11'] = this.playing11;
    data['isSelcted'] = this.isSelcted;
    return data;
  }
}
