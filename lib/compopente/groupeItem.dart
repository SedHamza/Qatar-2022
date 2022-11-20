// ignore_for_file: file_names, must_be_immutable, use_key_in_widget_constructors, prefer_const_constructors, sized_box_for_whitespace, prefer_interpolation_to_compose_strings, avoid_print, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:projet1/Model/Standings.dart';
import 'package:projet1/constante/MyColors.dart';
import 'package:projet1/mobile/groupeView.dart';
import 'package:projet1/provider/AllTeam.dart';
import 'package:provider/provider.dart';

class GroupeItem extends StatefulWidget {
  int index;
  bool is_clicked;
  GroupeItem(this.index, this.is_clicked);

  @override
  State<GroupeItem> createState() => _GroupeItemState();
}

class _GroupeItemState extends State<GroupeItem> {
  String T = "ABCDEFGH";
  Team_provider provider = Team_provider();
  bool isHover = false;

  @override
  void initState() {
    provider = Provider.of<Team_provider>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 8.0, left: 8, right: 8),
        child: group());
  }

  Widget group() {
    return InkWell(
      onFocusChange: (val) {
        setState(() {
          isHover = !isHover;
        });
      },
      onTap: () {
        if (widget.is_clicked) {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return GroupeView(widget.index);
          }));
        }
      },
      child: Card(
        color: isHover ? MyColors.HoverColor : MyColors.firsteColor,
        elevation: 2,
        child: Column(
          children: [headerGRP(T[widget.index]), bodyGRP(T[widget.index])],
        ),
      ),
    );
  }

  Widget headerGRP(String c) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 6, left: 16, right: 8),
          child: Container(
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Groupe " + c,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: MyColors.secondColor),
                ),
                Icon(
                  Icons.info_outline,
                  color: MyColors.secondColor,
                )
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Container(
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 180,
                  child: Row(
                    children: [
                      Container(
                          decoration: BoxDecoration(
                              color: MyColors.secondColor,
                              shape: BoxShape.circle),
                          child: Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Text(
                              "#",
                              style: TextStyle(
                                  color: MyColors.firsteColor,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic),
                            ),
                          )),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "Equipe",
                        style: TextStyle(color: MyColors.secondColor),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Text(
                          "P",
                          style: TextStyle(
                              color: MyColors.secondColor, fontSize: 12),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Text(
                          "G",
                          style: TextStyle(
                              color: MyColors.secondColor, fontSize: 12),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Text(
                          "D",
                          style: TextStyle(
                              color: MyColors.secondColor, fontSize: 12),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Text(
                          "N",
                          style: TextStyle(
                              color: MyColors.secondColor, fontSize: 12),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Center(
                          child: Text(
                            "PTS",
                            style: TextStyle(
                                color: MyColors.secondColor, fontSize: 12),
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
      ],
    );
  }

  Widget bodyGRP(String g) {
    if (provider.classement.data != null) {
      Groupe grp = provider.classement.data!
          .where((element) => element.group == g)
          .toList()
          .first;

      return Card(
        elevation: 2,
        child: Column(
          children: List.generate(grp.teams.length, (index) {
            Team team = grp.teams[index];
            return Padding(
              padding: EdgeInsets.all(4.0),
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 180,
                      child: Row(
                        children: [
                          Container(
                              decoration: BoxDecoration(
                                  color: (index + 1) > 2
                                      ? Colors.red
                                      : Colors.green,
                                  shape: BoxShape.circle),
                              child: Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: Text(
                                  (index + 1).toString(),
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FontStyle.italic,
                                      fontSize: 10),
                                ),
                              )),
                          SizedBox(
                            width: 5,
                          ),
                          CircleAvatar(
                            radius: 10.0,
                            backgroundImage: NetworkImage(team.flag),
                            backgroundColor: Colors.transparent,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(team.nameEn,
                              style: TextStyle(
                                  fontStyle: FontStyle.italic, fontSize: 12))
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Expanded(
                            child: Text(
                              team.mp,
                              style: TextStyle(
                                  fontStyle: FontStyle.italic, fontSize: 12),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Text(
                              team.w,
                              style: TextStyle(
                                  fontStyle: FontStyle.italic, fontSize: 12),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Text(
                              team.l,
                              style: TextStyle(
                                  fontStyle: FontStyle.italic, fontSize: 12),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Text(
                              (int.parse(team.mp) -
                                      int.parse(team.w) -
                                      int.parse(team.l))
                                  .toString(),
                              style: TextStyle(
                                  fontStyle: FontStyle.italic, fontSize: 12),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Center(
                              child: Text(
                                team.pts,
                                style: TextStyle(
                                    fontStyle: FontStyle.italic, fontSize: 12),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          }),
        ),
      );
    }
    return Container();
  }
}
