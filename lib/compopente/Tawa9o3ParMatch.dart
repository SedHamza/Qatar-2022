// ignore_for_file: use_key_in_widget_constructors, must_be_immutable, prefer_const_constructors, sized_box_for_whitespace, prefer_interpolation_to_compose_strings, file_names, non_constant_identifier_names, avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projet1/Model/Matchs.dart';
import 'package:projet1/Model/tawaqoa.dart';
import 'package:projet1/Model/users.dart';
import 'package:projet1/constante/MyColors.dart';
import 'package:projet1/fonction/function.dart';
import 'package:projet1/provider/Users_Prpvider.dart';
import 'package:provider/provider.dart';

class Tawaqo3ParMatch extends StatefulWidget {
  Match match;
  Tawaqo3ParMatch(this.match);

  @override
  State<Tawaqo3ParMatch> createState() => _Tawaqo3ParMatchState();
}

class _Tawaqo3ParMatchState extends State<Tawaqo3ParMatch> {
  List<Usr> users = [];
  bool Existe = false;
  @override
  void initState() {
    List<Usr> lst = [];
    User_Provider User_Prov =
        Provider.of<User_Provider>(context, listen: false);
    users = User_Prov.users
        .where((element) =>
            element.email != FirebaseAuth.instance.currentUser!.email)
        .toList();
    for (var element in users) {
      if (element.taw
          .where((element) => element.id == widget.match.id)
          .isNotEmpty) {
        setState(() {
          lst.add(element);
          Existe = true;
        });
      }
    }
    users.clear();
    users.addAll(lst);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (!Existe) {
      return InkWell(
        focusColor: MyColors.HoverColor,
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: double.infinity,
                  child: Center(
                    child: Text(
                      textAlign: TextAlign.center,
                      "Aucun Prédiction Pour Ce Match",
                      style:
                          TextStyle(fontSize: 15, color: MyColors.firsteColor),
                    ),
                  ),
                ),
              )),
        ),
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(users.length, (index) {
        return users[index]
                .taw
                .where((element) => element.id == widget.match.id)
                .isNotEmpty
            ? userTawa9o3(users[index])
            : SizedBox();
      }),
    );
  }

  Widget userTawa9o3(Usr user) {
    return Container(
      width: double.infinity,
      child: tawa9o3(user.nom,
          user.taw.firstWhere((element) => element.id == widget.match.id)),
    );
  }

  Widget tawa9o3(String nom, Tawa9oa tawa9oa) {
    if (!isStareMatchById(tawa9oa.id)) {
      return InkWell(
        onTap: () {},
        focusColor: MyColors.HoverColor,
        child: Card(
            elevation: 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    nom + " :",
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: MyColors.firsteColor),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Les données non disponibles actuellement seront disponibles au début du match",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 15, color: MyColors.firsteColor),
                  ),
                )
              ],
            )),
      );
    }

    if (tawa9oa.awayEx != -1) {
      return ResExacte(nom, tawa9oa);
    }
    return Prob(nom, tawa9oa);
  }

  Widget Prob(String nom, Tawa9oa tawa9oa) {
    Match match = GetMatchById(tawa9oa.id!);

    return InkWell(
      focusColor: MyColors.HoverColor,
      onTap: () {},
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
                      nom,
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
                            "Gagne",
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
                            tawa9oa.maxBut == -1
                                ? "0"
                                : maxBt(tawa9oa.maxBut!,
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

  Widget ResExacte(String nom, Tawa9oa tawa9oa) {
    Match match = GetMatchById(tawa9oa.id!);

    return InkWell(
      focusColor: MyColors.HoverColor,
      onTap: () {},
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
                        nom + " :",
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
