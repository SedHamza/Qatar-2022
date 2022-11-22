// ignore_for_file: file_names, prefer_const_constructors, must_be_immutable, use_key_in_widget_constructors, sized_box_for_whitespace, avoid_unnecessary_containers, prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:projet1/Model/Team.dart';
import 'package:projet1/constante/MyColors.dart';
import 'package:projet1/main.dart';

class BestDefence extends StatefulWidget {
  int length;
  BestDefence(this.length);

  @override
  State<BestDefence> createState() => _BestDefenceState();
}

class _BestDefenceState extends State<BestDefence> {
  List<Teams> teams = [];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    teams = MyApp.provider.teamList;
    if (widget.length != 3 || teams.isEmpty) {
      widget.length = teams.length;
    }
    teams.sort(
      (a, b) {
        if (a.GA == b.GA) {
          if (a.matchs != b.matchs) {
            return (-a.matchs).compareTo(-b.matchs);
          }
          return (-a.GF).compareTo(-b.GF);
        }
        return a.GA.compareTo(b.GA);
      },
    );
    return AnimatedContainer(
      duration: Duration(seconds: 3),
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Container(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8.0, left: 8, right: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Meilleure Défense",
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: MyColors.firsteColor),
                    ),
                    InkWell(
                      focusColor: MyColors.HoverColor,
                      onTap: () {
                        setState(() {
                          if (widget.length == 3) {
                            widget.length = teams.length;
                          } else {
                            widget.length = 3;
                          }
                        });
                      },
                      child: Icon(
                        Icons.open_in_full_rounded,
                        color: MyColors.firsteColor,
                      ),
                    )
                  ],
                ),
              ),
              Divider(
                endIndent: 50,
                indent: 8,
                color: MyColors.firsteColor,
              ),
              SizedBox(
                height: 5,
              ),
              Card(
                elevation: 20,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8, right: 8),
                        child: Row(
                          children: [
                            Container(
                              width: 200,
                              child: Row(
                                children: [
                                  Container(
                                    width: 20,
                                    child: Text(
                                      "#",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: MyColors.firsteColor),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                    child: Text(
                                      "é".toUpperCase() + "quipe",
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: MyColors.firsteColor),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Container(
                                      child: Center(
                                        child: Text(
                                          "B",
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                              color: MyColors.firsteColor),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Expanded(
                                    child: Container(
                                      child: Center(
                                        child: Text(
                                          "M",
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                              color: MyColors.firsteColor),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Expanded(
                                    child: Container(
                                      child: Center(
                                        child: Text(
                                          "B/M",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                              color: MyColors.firsteColor),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Divider(
                        indent: 8,
                        thickness: 2,
                        color: MyColors.firsteColor,
                      ),
                      Column(
                        children: List.generate(widget.length, (index) {
                          return item(teams[index], index);
                        }),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget item(Teams team, int index) {
    return Column(
      children: [
        InkWell(
          focusColor: MyColors.HoverColor,
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                Container(
                  width: 200,
                  child: Row(
                    children: [
                      Container(
                        width: 20,
                        child: Text(
                          (index + 1).toString(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 12, color: MyColors.firsteColor),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 11.0,
                            backgroundColor: Colors.grey,
                            child: CircleAvatar(
                              radius: 10.0,
                              backgroundImage: NetworkImage(team.flag),
                              backgroundColor: Colors.transparent,
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Container(
                            child: Text(
                              team.nameEn,
                              style: TextStyle(
                                  fontSize: 12, color: MyColors.firsteColor),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Container(
                          child: Center(
                            child: Text(
                              team.GA.toString(),
                              style: TextStyle(
                                  fontSize: 12, color: MyColors.firsteColor),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        child: Container(
                          child: Center(
                            child: Text(
                              team.matchs.toString(),
                              style: TextStyle(
                                  fontSize: 12, color: MyColors.firsteColor),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        child: Container(
                          child: Center(
                            child: Text(
                              team.matchs == 0
                                  ? "0"
                                  : (team.GA / team.matchs).toStringAsFixed(1),
                              style: TextStyle(
                                  fontSize: 12, color: MyColors.firsteColor),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        Divider(
          indent: 8,
          color: MyColors.firsteColor,
        ),
      ],
    );
  }
}
