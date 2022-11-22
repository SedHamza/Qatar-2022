// ignore_for_file: non_constant_identifier_names, curly_braces_in_flow_control_structures, prefer_interpolation_to_compose_strings, avoid_print, prefer_typing_uninitialized_variables, unused_import, empty_catches

import 'package:projet1/Model/Matchs.dart';
import 'package:projet1/Model/Team.dart';
import 'package:projet1/Model/tawaqoa.dart';
import 'package:projet1/main.dart';
import 'package:projet1/provider/AllTeam.dart';
import 'package:provider/provider.dart';

bool isStareMatch(Match match) {
  DateTime now = DateTime.now();
  //now = DateTime.parse("2022-11-23 15:00:00");
  //now.day = 11;

  if (match.finished == "TRUE") {
    return true;
  }
  if (match.localDate.day == now.day) {
    if (match.localDate.hour <= now.hour) {
      return true;
    } else if (match.localDate.hour == now.hour) {
      if (match.localDate.minute < now.minute) {
        return true;
      }
    }
  }
  return false;
}

isStareMatchById(int? id) {
  try {
    return isStareMatch(
        MyApp.provider.matchs.data.firstWhere((element) => element.id == id));
  } catch (e) {
    return false;
  }
}

List<DateTime> existeDate(List<Match> matchs) {
  List<DateTime> dates = [];
  if (matchs.isNotEmpty) {
    dates.add(matchs[2].localDate);
  } else
    return [];
  for (var i = 3; i < matchs.length; i++) {
    if ((matchs[i].localDate.day != dates[dates.length - 1].day) ||
        (matchs[i].localDate.month != dates[dates.length - 1].month)) {
      dates.add(matchs[i].localDate);
    }
  }
  return dates;
}

List<Teams> BestAttack() {
  List<Teams> lst = [];
  lst.sort((a, b) => a.GA.compareTo(b.GA));
  return lst;
}

int comptePts(Tawa9oa tawa9oa) {

  int pts = 0;
  try {
    Match match = MyApp.provider.matchs.data
        .where((element) => element.id == tawa9oa.id)
        .first;
    if (!isStareMatch(match)) {
      return 0;
    }
    if (tawa9oa.awayEx != -1) {
      //exacte result
      if (tawa9oa.awayEx == match.awayScore &&
          tawa9oa.homeEx == match.homeScore) {
        return 25;
      }
      return 0;
    }
    if (tawa9oa.maxBut! >= (match.awayScore + match.homeScore) &&
        tawa9oa.maxBut != -1) {
      pts += (7 - tawa9oa.maxBut!) *2;
    }
    if (tawa9oa.minBut! <= (match.awayScore + match.homeScore) &&
        tawa9oa.minBut != -1) {
      pts += (tawa9oa.minBut!) *2;
    }
    if (tawa9oa.qagne != -1) {
      if ((tawa9oa.qagne == 1) && (match.homeScore > match.awayScore)) {
        pts += 5;
      } else if ((tawa9oa.qagne == 2) && (match.homeScore < match.awayScore)) {
        pts += 5;
      } else if ((tawa9oa.qagne == 0) && (match.homeScore == match.awayScore)) {
        pts += 5;
      }
    }
  } catch (e) {}

  return pts;
}

Match GetMatchById(int id) {
  return MyApp.provider.matchs.data.firstWhere((element) => element.id == id);
}
