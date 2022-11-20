// ignore_for_file: must_be_immutable, use_key_in_widget_constructors, prefer_const_constructors, prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:projet1/Model/Team.dart';
import 'package:projet1/compopente/matchItem.dart';
import 'package:projet1/constante/MyColors.dart';
import 'package:projet1/provider/AllTeam.dart';
import 'package:provider/provider.dart';
import 'package:projet1/Model/Matchs.dart';

class HomeMatch extends StatefulWidget {
  int id;
  int idmatch;
  HomeMatch(this.id, this.idmatch);

  @override
  State<HomeMatch> createState() => _HomeMatchState();
}

class _HomeMatchState extends State<HomeMatch> {
  @override
  Widget build(BuildContext context) {
    Team_provider provider = Provider.of<Team_provider>(context);
    Teams team = provider.teamList
        .where((element) => int.parse(element.TeamsId) == widget.id)
        .toList()
        .first;

    List<Match> matchs = [];
    matchs = provider.matchs.data
        .where((element) => ((int.parse(element.homeTeamId) == widget.id ||
                int.parse(element.awayTeamId) == widget.id) &&
            (element.id != widget.idmatch)))
        .toList();
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Container(
        color: Colors.white,
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 8, right: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          radius: 18,
                          backgroundColor: Colors.grey,
                          child: CircleAvatar(
                            radius: 17.0,
                            backgroundImage: NetworkImage(team.flag),
                            backgroundColor: Colors.transparent,
                          ),
                        ),
                      ),
                      Text(
                        team.nameEn + " Matchs",
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: MyColors.firsteColor),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Divider(
              endIndent: 50,
              indent: 8,
              color: MyColors.firsteColor,
            ),
            Column(
              children: List.generate(
                  matchs.length, (index) => MatchItem(matchs[index].id, true)),
            ),
          ],
        ),
      ),
    );
  }
}
