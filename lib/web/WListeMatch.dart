// ignore_for_file: file_names, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:projet1/Model/Matchs.dart';
import 'package:projet1/compopente/matchItem.dart';
import 'package:projet1/constante/MyColors.dart';
import 'package:projet1/fonction/function.dart';
import 'package:projet1/provider/AllTeam.dart';
import 'package:provider/provider.dart';

class WListeMatch extends StatefulWidget {
  const WListeMatch({super.key});

  @override
  State<WListeMatch> createState() => _WListeMatchState();
}

class _WListeMatchState extends State<WListeMatch> {
  Team_provider provider = Team_provider();
  List<Match> matchs = [];
  @override
  Widget build(BuildContext context) {
    provider = Provider.of<Team_provider>(context);
    matchs = provider.matchs.data;
    List<DateTime> dates = existeDate(matchs);
    return Container(
      child: Container(
          child: SingleChildScrollView(
        // ignore: prefer_const_constructors
        physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        child: Column(
          children: List.generate(
              dates.length, (index) => listeDateMatch(dates[index])),
        ),
      )),
    );
  }

  Widget listeDateMatch(DateTime date) {
    List<Match> dtmatch = matchs
        .where((element) =>
            element.localDate.day == date.day &&
            element.localDate.month == date.month)
        .toList();
    dtmatch.sort(
      (a, b) => a.localDate.hour.compareTo(b.localDate.hour),
    );
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        color: Colors.white,
        width: double.infinity,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 8, right: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {},
                    child: Text(
                      "Les Matchs : ${date.day}-${date.month}-${date.year}",
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: MyColors.firsteColor),
                    ),
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
              children: List.generate(dtmatch.length,
                  (index) => MatchItem(dtmatch[index].id, true)),
            ),
          ],
        ),
      ),
    );
  }
}
