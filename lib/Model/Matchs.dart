// ignore_for_file: prefer_interpolation_to_compose_strings, file_names, unused_import, avoid_print, unused_local_variable

import 'dart:convert';

import 'package:flutter/material.dart';

Matchs matchsFromJson(String str) => Matchs.fromJson(json.decode(str));

String matchsToJson(Matchs data) => json.encode(data.toJson());

class Matchs {
  Matchs(
    this.status,
    this.data,
  );
  String status;
  List<Match> data;

  factory Matchs.fromJson(Map<String, dynamic> json) => Matchs(
        json["status"],
        List<Match>.from(json["data"].map((x) => Match.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Match {
  Match(
    this.id,
    this.type,
    this.group,
    this.homeTeamId,
    this.awayTeamId,
    this.homeScore,
    this.awayScore,
    this.homeScorers,
    this.awayScorers,
    this.persianDate,
    this.localDate,
    this.stadiumId,
    this.timeElapsed,
    this.finished,
    this.matchday,
    this.homeTeamFa,
    this.awayTeamFa,
    this.homeTeamEn,
    this.awayTeamEn,
    this.homeFlag,
    this.awayFlag,
  );

  int id;
  String type;
  String group;
  String homeTeamId;
  String awayTeamId;
  int homeScore;
  int awayScore;
  dynamic homeScorers;
  dynamic awayScorers;
  String persianDate;
  DateTime localDate;
  String stadiumId;
  String timeElapsed;
  String finished;
  int matchday;
  String homeTeamFa;
  String awayTeamFa;
  String homeTeamEn;
  String awayTeamEn;
  String homeFlag;
  String awayFlag;

  factory Match.fromJson(Map<String, dynamic> json) {
    String date = json["local_date"].toString().split(" ")[0];
    String time = json["local_date"].toString().split(" ")[1];
    int y = int.parse(date.split("/")[2]);
    int dy = int.parse(date.split("/")[1]);
    int mo = int.parse(date.split("/")[0]);
    int hr = int.parse(time.split(":")[0]) - 2;
    int min = int.parse(time.split(":")[1]);
    String d = "";
    String h = "";
    String mn = "";
    String datetime = y.toString() + "-";

    if (dy / 10 < 1) {
      d = "0" + dy.toString();
    } else {
      d = dy.toString();
    }
    if (hr / 10 < 1) {
      h = "0" + hr.toString();
    } else {
      h = hr.toString();
    }
    if (min / 10 < 1) {
      mn = "0" + min.toString();
    } else {
      mn = min.toString();
    }
    datetime = "$y-$mo-" + d + " " + h + ":" + mn + ":04Z";
    return Match(
      int.parse(json["id"]),
      json["type"],
      json["group"],
      json["home_team_id"],
      json["away_team_id"],
      json["home_score"],
      json["away_score"],
      json["home_scorers"],
      json["away_scorers"],
      json["persian_date"],
      DateTime.parse(datetime),
      json["stadium_id"],
      json["time_elapsed"],
      json["finished"],
      int.parse(json["matchday"]),
      json["home_team_fa"],
      json["away_team_fa"],
      json["home_team_en"],
      json["away_team_en"],
      json["home_flag"],
      json["away_flag"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "group": group,
        "home_team_id": homeTeamId,
        "away_team_id": awayTeamId,
        "home_score": homeScore,
        "away_score": awayScore,
        "home_scorers": homeScorers,
        "away_scorers": awayScorers,
        "persian_date": persianDate,
        "local_date": localDate,
        "stadium_id": stadiumId,
        "time_elapsed": timeElapsed,
        "finished": finished,
        "matchday": matchday,
        "home_team_fa": homeTeamFa,
        "away_team_fa": awayTeamFa,
        "home_team_en": homeTeamEn,
        "away_team_en": awayTeamEn,
        "home_flag": homeFlag,
        "away_flag": awayFlag,
      };
}
