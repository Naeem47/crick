import 'package:intl/intl.dart';
import 'package:tempalteflutter/models/scheduleResponseData.dart';

class ShedualResults {
  ShedualData? shedual;
  List<LeagueData>? leagueData;

  ShedualResults({this.shedual, this.leagueData});

  ShedualResults.fromJson(Map<String, dynamic> json) {
    shedual = json['shedual'] != null
        ? new ShedualData.fromJson(json['shedual'])
        : null;
    if (json['league_data'] != null) {
      leagueData = <LeagueData>[];
      json['league_data'].forEach((v) {
        leagueData!.add(new LeagueData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.shedual != null) {
      data['shedual'] = this.shedual!.toJson();
    }
    if (this.leagueData != null) {
      data['league_data'] = this.leagueData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ModifiedLeagueList {
  LeagueData? contestsHedder;
  List<LeagueData>? contestsLeagueListData = <LeagueData>[];

  ModifiedLeagueList({this.contestsHedder, this.contestsLeagueListData});
}

class LeagueData {
  String? leagueId;
  String? teamId;
  String? matchKey;
  String? userId;
  String? teamName;
  String? isFull;
  String? entryFees;
  String? totalTeam;
  String? remainingTeam;
  String? totalWiner;
  String? totalWiningAmount;
  String? winningAmount;
  String? pointsStatus;
  String? winningStatus;
  String? isResult;
  int? createdTime;
  int? rank;
  double? points;

  LeagueData({
    this.leagueId,
    this.teamId,
    this.matchKey,
    this.userId,
    this.teamName,
    this.isFull,
    this.entryFees,
    this.totalTeam,
    this.remainingTeam,
    this.totalWiner,
    this.totalWiningAmount,
    this.winningAmount,
    this.rank,
    this.pointsStatus,
    this.winningStatus,
    this.createdTime,
    this.isResult = '0',
    this.points,
  });

  LeagueData.fromJson(Map<String, dynamic> json) {
    leagueId = json['league_id'] ?? '';
    teamId = json['team_id'] ?? '';
    matchKey = json['match_key'] ?? '';
    userId = json['user_id'] ?? '';
    teamName = json['team_name'] ?? '';
    isFull = json['is_full'] ?? '';
    entryFees = json['entry_fees'] ?? '';
    totalTeam = json['total_team'] ?? '';
    remainingTeam = json['remaining_team'] ?? '';
    totalWiner = json['total_winer'] ?? '';
    totalWiningAmount = json['total_wining_amount'] ?? '';
    winningAmount = json['winning_amount'] ?? '';
    isResult = json['is_result'] ?? '0';
    rank = json['rank'] ?? 0;
    var txt = json['created_time'] ?? '';
    if (txt != '') {
      try {
        createdTime = DateFormat('yyyy-MM-dd HH:mm:ss')
            .parse(txt.trim())
            .millisecondsSinceEpoch;
      } catch (e) {
        createdTime = 0;
      }
    } else {
      createdTime = 0;
    }
    pointsStatus = json['points_status'] ?? '';
    winningStatus = json['winning_status'] ?? '';
    points = double.tryParse('${json['points']}');
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['league_id'] = this.leagueId;
    data['team_id'] = this.teamId;
    data['match_key'] = this.matchKey;
    data['user_id'] = this.userId;
    data['team_name'] = this.teamName;
    data['winning_amount'] = this.winningAmount;
    data['is_full'] = this.isFull;
    data['entry_fees'] = this.entryFees;
    data['total_team'] = this.totalTeam;
    data['remaining_team'] = this.remainingTeam;
    data['total_winer'] = this.totalWiner;
    data['total_wining_amount'] = this.totalWiningAmount;
    data['rank'] = this.rank;
    data['points'] = this.points;
    data['createdTime'] = this.createdTime;
    data['points_status'] = this.pointsStatus;
    data['winning_status'] = this.winningStatus;
    return data;
  }
}
