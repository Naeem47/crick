import 'package:tempalteflutter/models/teamResponseData.dart';

class LeagueMemberTeamResponse {
  int? success;
  String? message;
  List<Leagues>? leagues;

  LeagueMemberTeamResponse({this.success, this.message, this.leagues});

  LeagueMemberTeamResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['leagues'] != null) {
      leagues = <Leagues>[];
      json['leagues'].forEach((v) {
        leagues!.add(new Leagues.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.leagues != null) {
      data['leagues'] = this.leagues!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Leagues {
  String? leagueId;
  String? leagueName;
  List<TeamData>? leagueMember;
  List<PlayerScore>? playerScore;

  Leagues({this.leagueId, this.leagueName, this.leagueMember, this.playerScore});

  Leagues.fromJson(Map<String, dynamic> json) {
    leagueId = json['league_id'];
    leagueName = json['league_name'];
    if (json['league_member'] != null) {
      leagueMember = <TeamData>[];
      json['league_member'].forEach((v) {
        leagueMember!.add(new TeamData.fromJson(v));
      });
    }
    if (json['player_score'] == false) {
      playerScore = <PlayerScore>[];
    } else if (json['player_score'] != null) {
      playerScore = <PlayerScore>[];
      json['player_score'].forEach((v) {
        playerScore!.add(new PlayerScore.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['league_id'] = this.leagueId;
    data['league_name'] = this.leagueName;
    if (this.leagueMember != null) {
      data['league_member'] = this.leagueMember!.map((v) => v.toJson()).toList();
    }
    if (this.playerScore != null) {
      data['player_score'] = this.playerScore!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PlayerScore {
  String? playerName;
  String? playerKey;
  double? point;
  String? playertype;

  PlayerScore({this.playerName, this.playerKey, this.point, this.playertype});

  PlayerScore.fromJson(Map<String, dynamic> json) {
    playerName = json['player_name'] ?? '';
    playerKey = json['player_key'] ?? '';
    point = double.parse('${json['point']}');
    playertype = json['playertype'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['player_name'] = this.playerName;
    data['player_key'] = this.playerKey;
    data['point'] = this.point;
    data['playertype'] = this.playertype;
    return data;
  }
}
