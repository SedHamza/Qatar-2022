// ignore_for_file: camel_case_types, file_names, avoid_print

import 'package:flutter/cupertino.dart';
import 'package:projet1/Data/Connection.dart';
import 'package:projet1/Data/getClassement.dart';
import 'package:projet1/Data/getMatchs.dart';
import 'package:projet1/Data/getTeam.dart';
import 'package:projet1/Model/Matchs.dart';
import 'package:projet1/Model/Standings.dart';
import 'package:projet1/Model/Team.dart';

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
  }
}
