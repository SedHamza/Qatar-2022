// ignore_for_file: file_names, must_call_super, prefer_const_constructors, prefer_interpolation_to_compose_strings, use_key_in_widget_constructors, avoid_unnecessary_containers, non_constant_identifier_names, avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projet1/Model/Matchs.dart';
import 'package:projet1/Model/tawaqoa.dart';
import 'package:projet1/Model/users.dart';
import 'package:projet1/compopente/Match_prediction.dart';
import 'package:projet1/compopente/matchItem.dart';
import 'package:projet1/constante/MyColors.dart';
import 'package:projet1/fonction/function.dart';
import 'package:projet1/main.dart';
import 'package:projet1/provider/Users_Prpvider.dart';
import 'package:provider/provider.dart';

class WListUsers extends StatefulWidget {
  @override
  State<WListUsers> createState() => _WListUsersState();
}

class _WListUsersState extends State<WListUsers> {
  Usr selectedUser = Usr("nom", "email", 0);
  List<Tawa9oa> taw = [];
  List<Color> clrs = [
    Colors.amber,
    Color.fromARGB(255, 165, 134, 11),
    Color.fromARGB(255, 152, 128, 128)
  ];
  User_Provider User_Prov = User_Provider();
  bool isHoverd = false;
  @override
  void initState() {}

  @override
  Widget build(BuildContext context) {
    User_Prov = Provider.of<User_Provider>(context);
    User_Prov.users.sort(
      (b, a) {
        if (a.pts == b.pts) {
          return (-a.taw.length).compareTo((-b.taw.length));
        }
        return a.pts.compareTo(b.pts);
      },
    );
    return Scaffold(
      appBar: appBar(),
      body: Container(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 4,
              child: Container(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: List.generate(User_Prov.users.length, (index) {
                        return Item(index);
                      }),
                    ),
                  ),
                ),
              ),
            ),
            VerticalDivider(
              indent: 10,
              endIndent: 10,
              width: 0,
              color: MyColors.firsteColor,
            ),
            Expanded(
              flex: 7,
              child: Container(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: List.generate(taw.length, (index) {
                        Match match = MyApp.provider.matchs.data.firstWhere(
                            (element) => element.id == taw[index].id);
                        return preT(match, taw[index]);
                      }),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget Item(int index) {
    return InkWell(
      focusColor: MyColors.firsteColor,
      onFocusChange: ((value) {
        setState(() {
          selectedUser = User_Prov.users[index];
          taw = selectedUser.taw;
          taw.sort((b, a) => a.pts!.compareTo(b.pts!));
        });
      }),
      onTap: () {},
      child: Container(
        child: Card(
          elevation: 5,
          child: Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    (index + 1).toString(),
                    style: TextStyle(
                        color: (index < 3) ? clrs[index] : MyColors.firsteColor,
                        fontSize: 25,
                        fontStyle: FontStyle.italic),
                  ),
                ),
                Icon(
                  Icons.person,
                  color: (index < 3) ? clrs[index] : MyColors.firsteColor,
                  size: 30,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              User_Prov.users[index].nom,
                              style: TextStyle(
                                color: (index < 3)
                                    ? clrs[index]
                                    : MyColors.firsteColor,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              User_Prov.users[index].pts.toString() +
                                  " Pts / " +
                                  User_Prov.users[index].taw.length.toString() +
                                  " Matchs",
                              style: TextStyle(
                                color: (index < 3)
                                    ? clrs[index]
                                    : MyColors.firsteColor,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget preT(Match match, Tawa9oa tawa9oa) {
    if (!isStareMatch(match)) {
      if (FirebaseAuth.instance.currentUser!.email == selectedUser.email) {
        return Match_prediction(match, selectedUser.email);
      }
      return MatchItem(match.id, true);
    }
    if (tawa9oa.homeEx != -1) {
      return InkWell(
        focusColor: MyColors.firsteColor,
        onTap: () {},
        child: Card(
          elevation: 5,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Résultat Exacte :",
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: MyColors.firsteColor),
                    ),
                    Text(
                      tawa9oa.pts.toString() +
                          " /" +
                          maxPts(tawa9oa).toString() +
                          " Pts",
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: MyColors.firsteColor),
                    ),
                  ],
                ),
                Divider(color: MyColors.firsteColor),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    Text(
                      tawa9oa.homeEx.toString(),
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: MyColors.firsteColor),
                    ),
                    Text(
                      "-",
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: MyColors.firsteColor),
                    ),
                    Text(
                      tawa9oa.awayEx.toString(),
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: MyColors.firsteColor),
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.grey,
                      radius: 18,
                      child: CircleAvatar(
                        radius: 17.0,
                        backgroundImage: NetworkImage(match.awayFlag),
                        backgroundColor: Colors.transparent,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    }
    return InkWell(
      focusColor: MyColors.firsteColor,
      onTap: () {},
      child: Card(
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Prédiction De Match",
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: MyColors.firsteColor),
                  ),
                  Text(
                    tawa9oa.pts.toString() +
                        " /" +
                        maxPts(tawa9oa).toString() +
                        " Pts",
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: MyColors.firsteColor),
                  ),
                ],
              ),
              Divider(color: MyColors.firsteColor),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(
                        "Match",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: MyColors.firsteColor),
                      ),
                      Divider(color: MyColors.firsteColor),
                      Row(
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
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "-",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: MyColors.firsteColor),
                            ),
                          ),
                          CircleAvatar(
                            backgroundColor: Colors.grey,
                            radius: 18,
                            child: CircleAvatar(
                              radius: 17.0,
                              backgroundImage: NetworkImage(match.awayFlag),
                              backgroundColor: Colors.transparent,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        "Max des Butes",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: MyColors.firsteColor),
                      ),
                      Divider(color: MyColors.firsteColor),
                      Text(
                        tawa9oa.maxBut != -1 ? tawa9oa.maxBut.toString() : "--",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: MyColors.firsteColor),
                      ),
                      Divider(color: MyColors.firsteColor),
                      Text(
                        maxBt(tawa9oa.maxBut!,
                                    match.awayScore + match.homeScore)
                                .toString() +
                            " Pts",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: MyColors.firsteColor),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        "Min des Butes",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: MyColors.firsteColor),
                      ),
                      Divider(color: MyColors.firsteColor),
                      Text(
                        tawa9oa.minBut != -1 ? tawa9oa.minBut.toString() : "--",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: MyColors.firsteColor),
                      ),
                      Divider(color: MyColors.firsteColor),
                      Text(
                        minBt(tawa9oa.minBut!,
                                    match.awayScore + match.homeScore)
                                .toString() +
                            " Pts",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: MyColors.firsteColor),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        "Qui Gagne",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: MyColors.firsteColor),
                      ),
                      Divider(color: MyColors.firsteColor),
                      Text(
                        tawa9oa.qagne != -1
                            ? (tawa9oa.qagne == 0
                                ? "Egalité"
                                : (tawa9oa.qagne == 1
                                    ? match.homeTeamEn
                                    : match.awayTeamEn))
                            : "--",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: MyColors.firsteColor),
                      ),
                      Divider(color: MyColors.firsteColor),
                      Text(
                        gang(tawa9oa.qagne!, match.homeScore, match.awayScore)
                                .toString() +
                            " Pts",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: MyColors.firsteColor),
                      )
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  AppBar? appBar() {
    return AppBar(
      title: Text(
        "Les Meilleurs Joueurs",
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

  int maxBt(int tM, int mM) {
    if (tM == -1) {
      return 0;
    }
    if (tM >= mM) {
      return (7 - tM) * 2;
    }
    return 0;
  }

  int minBt(int tM, int mM) {
    if (tM == -1) {
      return 0;
    }
    if (tM <= mM) {
      return tM * 2;
    }
    return 0;
  }

  int gang(int tM, int hb, int ab) {
    if (tM == 0 && hb == ab) {
      return 5;
    }
    if (tM == 1 && hb > ab) {
      return 5;
    }
    if (tM == 2 && hb < ab) {
      return 5;
    }
    return 0;
  }

  int maxPts(Tawa9oa tawa9oa) {
    int mx = 0;
    if (tawa9oa.homeEx != -1) {
      return 25;
    }
    if (tawa9oa.maxBut != -1) {
      mx = (7 - tawa9oa.maxBut!) * 2;
    }
    if (tawa9oa.minBut != -1) {
      mx += tawa9oa.minBut! * 2;
    }
    if (tawa9oa.qagne != -1) {
      mx += 5;
    }
    return mx;
  }
}
