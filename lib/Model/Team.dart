// To parse this JSON data, do
//
//     final TeamsRQ = TeamsRQFromJson(jsonString);

// ignore_for_file: non_constant_identifier_names, file_names

import 'dart:convert';

TeamsRQ TeamsRQFromJson(String str) => TeamsRQ.fromJson(json.decode(str));

String TeamsRQToJson(TeamsRQ data) => json.encode(data.toJson());

class TeamsRQ {
  TeamsRQ(
    this.status,
    this.data,
  );

  String status;
  List<Teams> data;

  factory TeamsRQ.fromJson(Map<String, dynamic> json) {
    return TeamsRQ(
      json["status"],
      List<Teams>.from(json["data"].map((x) => Teams.fromJson(x))),
    );
  }
  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Teams {
  Teams(
    this.id,
    this.nameEn,
    this.nameFa,
    this.flag,
    this.fifaCode,
    this.iso2,
    this.groups,
    this.TeamsId,
  );

  String id;
  String nameEn;
  String nameFa;
  String flag;
  String fifaCode;
  String iso2;
  String groups;
  String TeamsId;
  int GF = 0;
  int GA = 0;

  factory Teams.fromJson(Map<String, dynamic> json) {
    return Teams(
      json["_id"],
      json["name_en"],
      json["name_fa"],
      json["flag"],
      json["fifa_code"],
      json["iso2"],
      json["groups"],
      json["id"],
    );
  }

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name_en": nameEn,
        "name_fa": nameFa,
        "flag": flag,
        "fifa_code": fifaCode,
        "iso2": iso2,
        "groups": groups,
        "id": TeamsId,
      };
}
