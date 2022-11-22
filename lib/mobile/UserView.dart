// ignore_for_file: prefer_const_constructors, duplicate_ignore, use_key_in_widget_constructors, avoid_unnecessary_containers, prefer_interpolation_to_compose_strings, file_names, must_be_immutable, must_call_super, sized_box_for_whitespace, non_constant_identifier_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projet1/Model/Matchs.dart';
import 'package:projet1/Model/tawaqoa.dart';
import 'package:projet1/Model/users.dart';
import 'package:projet1/compopente/Match_prediction.dart';
import 'package:projet1/compopente/UserItem.dart';
import 'package:projet1/compopente/matchItem.dart';
import 'package:projet1/constante/MyColors.dart';
import 'package:projet1/fonction/function.dart';
import 'package:projet1/main.dart';

class UserView extends StatefulWidget {
  Usr user;
  int classement;
  UserView(this.user, this.classement);
  @override
  State<UserView> createState() => _UserViewState();
}

class _UserViewState extends State<UserView> {
  List<Match> matchs = [];
  List<Tawa9oa> taw = [];
  @override
  void initState() {
    matchs = MyApp.provider.matchs.data;
    taw = widget.user.taw;

    taw.sort((b, a) => a.pts!.compareTo(b.pts!));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: Container(
        height: double.infinity,
        child: SingleChildScrollView(
          physics:
              BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: UsersItems(widget.user, widget.classement, false),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: matchs.isNotEmpty
                    ? ListeTawa9o3()
                    : Card(
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
                      ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget ListeTawa9o3() {
    return Container(
      color: MyColors.secondColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Les Prédiction De " + widget.user.nom,
              style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: MyColors.firsteColor),
            ),
          ),
          Divider(
            endIndent: 50,
            indent: 8,
            color: MyColors.firsteColor,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Items(),
          )
        ],
      ),
    );
  }

  Widget Items() {
    return Container(
        child: Column(
      children: List.generate(taw.length, (index) {
        return Item(taw[index]);
      }),
    ));
  }

  Widget Item(Tawa9oa tawa9oa) {
    if (!isStareMatchById(tawa9oa.id)) {
      if (FirebaseAuth.instance.currentUser!.email == widget.user.email) {
        return Match_prediction(GetMatchById(tawa9oa.id!), widget.user.email);
      }
      return MatchItem(tawa9oa.id!, true);
    }

    if (tawa9oa.awayEx != -1) {
      return ResExacte(tawa9oa);
    }
    return Prob(tawa9oa);
  }

  Widget Prob(Tawa9oa tawa9oa) {
    Match match = GetMatchById(tawa9oa.id!);

    return InkWell(
      child: Container(
        width: double.infinity,
        child: Card(
          elevation: 5,
          child: Padding(
            padding: EdgeInsets.all(12.0),
            child: Column(
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
                Divider(
                  color: MyColors.firsteColor,
                  height: 5,
                  thickness: 1,
                  indent: 0,
                  endIndent: 0,
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
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
                            match.homeTeamEn,
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: MyColors.firsteColor),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      match.homeScore.toString(),
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Colors.green),
                    ),
                    Text(
                      "-",
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: MyColors.firsteColor),
                    ),
                    Text(
                      match.awayScore.toString(),
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Colors.green),
                    ),
                    Column(
                      children: [
                        CircleAvatar(
                          radius: 17.0,
                          backgroundImage: NetworkImage(match.awayFlag),
                          backgroundColor: Colors.transparent,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            match.awayTeamEn,
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: MyColors.firsteColor),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: Center(
                        child: Text(
                          "Type",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: MyColors.firsteColor),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          "Choix",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: MyColors.firsteColor),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          "Points",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: MyColors.firsteColor),
                        ),
                      ),
                    ),
                  ],
                ),
                Divider(color: MyColors.firsteColor),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Max Buts",
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: MyColors.firsteColor),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Min Buts",
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: MyColors.firsteColor),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Gagnant",
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: MyColors.firsteColor),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            tawa9oa.maxBut == -1
                                ? "--"
                                : tawa9oa.maxBut.toString(),
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: MyColors.firsteColor),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            tawa9oa.minBut == -1
                                ? "--"
                                : tawa9oa.minBut.toString(),
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: MyColors.firsteColor),
                          ),
                          SizedBox(
                            height: 5,
                          ),
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
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            maxBt(tawa9oa.maxBut!,
                                        match.awayScore + match.homeScore)
                                    .toString() +
                                " Pts",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: MyColors.firsteColor),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            minBt(tawa9oa.minBut!,
                                        match.awayScore + match.homeScore)
                                    .toString() +
                                " Pts",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: MyColors.firsteColor),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            gang(tawa9oa.qagne!, match.homeScore,
                                        match.awayScore)
                                    .toString() +
                                " Pts",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: MyColors.firsteColor),
                          )
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget ResExacte(Tawa9oa tawa9oa) {
    Match match = GetMatchById(tawa9oa.id!);

    return InkWell(
      child: Card(
          elevation: 5,
          child: Container(
            width: double.infinity,
            child: Padding(
              padding: EdgeInsets.all(12.0),
              child: Column(
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
                  Divider(
                    color: MyColors.firsteColor,
                    height: 5,
                    thickness: 1,
                    indent: 0,
                    endIndent: 0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
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
                              match.homeTeamEn,
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: MyColors.firsteColor),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            tawa9oa.homeEx.toString(),
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: MyColors.firsteColor),
                          ),
                          Text(
                            match.homeScore.toString(),
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: Colors.green),
                          ),
                        ],
                      ),
                      Text(
                        "-",
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: MyColors.firsteColor),
                      ),
                      Column(
                        children: [
                          Text(
                            tawa9oa.awayEx.toString(),
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: MyColors.firsteColor),
                          ),
                          Text(
                            match.awayScore.toString(),
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: Colors.green),
                          ),
                        ],
                      ),
                      Column(
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
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              match.awayTeamEn,
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: MyColors.firsteColor),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )),
    );
  }

  AppBar? appBar() {
    return AppBar(
      title: Text(
        widget.user.nom,
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
            // ignore: prefer_const_constructors
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
