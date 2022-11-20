// ignore_for_file: prefer_const_literals_to_create_immutables, use_key_in_widget_constructors, must_be_immutable, prefer_const_constructors, avoid_unnecessary_containers, unnecessary_import, file_names, prefer_interpolation_to_compose_strings, unrelated_type_equality_checks, sized_box_for_whitespace, avoid_print, unnecessary_string_interpolations

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projet1/Model/Matchs.dart';
import 'package:projet1/constante/MyColors.dart';
import 'package:projet1/constante/device_Size.dart';
import 'package:projet1/fonction/function.dart';
import 'package:projet1/mobile/MatchView.dart';
import 'package:projet1/provider/AllTeam.dart';
import 'package:projet1/web/WMatch_View.dart';
import 'package:provider/provider.dart';

class MatchItem extends StatefulWidget {
  int id;
  bool isCliked;
  MatchItem(this.id, this.isCliked);

  @override
  State<MatchItem> createState() => _MatchItemState();
}

class _MatchItemState extends State<MatchItem> {
  List<Match> match = [];
  bool isHover = false;

  @override
  Widget build(BuildContext context) {
    Team_provider provider = Provider.of<Team_provider>(context);
    Match match =
        provider.matchs.data.where((element) => element.id == widget.id).first;
    bool started = isStareMatch(match);
    return InkWell(
      onFocusChange: (val) {
        setState(() {
          isHover = !isHover;
        });
      },
      onTap: () {
        if (widget.isCliked) {
          if (Scrinetype.isMobile) {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return DetaillMatch(widget.id);
            }));
          }
          if (Scrinetype.isWeb) {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return WDetaillMatch(widget.id);
            }));
          }
        }
      },
      child: Card(
        color: isHover ? MyColors.firsteColor : MyColors.secondColor,
        elevation: 5,
        child: Container(
          width: double.infinity,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                    "Coupe Du Monde, " +
                        match.type +
                        " " +
                        (match.group.isNotEmpty ? match.group : "") +
                        (match.matchday != ""
                            ? ", journée " + match.matchday.toString()
                            : ""),
                    style: TextStyle(
                      color:
                          isHover ? MyColors.HoverColor : MyColors.firsteColor,
                    )),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.grey,
                            radius: 18,
                            child: CircleAvatar(
                              radius: 17.0,
                              backgroundImage: NetworkImage(match.homeFlag),
                              backgroundColor: Colors.transparent,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(match.homeTeamEn,
                              style: TextStyle(
                                  color: isHover
                                      ? MyColors.HoverColor
                                      : MyColors.firsteColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12))
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        started
                            ? Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(
                                  match.homeScore.toString(),
                                  style: TextStyle(
                                    fontSize: 25,
                                    color: match.finished == "TRUE"
                                        ? Colors.grey
                                        : Colors.red,
                                  ),
                                ),
                              )
                            : Container(),
                        Column(
                          children: [
                            Text(
                                "${match.localDate.day}.${match.localDate.month}.${match.localDate.year}",
                                style: TextStyle(
                                    color: isHover
                                        ? MyColors.HoverColor
                                        : MyColors.firsteColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12)),
                            Text(
                                "${match.localDate.toString().split(" ")[1].substring(0, 5)}",
                                style: TextStyle(
                                    color: isHover
                                        ? MyColors.HoverColor
                                        : MyColors.firsteColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12))
                          ],
                        ),
                        started
                            ? Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(match.awayScore.toString(),
                                    style: TextStyle(
                                      fontSize: 25,
                                      color: match.finished == "TRUE"
                                          ? Colors.grey
                                          : Colors.red,
                                    )),
                              )
                            : Container(),
                      ],
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.grey,
                            radius: 18,
                            child: CircleAvatar(
                              radius: 17.0,
                              backgroundImage: NetworkImage(match.awayFlag),
                              backgroundColor: Colors.transparent,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(match.awayTeamEn,
                              style: TextStyle(
                                  color: isHover
                                      ? MyColors.HoverColor
                                      : MyColors.firsteColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12))
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
