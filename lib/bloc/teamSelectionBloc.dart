// ignore_for_file: override_on_non_overriding_member

import 'dart:core';

import 'package:bloc/bloc.dart';
import 'package:tempalteflutter/models/squadsResponseData.dart';
import 'package:tempalteflutter/modules/createTeam/createTeamScreen.dart';

class TeamSelectionBloc extends Bloc<TeamSelectionBlocEvent, TeamSelectionBlocState> {
  var allPlayerList = <Players>[];
  double allCredits = 100.0;
  bool assending = true;
  String competitionId = '';

  TeamSelectionBloc(TeamSelectionBlocState initialState) : super(initialState);

  void cleanList() {
    competitionId = '';
    allPlayerList.clear();
    add(TeamSelectionBlocEvent.setUpdate);
  }

  void onListChanges(List<Players> allPlayerListData) {
    allPlayerList = allPlayerListData;
    allCredits = 100.0;
    assending = false;
    allPlayerList = setAssendingList(assending);
    add(TeamSelectionBlocEvent.setUpdate);
  }

  void setAssendingAndDesandingList() {
    assending = !assending;
    allPlayerList = setAssendingList(assending);
    add(TeamSelectionBlocEvent.setUpdate);
  }

  List<Players> setAssendingList(bool isAssanding) {
    var wkList = <Players>[];
    var batList = <Players>[];
    var arList = <Players>[];
    var bowlList = <Players>[];
    var allPlayesList = <Players>[];
    allPlayerList.forEach((player) {
      if (player.playingRole!.toLowerCase() == getTypeText(TabTextType.wk).toLowerCase()) {
        wkList.add(player);
      }
      if (player.playingRole!.toLowerCase() == getTypeText(TabTextType.bat).toLowerCase()) {
        batList.add(player);
      }
      if (player.playingRole!.toLowerCase() == getTypeText(TabTextType.ar).toLowerCase()) {
        arList.add(player);
      }
      if (player.playingRole!.toLowerCase() == getTypeText(TabTextType.bowl).toLowerCase()) {
        bowlList.add(player);
      }
    });
    if (isAssanding) {
      wkList.sort((a, b) => a.fantasyPlayerRating!.compareTo(b.fantasyPlayerRating!));
      batList.sort((a, b) => a.fantasyPlayerRating!.compareTo(b.fantasyPlayerRating!));
      arList.sort((a, b) => a.fantasyPlayerRating!.compareTo(b.fantasyPlayerRating!));
      bowlList.sort((a, b) => a.fantasyPlayerRating!.compareTo(b.fantasyPlayerRating!));
    } else {
      wkList.sort((a, b) => b.fantasyPlayerRating!.compareTo(a.fantasyPlayerRating!));
      batList.sort((a, b) => b.fantasyPlayerRating!.compareTo(a.fantasyPlayerRating!));
      arList.sort((a, b) => b.fantasyPlayerRating!.compareTo(a.fantasyPlayerRating!));
      bowlList.sort((a, b) => b.fantasyPlayerRating!.compareTo(a.fantasyPlayerRating!));
    }
    allPlayesList.addAll(wkList);
    allPlayesList.addAll(batList);
    allPlayesList.addAll(arList);
    allPlayesList.addAll(bowlList);
    return allPlayesList;
  }

  List<Players> getTypeList(TabTextType tabTextType) {
    var playerList = <Players>[];
    allPlayerList.forEach((player) {
      if (player.playingRole!.toLowerCase() == getTypeText(tabTextType).toLowerCase()) {
        playerList.add(player);
      }
    });
    return playerList;
  }

  void setPlaySelect(int pid) {
    allPlayerList.forEach((player) {
      if (player.pid == pid) {
        if (player.isSelcted! && (getMax7PlayesCount(player) >= 7)) {
          return;
        } else {
          player.isSelcted = !player.isSelcted!;
          teamTapBloc.setType(AnimationType.isRegular);
        }
      }
    });
    add(TeamSelectionBlocEvent.setUpdate);
  }

  int getMax7PlayesCount(Players player) {
    var totalCount = 0;
    allPlayerList.forEach((playerData) {
      if (player.teamName!.toLowerCase() == playerData.teamName!.toLowerCase() && playerData.isSelcted!) {
        totalCount += 1;
      }
    });
    return totalCount;
  }

  String getTypeText(TabTextType tabTextType) {
    return tabTextType == TabTextType.wk
        ? "WK"
        : tabTextType == TabTextType.bat
            ? "BAT"
            : tabTextType == TabTextType.ar
                ? "All"
                : tabTextType == TabTextType.bowl
                    ? "BOWL"
                    : '';
  }

  TabTextType? getTypeTextEnum(String tabText) {
    if (tabText.toLowerCase() == "WK".toLowerCase()) {
      return TabTextType.wk;
    } else {
      if (tabText.toLowerCase() == "BAT".toLowerCase()) {
        return TabTextType.bat;
      } else {
        if (tabText.toLowerCase() == "ALL".toLowerCase()) {
          return TabTextType.ar;
        } else {
          if (tabText.toLowerCase() == "BOWL".toLowerCase()) {
            return TabTextType.bowl;
          } else {
            return null;
          }
        }
      }
    }
  }

  String getFullNameType(String tabText) {
    return tabText.toLowerCase() == "WK".toLowerCase()
        ? 'Wicket-Keeper'
        : tabText.toLowerCase() == "BAT".toLowerCase()
            ? 'Batsmen'
            : tabText.toLowerCase() == "All".toLowerCase()
                ? 'All-Rounders'
                : tabText.toLowerCase() == "BOWL".toLowerCase()
                    ? 'Bowlers'
                    : '';
  }

  List<int> getMinMaxSelectionCount(TabTextType tabTextType) {
    var minMaxSelectionCountList = <int>[];
    if (tabTextType == TabTextType.wk) {
      minMaxSelectionCountList = [1, 1];
    } else if (tabTextType == TabTextType.bat) {
      minMaxSelectionCountList = [3, 5];
    } else if (tabTextType == TabTextType.ar) {
      minMaxSelectionCountList = [1, 3];
    } else if (tabTextType == TabTextType.bowl) {
      minMaxSelectionCountList = [3, 5];
    } else {
      minMaxSelectionCountList = [0, 0];
    }
    return minMaxSelectionCountList;
  }

  double getTotalSelctedPlayerRating() {
    var totalpoint = 0.0;
    allPlayerList.forEach((player) {
      if (player.isSelcted == true) {
        totalpoint += player.fantasyPlayerRating!;
      }
    });
    return totalpoint;
  }

  void setCaptain(int pid) {
    allPlayerList.forEach((player) {
      player.isC = false;
    });
    allPlayerList.forEach((player) {
      if (pid == player.pid) {
        player.isVC = false;
        player.isC = true;
      }
    });
    add(TeamSelectionBlocEvent.setUpdate);
  }

  void setViceCaptain(int pid) {
    allPlayerList.forEach((player) {
      player.isVC = false;
    });
    allPlayerList.forEach((player) {
      if (pid == player.pid) {
        player.isC = false;
        player.isVC = true;
      }
    });
    add(TeamSelectionBlocEvent.setUpdate);
  }

  int getSelectedPlayerCount({TabTextType? wk, TabTextType? tabTextType}) {
    var totalpoint = 0;
    allPlayerList.forEach((player) {
      if (tabTextType == null) {
        if (player.isSelcted == true) {
          totalpoint += 1;
        }
      } else {
        if (player.isSelcted == true && (player.playingRole!.toLowerCase() == getTypeText(tabTextType).toLowerCase())) {
          totalpoint += 1;
        }
      }
    });
    return totalpoint;
  }

  void refreshCAndVC() {
    allPlayerList.forEach((player) {
      if (!player.isSelcted!) {
        player.isVC = false;
        player.isC = false;
      }
    });
  }

  int getSelectedTeamPlayerCount(String sortTeamName) {
    var totalpoint = 0;
    allPlayerList.forEach((player) {
      if (player.teamName!.toLowerCase() == sortTeamName.toLowerCase()) {
        if (player.isSelcted == true) {
          totalpoint += 1;
        }
      }
    });
    return totalpoint;
  }

  bool isDisabled(int pid) {
    Players playes = new Players();
    var selectedPlayes = 0;
    allPlayerList.forEach((player) {
      if (pid == player.pid) {
        playes = player;
      }
    });

    var allTypePlayerList = <Players>[];
    allPlayerList.forEach((player) {
      if (playes.playingRole!.toLowerCase() == player.playingRole!.toLowerCase()) {
        allTypePlayerList.add(player);
        if (player.isSelcted!) {
          selectedPlayes += 1;
        }
      }
    });
    if (getMinMaxSelectionCount(getTypeTextEnum(playes.playingRole!)!)[1] <= selectedPlayes) {
      return true;
    } else {
      return false;
    }
  }

  bool validSaveTeamRequirement() {
    bool isC = false;
    bool isVC = false;
    allPlayerList.forEach((player) {
      if (player.isC!) {
        isC = true;
      }
      if (player.isVC!) {
        isVC = true;
      }
    });
    if (isC && isVC) {
      return true;
    } else {
      return false;
    }
  }

  bool validMinRequirement() {
    var wkList = 0;
    var batList = 0;
    var arList = 0;
    var bowlList = 0;

    allPlayerList.forEach((player) {
      if (player.isSelcted!) {
        if (player.playingRole!.toLowerCase() == getTypeText(TabTextType.wk).toLowerCase()) {
          wkList += 1;
        }
        if (player.playingRole!.toLowerCase() == getTypeText(TabTextType.bat).toLowerCase()) {
          batList += 1;
        }
        if (player.playingRole!.toLowerCase() == getTypeText(TabTextType.ar).toLowerCase()) {
          arList += 1;
        }
        if (player.playingRole!.toLowerCase() == getTypeText(TabTextType.bowl).toLowerCase()) {
          bowlList += 1;
        }
      }
    });

    if ((getMinMaxSelectionCount(TabTextType.wk)[0] <= wkList) &&
        (getMinMaxSelectionCount(TabTextType.bat)[0] <= batList) &&
        (getMinMaxSelectionCount(TabTextType.ar)[0] <= arList) &&
        (getMinMaxSelectionCount(TabTextType.bowl)[0] <= bowlList)) {
      return true;
    } else {
      return false;
    }
  }

  List<TabTextType> validMinErrorRequirementList() {
    var typeList = <TabTextType>[];
    var wkList = 0;
    var batList = 0;
    var arList = 0;
    var bowlList = 0;

    allPlayerList.forEach((player) {
      if (player.isSelcted!) {
        if (player.playingRole!.toLowerCase() == getTypeText(TabTextType.wk).toLowerCase()) {
          wkList += 1;
        }
        if (player.playingRole!.toLowerCase() == getTypeText(TabTextType.bat).toLowerCase()) {
          batList += 1;
        }
        if (player.playingRole!.toLowerCase() == getTypeText(TabTextType.ar).toLowerCase()) {
          arList += 1;
        }
        if (player.playingRole!.toLowerCase() == getTypeText(TabTextType.bowl).toLowerCase()) {
          bowlList += 1;
        }
      }
    });
    if (11 - getSelectedPlayerCount() != 0) {
      var minWk = 0;
      var minAr = 0;
      var minBat = 0;
      var minbowl = 0;
      if (getMinMaxSelectionCount(TabTextType.wk)[0] > wkList) {
        minWk = getMinMaxSelectionCount(TabTextType.wk)[0] - wkList;
      }
      if (getMinMaxSelectionCount(TabTextType.ar)[0] > arList) {
        minAr = getMinMaxSelectionCount(TabTextType.ar)[0] - arList;
      }
      if (getMinMaxSelectionCount(TabTextType.bat)[0] > batList) {
        minBat = getMinMaxSelectionCount(TabTextType.bat)[0] - batList;
      }
      if (getMinMaxSelectionCount(TabTextType.bowl)[0] > bowlList) {
        minbowl = getMinMaxSelectionCount(TabTextType.bowl)[0] - bowlList;
      }
      var totalMin = minWk + minAr + minBat + minbowl;
      print(totalMin);
      print((11 - getSelectedPlayerCount()));
      if (totalMin > (11 - (getSelectedPlayerCount() + 1))) {
        if (minWk != 0) {
          typeList.add(TabTextType.wk);
        }
        if (minBat != 0) {
          typeList.add(TabTextType.bat);
        }
        if (minAr != 0) {
          typeList.add(TabTextType.ar);
        }
        if (minbowl != 0) {
          typeList.add(TabTextType.bowl);
        }
      } else {
        if (getMinMaxSelectionCount(TabTextType.wk)[0] > wkList && getMinMaxSelectionCount(TabTextType.wk)[0] == 11 - getSelectedPlayerCount()) {
          typeList.add(TabTextType.wk);
        }
        if (getMinMaxSelectionCount(TabTextType.ar)[0] > arList && getMinMaxSelectionCount(TabTextType.ar)[0] == 11 - getSelectedPlayerCount()) {
          typeList.add(TabTextType.ar);
        }
        if (getMinMaxSelectionCount(TabTextType.bat)[0] > batList && getMinMaxSelectionCount(TabTextType.bat)[0] == 11 - getSelectedPlayerCount()) {
          typeList.add(TabTextType.bat);
        }
        if (getMinMaxSelectionCount(TabTextType.bowl)[0] > bowlList &&
            getMinMaxSelectionCount(TabTextType.bowl)[0] == 11 - getSelectedPlayerCount()) {
          typeList.add(TabTextType.bowl);
        }
      }
    }
    return typeList;
  }

  TabTextType? validMinErrorRequirement() {
    var wkList = 0;
    var batList = 0;
    var arList = 0;
    var bowlList = 0;

    allPlayerList.forEach((player) {
      if (player.isSelcted!) {
        if (player.playingRole!.toLowerCase() == getTypeText(TabTextType.wk).toLowerCase()) {
          wkList += 1;
        }
        if (player.playingRole!.toLowerCase() == getTypeText(TabTextType.bat).toLowerCase()) {
          batList += 1;
        }
        if (player.playingRole!.toLowerCase() == getTypeText(TabTextType.ar).toLowerCase()) {
          arList += 1;
        }
        if (player.playingRole!.toLowerCase() == getTypeText(TabTextType.bowl).toLowerCase()) {
          bowlList += 1;
        }
      }
    });
    if (11 - getSelectedPlayerCount() != 0) {
      var minWk = 0;
      var minAr = 0;
      var minBat = 0;
      var minbowl = 0;
      if (getMinMaxSelectionCount(TabTextType.wk)[0] > wkList) {
        minWk = getMinMaxSelectionCount(TabTextType.wk)[0] - wkList;
      }
      if (getMinMaxSelectionCount(TabTextType.ar)[0] > arList) {
        minAr = getMinMaxSelectionCount(TabTextType.ar)[0] - arList;
      }
      if (getMinMaxSelectionCount(TabTextType.bat)[0] > batList) {
        minBat = getMinMaxSelectionCount(TabTextType.bat)[0] - batList;
      }
      if (getMinMaxSelectionCount(TabTextType.bowl)[0] > bowlList) {
        minbowl = getMinMaxSelectionCount(TabTextType.bowl)[0] - bowlList;
      }
      var totalMin = minWk + minAr + minBat + minbowl;
      print(totalMin);
      print((11 - getSelectedPlayerCount()));
      if (totalMin > (11 - (getSelectedPlayerCount() + 1))) {
        if (minWk != 0) {
          return TabTextType.wk;
        } else if (minBat != 0) {
          return TabTextType.bat;
        } else if (minAr != 0) {
          return TabTextType.ar;
        } else if (minbowl != 0) {
          return TabTextType.bowl;
        } else {
          return null;
        }
      } else {
        if (getMinMaxSelectionCount(TabTextType.wk)[0] > wkList && getMinMaxSelectionCount(TabTextType.wk)[0] == 11 - getSelectedPlayerCount()) {
          return TabTextType.wk;
        } else if (getMinMaxSelectionCount(TabTextType.ar)[0] > arList &&
            getMinMaxSelectionCount(TabTextType.ar)[0] == 11 - getSelectedPlayerCount()) {
          return TabTextType.ar;
        } else if (getMinMaxSelectionCount(TabTextType.bat)[0] > batList &&
            getMinMaxSelectionCount(TabTextType.bat)[0] == 11 - getSelectedPlayerCount()) {
          return TabTextType.bat;
        } else if (getMinMaxSelectionCount(TabTextType.bowl)[0] > bowlList &&
            getMinMaxSelectionCount(TabTextType.bowl)[0] == 11 - getSelectedPlayerCount()) {
          return TabTextType.bowl;
        } else {
          return null;
        }
      }
    } else {
      return null;
    }
  }

  TeamSelectionBlocState get initialState => TeamSelectionBlocState.initial();

  @override
  Stream<TeamSelectionBlocState> mapEventToState(TeamSelectionBlocEvent event) async* {
    if (event == TeamSelectionBlocEvent.setUpdate) {
      yield state.copyWith(
        allPlayerList: allPlayerList,
        assending: assending,
      );
    }
  }
}

enum TeamSelectionBlocEvent { setUpdate }

class TeamSelectionBlocState {
  List<Players>? allPlayerList = <Players>[];
  bool? assending = false;
  TeamSelectionBlocState({
    this.allPlayerList,
    this.assending,
  });

  factory TeamSelectionBlocState.initial() {
    return TeamSelectionBlocState(
      allPlayerList: <Players>[],
      assending: false,
    );
  }

  TeamSelectionBlocState copyWith({
    List<Players>? allPlayerList,
    bool? assending,
  }) {
    return TeamSelectionBlocState(
      allPlayerList: allPlayerList ?? this.allPlayerList,
      assending: assending ?? this.assending,
    );
  }
}
