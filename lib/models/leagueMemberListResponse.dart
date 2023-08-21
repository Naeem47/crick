class LeagueMemberListResponse {
  int? success;
  String? message;
  List<Leagues>? leagues;

  LeagueMemberListResponse({this.success, this.message, this.leagues});

  LeagueMemberListResponse.fromJson(Map<String, dynamic> json) {
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
  List<LeagueMember>? leagueMember;

  Leagues({this.leagueId, this.leagueName, this.leagueMember});

  Leagues.fromJson(Map<String, dynamic> json) {
    leagueId = json['league_id'];
    leagueName = json['league_name'];
    if (json['league_member'] != null) {
      leagueMember = <LeagueMember>[];
      json['league_member'].forEach((v) {
        leagueMember!.add(new LeagueMember.fromJson(v));
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
    return data;
  }
}

class LeagueMember {
  String? teamId;
  String? userId;
  String? image;
  double? points;
  String? teamName;
  String? winningStatus;
  String? winningAmount;
  String? pointsStatus;
  int? rank;

  LeagueMember({
    this.teamId,
    this.userId,
    this.points,
    this.teamName,
    this.winningAmount,
    this.rank,
    this.image,
  });

  LeagueMember.fromJson(Map<String, dynamic> json) {
    teamId = json['team_id'];
    userId = json['user_id'] ?? '';
    points = double.parse('${json['points']}');
    teamName = json['team_name'] ?? '';
    image = json['image'] ?? '';
    winningStatus = json['winning_status'] ?? '';
    pointsStatus = json['points_status'] ?? '';
    winningAmount = json['winning_amount'] ?? '';
    rank = json['rank'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['team_id'] = this.teamId;
    data['user_id'] = this.userId;
    data['points'] = this.points;
    data['team_name'] = this.teamName;
    data['rank'] = this.rank;
    data['image'] = this.image;
    data['winning_amount'] = this.winningAmount;
    return data;
  }
}
