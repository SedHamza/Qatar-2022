// ignore_for_file: file_names, use_key_in_widget_constructors, prefer_interpolation_to_compose_strings, prefer_const_constructors, must_be_immutable, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:projet1/Model/Matchs.dart';
import 'package:projet1/compopente/groupeItem.dart';
import 'package:projet1/compopente/matchItem.dart';
import 'package:projet1/constante/MyColors.dart';
import 'package:projet1/main.dart';

class GroupeView extends StatefulWidget {
  int index;
  GroupeView(this.index);

  @override
  State<GroupeView> createState() => _GroupeViewState();
}

class _GroupeViewState extends State<GroupeView> {
  String T = "ABCDEFGH";
  List<Match> matchs = [];
  @override
  void initState() {
    matchs = MyApp.provider.matchs.data
        .where((element) => element.group == T[widget.index])
        .toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: Container(
        child: SingleChildScrollView(
          physics:
              BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          child: Column(
            children: [
              GroupeItem(widget.index),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: List.generate(
                      matchs.length,
                      (index) => Container(
                            child: MatchItem(matchs[index].id, true),
                          )),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  AppBar? appBar() {
    return AppBar(
      title: Text(
        "Groupe " + T[widget.index],
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
