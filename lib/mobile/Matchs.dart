// ignore_for_file: prefer_const_constructors, file_names, avoid_unnecessary_containers, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:projet1/Model/Matchs.dart';
import 'package:projet1/compopente/matchItem.dart';
import 'package:projet1/constante/MyColors.dart';
import 'package:projet1/fonction/function.dart';
import 'package:projet1/provider/AllTeam.dart';
import 'package:provider/provider.dart';

class MatchsListe extends StatefulWidget {
  const MatchsListe({super.key});

  @override
  State<MatchsListe> createState() => _MatchsListeState();
}

class _MatchsListeState extends State<MatchsListe> {
  Team_provider provider = Team_provider();
  List<Match> matchs = [];
  @override
  Widget build(BuildContext context) {
    provider = Provider.of<Team_provider>(context);
    matchs = provider.matchs.data;
    List<DateTime> dates = existeDate(matchs);
    return Scaffold(
      appBar: appBar(),
      body: Container(
          child: SingleChildScrollView(
        physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        child: Column(
            children: dates.isNotEmpty
                ? List.generate(
                    dates.length, (index) => listeDateMatch(dates[index]))
                : [
                    Card(
                      child: Container(
                        width: double.infinity,
                        child: Center(
                            child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Problème de Connection",
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: MyColors.firsteColor),
                          ),
                        )),
                      ),
                    )
                  ]),
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
                  Text(
                    "Les Matchs : ${date.day}-${date.month}-${date.year}",
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: MyColors.firsteColor),
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

  AppBar? appBar() {
    return AppBar(
      title: Text(
        "Tous Les Matchs",
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
