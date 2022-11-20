// ignore_for_file: file_names, avoid_unnecessary_containers, unused_local_variable, prefer_const_constructors, prefer_interpolation_to_compose_strings, non_constant_identifier_names, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:projet1/Model/users.dart';
import 'package:projet1/compopente/UserItem.dart';
import 'package:projet1/compopente/bestAtack.dart';
import 'package:projet1/compopente/bestDefender.dart';
import 'package:projet1/compopente/matchItem.dart';
import 'package:projet1/constante/MyColors.dart';
import 'package:projet1/provider/AllTeam.dart';
import 'package:projet1/provider/Users_Prpvider.dart';
import 'package:projet1/web/WListe_Users.dart';
import 'package:provider/provider.dart';
import 'package:projet1/Model/Matchs.dart';

class CenterPage extends StatefulWidget {
  const CenterPage({super.key});

  @override
  State<CenterPage> createState() => _CenterPageState();
}

class _CenterPageState extends State<CenterPage> {
  Team_provider provider = Team_provider();
  User_Provider User_Prov = User_Provider();

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<Team_provider>(context);
    User_Prov = Provider.of<User_Provider>(context);

    return Scaffold(
      body: Container(
        color: Colors.transparent,
        child: Container(
          child: SingleChildScrollView(
            physics:
                BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            child: Column(
              children: [
                theBestThree(),
                matchDay(),
                BestAtack(3),
                BestDefence(3)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget theBestThree() {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 8.0, left: 8, right: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Les Meilleurs Joueur",
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: MyColors.firsteColor),
                  ),
                  InkWell(
                    hoverColor: MyColors.HoverColor,
                    focusColor: MyColors.HoverColor,
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return WListUsers();
                      }));
                    },
                    onFocusChange: ((value) {}),
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
            Column(
              children: List.generate(
                  User_Prov.users.length > 3 ? 3 : User_Prov.users.length,
                  (index) {
                return UsersItems(User_Prov.users[index], index, false);
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget matchDay() {
    bool b = false;
    DateTime now = DateTime.now();
    List<Match> matchs = [];
    if (provider.matchs.data.isNotEmpty) {
      matchs = provider.matchs.data
          .where((element) =>
              element.localDate.day == now.day &&
              element.localDate.month == now.month)
          .toList();
    }

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
                  Text(
                    "Les Match D'aujourd'hui",
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
              children: matchs.isNotEmpty
                  ? List.generate(matchs.length,
                      (index) => MatchItem(matchs[index].id, true))
                  : [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          elevation: 5,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                                width: double.infinity,
                                child: Center(
                                  child: Text(
                                    "Aucun Match Aujourd'hui",
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: MyColors.firsteColor),
                                  ),
                                )),
                          ),
                        ),
                      )
                    ],
            ),
          ],
        ),
      ),
    );
  }
}
