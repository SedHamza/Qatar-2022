// To parse this JSON data, do
//
//     final standings = standingsFromJson(jsonString);

// ignore_for_file: file_names

import 'dart:convert';

Standings standingsFromJson(String str) => Standings.fromJson(json.decode(str));

String standingsToJson(Standings data) => json.encode(data.toJson());

class Standings {
  Standings({
    this.status,
    this.data,
  });

  String? status;
  List<Groupe>? data;

  factory Standings.fromJson(Map<String, dynamic> json) => Standings(
        status: json["status"],
        data: List<Groupe>.from(json["data"].map((x) => Groupe.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Groupe {
  Groupe(
    this.group,
    this.teams,
  );

  String group;
  List<Team> teams;

  factory Groupe.fromJson(Map<String, dynamic> json) => Groupe(
        json["group"],
        List<Team>.from(json["teams"].map((x) => Team.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "group": group,
        "teams": List<dynamic>.from(teams.map((x) => x.toJson())),
      };
}

class Team {
  Team(
    this.teamId,
    this.mp,
    this.w,
    this.l,
    this.pts,
    this.gf,
    this.ga,
    this.gd,
    this.nameFa,
    this.nameEn,
    this.flag,
  );

  String teamId;
  String mp;
  String w;
  String l;
  String pts;
  String gf;
  String ga;
  String gd;
  String nameFa;
  String nameEn;
  String flag;

  factory Team.fromJson(Map<String, dynamic> json) => Team(
        json["team_id"],
        json["mp"],
        json["w"],
        json["l"],
        json["pts"],
        json["gf"],
        json["ga"],
        json["gd"],
        json["name_fa"],
        json["name_en"],
        json["flag"],
      );

  Map<String, dynamic> toJson() => {
        "team_id": teamId,
        "mp": mp,
        "w": w,
        "l": l,
        "pts": pts,
        "gf": gf,
        "ga": ga,
        "gd": gd,
        "name_fa": nameFa,
        "name_en": nameEn,
        "flag": flag,
      };
}
