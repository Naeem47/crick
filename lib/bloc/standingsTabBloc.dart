// ignore_for_file: unnecessary_null_comparison, override_on_non_overriding_member

import 'package:bloc/bloc.dart';
import 'package:tempalteflutter/api/apiProvider.dart';
import 'package:tempalteflutter/models/scheduleResponseData.dart';
import 'package:tempalteflutter/models/shedualResults.dart';
import 'package:tempalteflutter/modules/home/standingScreen.dart';

class StandingsTabBloc extends Bloc<StandingsTabBlocEvent, StandingsTabBlocState> {
  var upcomingList = <ShedualResults>[];
  var liveList = <ShedualResults>[];
  var resultsList = <ShedualResults>[];
  var sheduallist = <ShedualData>[];
  bool isProgress = false;

  StandingsTabBloc(StandingsTabBlocState initialState) : super(initialState);

  void cleanList() {
    isProgress = true;
    sheduallist.clear();
    add(StandingsTabBlocEvent.setUpdate);
  }

  Future upcoming() async {
    add(StandingsTabBlocEvent.setUpdate);

    add(StandingsTabBlocEvent.setUpdate);
    getSchedule();
  }

  Future live() async {
    add(StandingsTabBlocEvent.setUpdate);

    add(StandingsTabBlocEvent.setUpdate);
    getSchedule();
  }

  Future results() async {
    add(StandingsTabBlocEvent.setUpdate);

    add(StandingsTabBlocEvent.setUpdate);
    getSchedule();
  }

  Future getSchedule() async {
    if (sheduallist.length <= 1) {
      var responseData = await ApiProvider().postScheduleList();
      if (responseData != null && responseData.shedualData != null) {
        sheduallist = responseData.shedualData!;
        sheduallist.insert(0, ShedualData());
      }
    }
    isProgress = false;
    add(StandingsTabBlocEvent.setUpdate);
  }

  List<ShedualResults> getData(TabType type) {
    if (type == TabType.Upcoming) {
      return upcomingList;
    } else if (type == TabType.Live) {
      return liveList;
    } else {
      return resultsList;
    }
  }

  List<ShedualData> getScheduleData() {
    return sheduallist;
  }

  StandingsTabBlocState get initialState => StandingsTabBlocState.initial();

  @override
  Stream<StandingsTabBlocState> mapEventToState(StandingsTabBlocEvent event) async* {
    if (event == StandingsTabBlocEvent.setUpdate) {
      yield state.copyWith(
        upcomingList: upcomingList,
        liveList: liveList,
        resultsList: resultsList,
        isProgress: isProgress,
      );
    }
  }
}

enum StandingsTabBlocEvent { setUpdate }

class StandingsTabBlocState {
  var upcomingList = <ShedualResults>[];
  var liveList = <ShedualResults>[];
  var resultsList = <ShedualResults>[];
  var sheduallist = <ShedualData>[];
  bool isProgress = false;

  StandingsTabBlocState({
    required this.upcomingList,
    required this.liveList,
    required this.resultsList,
    required this.isProgress,
    required this.sheduallist,
  });

  factory StandingsTabBlocState.initial() {
    var standingsTabBlocState = StandingsTabBlocState(
      upcomingList: <ShedualResults>[],
      liveList: <ShedualResults>[],
      resultsList: <ShedualResults>[],
      sheduallist: <ShedualData>[],
      isProgress: false,
    );
    return standingsTabBlocState;
  }

  StandingsTabBlocState copyWith({
    List<ShedualResults>? upcomingList,
    List<ShedualResults>? liveList,
    List<ShedualResults>? resultsList,
    List<ShedualData>? sheduallist,
    bool? isProgress,
  }) {
    return StandingsTabBlocState(
      upcomingList: upcomingList ?? this.upcomingList,
      liveList: liveList ?? this.liveList,
      resultsList: resultsList ?? this.resultsList,
      isProgress: isProgress ?? this.isProgress,
      sheduallist: sheduallist ?? this.sheduallist,
    );
  }
}
