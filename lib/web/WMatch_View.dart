// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable, file_names, must_call_super, duplicate_ignore, avoid_unnecessary_containers, sized_box_for_whitespace

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projet1/Model/Matchs.dart';
import 'package:projet1/compopente/Tawa9o3ParMatch.dart';
import 'package:projet1/compopente/groupeItem.dart';
import 'package:projet1/compopente/home_matchs.dart';
import 'package:projet1/compopente/matchItem.dart';
import 'package:projet1/constante/MyColors.dart';
import 'package:projet1/compopente/Match_prediction.dart';
import 'package:projet1/fonction/function.dart';
import 'package:projet1/provider/AllTeam.dart';
import 'package:provider/provider.dart';

class WDetaillMatch extends StatefulWidget {
  int id;
  WDetaillMatch(this.id);

  @override
  State<WDetaillMatch> createState() => _WDetaillMatchState();
}

class _WDetaillMatchState extends State<WDetaillMatch> {
  List<Match> matchs = [];
  late Team_provider provider;
  String T = "ABCDEFGH";

  @override
  void initState() {
    provider = Provider.of<Team_provider>(context, listen: false);

    matchs.add(
        provider.matchs.data.where((element) => element.id == widget.id).first);
  }

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<Team_provider>(context);
    Match match = matchs.first;
    return Scaffold(
      appBar: appBar(),
      body: Row(
        children: [
          Expanded(
              flex: 3,
              child: Container(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4.0),
                      child: HomeMatch(int.parse(match.homeTeamId), match.id),
                    ),
                  ],
                ),
              )),
          VerticalDivider(
            indent: 10,
            endIndent: 10,
            width: 0.0,
            color: MyColors.firsteColor,
          ),
          Expanded(
              flex: 4,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      child: match.type == "group"
                          ? GroupeItem(T.indexOf(match.group))
                          : Container(),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: MatchItem(widget.id, false),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Match_prediction(
                          match, FirebaseAuth.instance.currentUser?.email),
                    ),
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          child: Container(
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    "Les Autres Prédiction ",
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                        color: MyColors.firsteColor),
                                  ),
                                ),
                                Divider(
                                  color: MyColors.firsteColor,
                                  height: 5,
                                  thickness: 1,
                                  indent: 8,
                                  endIndent: 15,
                                ),
                                Tawaqo3ParMatch(GetMatchById(widget.id))
                              ],
                            ),
                          ),
                        )),
                  ],
                ),
              )),
          VerticalDivider(
            indent: 10,
            endIndent: 10,
            width: 0.0,
            color: MyColors.firsteColor,
          ),
          Expanded(
              flex: 3,
              child: Container(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4.0),
                      child: HomeMatch(int.parse(match.awayTeamId), match.id),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  AppBar? appBar() {
    return AppBar(
      title: Text(
        "Match",
        style: TextStyle(
            color: MyColors.secondColor,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic),
      ),
      elevation: 0.0,
      centerTitle: true,
      backgroundColor: Colors.transparent,
      flexibleSpace: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.elliptical(10, 20),
                bottomRight: Radius.elliptical(10, 20)),
            color: MyColors.firsteColor),
      ),
    );
  }
}
