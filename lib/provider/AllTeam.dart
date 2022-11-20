// ignore_for_file: camel_case_types, file_names, avoid_print, prefer_interpolation_to_compose_strings

import 'package:flutter/cupertino.dart';
import 'package:projet1/Data/Connection.dart';
import 'package:projet1/Data/getClassement.dart';
import 'package:projet1/Data/getMatchs.dart';
import 'package:projet1/Data/getTeam.dart';
import 'package:projet1/Model/Matchs.dart';
import 'package:projet1/Model/Standings.dart';
import 'package:projet1/Model/Team.dart';
import 'package:projet1/fonction/function.dart';

class Team_provider with ChangeNotifier {
  List<Teams> teamList = [];
  Standings classement = Standings();
  Matchs matchs = Matchs("status", []);
  Team_provider() {
    getDataTeam();
  }
  getDataTeam() async {
    await Connection.connected();
    notifyListeners();
    matchs = await getMatchs();
    notifyListeners();
    classement = await getClassment();
    notifyListeners();
    teamList = await getTeams();
    notifyListeners();

    setGoal();
    notifyListeners();
  }

  setGoal() {
    for (var element in teamList) {
      List<Match> mtch = matchs.data
          .where((ele) =>
              (ele.awayTeamId == element.TeamsId ||
                  ele.homeTeamId == element.TeamsId) &&
              (ele.finished == "TRUE" || isStareMatch(ele)))
          .toList();
      int gf = 0, ga = 0;
      for (var match in mtch) {
        if (match.homeTeamId == element.TeamsId) {
          gf += match.homeScore;
          ga += match.awayScore;
        } else if (match.awayTeamId == element.TeamsId) {
          gf += match.awayScore;
          ga += match.homeScore;
        }
      }
      element.matchs = mtch.length;
      element.GF = gf;
      element.GA = ga;
    }
  }
}
