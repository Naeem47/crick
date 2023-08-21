import 'package:intl/intl.dart';

class ContestsLeagueResponseData {
  List<String>? teamlist;
  int? totalcontest;
  List<ContestsLeagueCategoryListResponseData>? contestsCategoryLeagueListData;

  ContestsLeagueResponseData(
      {this.teamlist,
      this.totalcontest = 0,
      this.contestsCategoryLeagueListData});
}

class ContestsLeagueCategoryListResponseData {
  String? categoryName;
  String? categoryDescription;
  List<ContestsLeagueListData>? contestsCategoryLeagueListData;

  ContestsLeagueCategoryListResponseData(
      {this.categoryName,
      this.categoryDescription,
      this.contestsCategoryLeagueListData});

  ContestsLeagueCategoryListResponseData.fromJson(Map<String, dynamic> json) {
    if (json['contestsCategoryLeagueListData'] != null) {
      contestsCategoryLeagueListData = <ContestsLeagueListData>[];
      json['contestsCategoryLeagueListData'].forEach((v) {
        contestsCategoryLeagueListData!
            .add(new ContestsLeagueListData.fromJson(v));
      });
    }
    categoryName = json['categoryName'];
    categoryDescription = json['categoryDescription'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.contestsCategoryLeagueListData != null) {
      data['contestsCategoryLeagueListData'] =
          this.contestsCategoryLeagueListData!.map((v) => v.toJson()).toList();
    }
    data['categoryName'] = this.categoryName;
    data['categoryDescription'] = this.categoryDescription;

    return data;
  }
}

class ModifiedContestsLeagueListData {
  ContestsLeagueListData? contestsHedder;
  List<ContestsLeagueListData>? contestsLeagueListData =
      <ContestsLeagueListData>[];

  ModifiedContestsLeagueListData(
      {this.contestsHedder, this.contestsLeagueListData});
}

class ContestsLeagueListData {
  String? leagueId;
  String? leagueKey;
  String? leagueName;
  String? entryFees;
  String? totalTeam;
  String? remainingTeam;
  String? totalWiner;
  String? matchKey;
  String? mainLeagueId;
  int? createdTime;
  String? updatedTime;
  String? isDelete;
  String? isActive;
  String? isFull;
  String? isRefund;
  String? isResult;
  String? teamPlayer;
  String? categoryId;
  String? totalWiningAmount;
  List<String>? leagueMember;
  List<LeagueWiner>? leagueWiner;

  ContestsLeagueListData(
      {this.leagueId,
      this.leagueKey,
      this.leagueName,
      this.entryFees,
      this.totalTeam,
      this.remainingTeam,
      this.totalWiner,
      this.matchKey,
      this.mainLeagueId,
      this.createdTime = 0,
      this.updatedTime,
      this.isDelete,
      this.isActive,
      this.isFull,
      this.isRefund,
      this.isResult,
      this.teamPlayer,
      this.categoryId,
      this.leagueMember,
      this.totalWiningAmount,
      this.leagueWiner});

  ContestsLeagueListData.fromJson(Map<String, dynamic> json) {
    leagueId = json['league_id'] ?? '';
    leagueKey = json['league_key'] ?? '';
    leagueName = json['league_name'] ?? '';
    entryFees = json['entry_fees'] ?? '';
    totalTeam = json['total_team'] ?? '';
    remainingTeam = json['remaining_team'] ?? '0';
    totalWiner = json['total_winer'] ?? '';
    matchKey = json['match_key'] ?? '';
    mainLeagueId = json['main_league_id'] ?? '';
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
    updatedTime = json['updated_time'] ?? '';
    isDelete = json['is_delete'] ?? '';
    isActive = json['is_active'] ?? '';
    isFull = json['is_full'] ?? '';
    isRefund = json['is_refund'] ?? '';
    isResult = json['is_result'] ?? '';
    teamPlayer = json['team_player'] ?? '';
    categoryId = json['CategoryId'] ?? '';
    var data = json['league_member'] ?? '';
    if (data != '') {
      leagueMember = data.split(',');
    } else {
      leagueMember = [];
    }

    totalWiningAmount = json['total_wining_amount'];
    if (json['league_winer'] != null) {
      leagueWiner = <LeagueWiner>[];
      json['league_winer'].forEach((v) {
        leagueWiner!.add(new LeagueWiner.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['league_id'] = this.leagueId;
    data['league_key'] = this.leagueKey;
    data['league_name'] = this.leagueName;
    data['entry_fees'] = this.entryFees;
    data['total_team'] = this.totalTeam;
    data['remaining_team'] = this.remainingTeam;
    data['total_winer'] = this.totalWiner;
    data['match_key'] = this.matchKey;
    data['main_league_id'] = this.mainLeagueId;
    data['created_time'] = this.createdTime;
    data['updated_time'] = this.updatedTime;
    data['is_delete'] = this.isDelete;
    data['is_active'] = this.isActive;
    data['is_full'] = this.isFull;
    data['is_refund'] = this.isRefund;
    data['is_result'] = this.isResult;
    data['team_player'] = this.teamPlayer;
    data['CategoryId'] = this.categoryId;
    data['total_wining_amount'] = this.totalWiningAmount;
    if (this.leagueWiner != null) {
      data['league_winer'] = this.leagueWiner!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LeagueWiner {
  String? leagueWinerId;
  String? leagueId;
  String? postion;
  String? price;

  LeagueWiner({this.leagueWinerId, this.leagueId, this.postion, this.price});

  LeagueWiner.fromJson(Map<String, dynamic> json) {
    leagueWinerId = json['league_winer_id'];
    leagueId = json['league_id'];
    postion = json['postion'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['league_winer_id'] = this.leagueWinerId;
    data['league_id'] = this.leagueId;
    data['postion'] = this.postion;
    data['price'] = this.price;
    return data;
  }
}
