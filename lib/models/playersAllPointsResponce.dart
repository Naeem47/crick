class PlayersAllPointsResponce {
  int? success;
  String? message;
  List<Playing11>? playerStats;

  PlayersAllPointsResponce({
    this.success,
    this.message,
    this.playerStats,
  });

  factory PlayersAllPointsResponce.fromJson(Map<String, dynamic> json) =>
      new PlayersAllPointsResponce(
        success: json["success"],
        message: json["message"],
        playerStats: new List<Playing11>.from(
            json["player_stats"].map((x) => Playing11.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "player_stats":
            new List<dynamic>.from(playerStats!.map((x) => x.toJson())),
      };
}

class Playing11 {
  String? id;
  String? playerKey;
  String? playerName;
  double? points;
  String? role;
  String? rating;
  String? starting11;
  String? run;
  String? four;
  String? six;
  String? sr;
  String? fifty;
  String? duck;
  String? wkts;
  String? maidenover;
  String? er;
  String? playerStatCatch;
  String? runoutstumping;
  String? matchKey;
  String? competitionId;
  String? lastUpdated;
  String? updatedTime;

  Playing11({
    this.id,
    this.playerKey,
    this.playerName,
    this.points = 0.0,
    this.role,
    this.rating,
    this.starting11,
    this.run,
    this.four,
    this.six,
    this.sr,
    this.fifty,
    this.duck,
    this.wkts,
    this.maidenover,
    this.er,
    this.playerStatCatch,
    this.runoutstumping,
    this.matchKey,
    this.competitionId,
    this.lastUpdated,
    this.updatedTime,
  });

  factory Playing11.fromJson(Map<String, dynamic> json) => new Playing11(
        id: json["id"],
        playerKey: json["player_key"] ?? '',
        playerName: json["player_name"] ?? '',
        points: double.tryParse('${json["points"] ?? '0.0'}'),
        role: json["role"] ?? '',
        rating: json["rating"] ?? '',
        starting11: json["starting11"] ?? '',
        run: json["run"] ?? '',
        four: json["four"] ?? '',
        six: json["six"] ?? '',
        sr: json["sr"] ?? '',
        fifty: json["fifty"] ?? '',
        duck: json["duck"] ?? '',
        wkts: json["wkts"] ?? '',
        maidenover: json["maidenover"] ?? '',
        er: json["er"] ?? '',
        playerStatCatch: json["catch"] ?? '',
        runoutstumping: json["runoutstumping"] ?? '',
        matchKey: json["match_key"] ?? '',
        competitionId: json["competition_id"] ?? '',
        lastUpdated: json["last_updated"] ?? '',
        updatedTime: json["updated_time"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "player_key": playerKey,
        "player_name": playerName,
        "points": points,
        "role": role,
        "rating": rating,
        "starting11": starting11,
        "run": run,
        "four": four,
        "six": six,
        "sr": sr,
        "fifty": fifty,
        "duck": duck,
        "wkts": wkts,
        "maidenover": maidenover,
        "er": er,
        "catch": playerStatCatch,
        "runoutstumping": runoutstumping,
        "match_key": matchKey,
        "competition_id": competitionId,
        "last_updated": lastUpdated,
        "updated_time": updatedTime,
      };
}
