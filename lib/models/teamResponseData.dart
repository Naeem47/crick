class GetTeamResponseData {
  List<TeamData>? teamData;
  int? success;
  String? message;

  GetTeamResponseData({this.teamData, this.success, this.message});

  GetTeamResponseData.fromJson(Map<String, dynamic> json) {
    if (json['team_data'] != null) {
      teamData = <TeamData>[];
      json['team_data'].forEach((v) {
        teamData!.add(new TeamData.fromJson(v));
      });
    }
    success = int.tryParse('${json['success']}') ?? 0;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.teamData != null) {
      data['team_data'] = this.teamData!.map((v) => v.toJson()).toList();
    }
    data['success'] = this.success;
    data['message'] = this.message;
    return data;
  }
}

class TeamData {
  String? teamId;
  String? teamName;
  String? captun;
  String? wiseCaptun;
  String? wicketKeeper;
  String? bowler;
  String? bastman;
  String? allRounder;
  String? userId;
  String? createdTime;
  String? updatedTime;
  String? isDelete;
  String? matchKey;
  String? competitionId;
  String? winningStatus;
  String? pointsStatus;
  bool? isSelected;
  double? points;

  TeamData(
      {this.teamId,
      this.teamName,
      this.captun,
      this.wiseCaptun,
      this.wicketKeeper,
      this.bowler,
      this.bastman,
      this.allRounder,
      this.userId,
      this.createdTime,
      this.updatedTime,
      this.isDelete,
      this.matchKey,
      this.competitionId,
      this.isSelected,
      this.winningStatus,
      this.pointsStatus,
      this.points});

  TeamData.fromJson(Map<String, dynamic> json) {
    teamId = json['team_id'] ?? '';
    teamName = json['team_name'] ?? '';
    captun = json['captun'] ?? '';
    wiseCaptun = json['wise_captun'] ?? '';
    wicketKeeper = json['wicket_keeper'] ?? '';
    bowler = json['bowler'] ?? '';
    bastman = json['bastman'] ?? '';
    allRounder = json['all_rounder'] ?? '';
    userId = json['user_id'] ?? '';
    createdTime = json['created_time'] ?? '';
    updatedTime = json['updated_time'] ?? '';
    isDelete = json['is_delete'] ?? '';
    matchKey = json['match_key'] ?? '';
    competitionId = json['competition_id'] ?? '';
    winningStatus = json['winning_status'] ?? '';
    pointsStatus = json['points_status'] ?? '';
    isSelected = false;
    points = double.tryParse('${json['points']}') ?? 0.0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['team_id'] = this.teamId;
    data['team_name'] = this.teamName;
    data['captun'] = this.captun;
    data['wise_captun'] = this.wiseCaptun;
    data['wicket_keeper'] = this.wicketKeeper;
    data['bowler'] = this.bowler;
    data['bastman'] = this.bastman;
    data['all_rounder'] = this.allRounder;
    data['user_id'] = this.userId;
    data['created_time'] = this.createdTime;
    data['updated_time'] = this.updatedTime;
    data['is_delete'] = this.isDelete;
    data['match_key'] = this.matchKey;
    data['competition_id'] = this.competitionId;
    data['isSelected'] = this.isSelected;
    data['points'] = this.points;
    return data;
  }
}
